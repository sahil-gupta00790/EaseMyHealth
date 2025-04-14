package main

import (
	"context"
	"database/sql"
	"encoding/json"
	"flag"
	"os"
	"strings"
	"sync"
	"time"

	_ "github.com/jackc/pgx/v5/stdlib"
	"github.com/joho/godotenv"
	"github.com/sahil-gupta00790/EaseMyHealth/backend/search/internal/data"
	"github.com/sirupsen/logrus"
)

const apiVersion = "v1"

// Config represents the application configuration
type Config struct {
	Port          int      `json:"port"`
	Env           string   `json:"env"`
	Database      DBConfig `json:"database"`
	Elasticsearch ESConfig `json:"elasticsearch"`
	Limiter       struct {
		RPS     float64 `json:"rps"`
		Burst   int     `json:"burst"`
		Enabled bool    `json:"enabled"`
	} `json:"limiter"`
	JWT struct {
		Secret string        `json:"secret"`
		Expiry time.Duration `json:"expiry"`
	} `json:"jwt"`
}

// DBConfig represents the database configuration
type DBConfig struct {
	DSN          string        `json:"dsn"`
	MaxOpenConns int           `json:"max_open_conns"`
	MaxIdleConns int           `json:"max_idle_conns"`
	MaxIdleTime  time.Duration `json:"max_idle_time"`
}

// ESConfig represents the Elasticsearch configuration
type ESConfig struct {
	Addresses []string `json:"addresses"`
	Username  string   `json:"username"`
	Password  string   `json:"password"`
	Index     string   `json:"index"`
	SyncData  bool     `json:"sync_data"`
}

type application struct {
	config Config
	logger *logrus.Logger
	wg     sync.WaitGroup
	models data.Models
	ES     *data.ElasticsearchClient
}

// LoadConfig loads the configuration from a file and applies flag overrides
func loadConfig(configPath string) (Config, error) {
	// Set default configuration
	config := Config{
		Port: 4001,
		Env:  "development",
		Database: DBConfig{
			DSN:          os.Getenv("DB_DSN"),
			MaxOpenConns: 25,
			MaxIdleConns: 25,
			MaxIdleTime:  time.Minute,
		},
		Elasticsearch: ESConfig{
			Addresses: []string{"http://localhost:9200"},
			Index:     "medications",
			SyncData:  false,
		},
	}
	config.Limiter.RPS = 2
	config.Limiter.Burst = 4
	config.Limiter.Enabled = false

	// If config file path provided, load from file
	if configPath != "" {
		file, err := os.ReadFile(configPath)
		if err != nil {
			return config, err
		}

		err = json.Unmarshal(file, &config)
		if err != nil {
			return config, err
		}
	}

	// Define flags but don't parse them yet
	flag.IntVar(&config.Port, "port", config.Port, "API server port")
	flag.StringVar(&config.Env, "env", config.Env, "Environment (development|staging|production)")
	flag.StringVar(&config.Database.DSN, "db-dsn", config.Database.DSN, "Postgres DSN")
	flag.IntVar(&config.Database.MaxOpenConns, "db-max-open-conns", config.Database.MaxOpenConns, "Postgres max open connections")
	flag.IntVar(&config.Database.MaxIdleConns, "db-max-idle-conns", config.Database.MaxIdleConns, "Postgres max idle connections")
	flag.DurationVar(&config.Database.MaxIdleTime, "db-max-idle-time", config.Database.MaxIdleTime, "Postgres max idle time")
	flag.Float64Var(&config.Limiter.RPS, "limiter-rps", config.Limiter.RPS, "Rate limiter maximum requests per second")
	flag.IntVar(&config.Limiter.Burst, "limiter-burst", config.Limiter.Burst, "Rate limiter maximum burst")
	flag.BoolVar(&config.Limiter.Enabled, "limiter-enabled", config.Limiter.Enabled, "Enable rate limiter")

	// Elasticsearch flags
	esAddresses := flag.String("es-addresses", strings.Join(config.Elasticsearch.Addresses, ","), "Elasticsearch addresses (comma separated)")
	esUsername := flag.String("es-username", config.Elasticsearch.Username, "Elasticsearch username")
	esPassword := flag.String("es-password", config.Elasticsearch.Password, "Elasticsearch password")
	esIndex := flag.String("es-index", config.Elasticsearch.Index, "Elasticsearch index name")
	syncData := flag.Bool("sync-data", config.Elasticsearch.SyncData, "Sync data from PostgreSQL to Elasticsearch on startup")

	// Parse flags
	flag.Parse()

	// Update config with flag values
	if *esAddresses != "" {
		config.Elasticsearch.Addresses = strings.Split(*esAddresses, ",")
	}
	config.Elasticsearch.Username = *esUsername
	config.Elasticsearch.Password = *esPassword
	config.Elasticsearch.Index = *esIndex
	config.Elasticsearch.SyncData = *syncData

	return config, nil
}

func main() {
	logger := logrus.New()
	logger.SetFormatter(&logrus.TextFormatter{
		FullTimestamp: true,
	})

	// Load .env file
	e := godotenv.Load("../../.env")
	if e != nil {
		logger.WithFields(
			logrus.Fields{
				"error": e,
			}).Warn("Error Loading .env file")
	}

	// Load configuration
	cfg, err := loadConfig("")
	if err != nil {
		logger.WithField("error", err).Fatal("Failed to load configuration")
	}

	// Configure logger based on environment
	if cfg.Env == "development" {
		logger.SetLevel(logrus.DebugLevel)
	} else {
		logger.SetLevel(logrus.InfoLevel)
	}

	// Open database connection
	db, err := openDB(cfg.Database)
	if err != nil {
		logger.WithField("error", err).Fatal("Failed to connect to database")
	}
	defer db.Close()
	logger.WithField("Database", "Connected").Info("Database connection established")

	// Initialize Elasticsearch client
	es, err := data.NewElasticsearchClient(
		cfg.Elasticsearch.Addresses,
		cfg.Elasticsearch.Username,
		cfg.Elasticsearch.Password,
		cfg.Elasticsearch.Index,
	)
	if err != nil {
		logger.WithField("error", err).Fatal("Failed to initialize Elasticsearch client")
	}
	logger.Info("Elasticsearch client initialized")

	// Create index if it doesn't exist
	if err := es.CreateIndex(); err != nil {
		logger.WithField("error", err).Fatal("Failed to create Elasticsearch index")
	}
	logger.Info("Elasticsearch index checked/created")

	// Sync data if requested
	if cfg.Elasticsearch.SyncData {
		logger.Info("Syncing data from PostgreSQL to Elasticsearch...")
		if err := data.SyncMedicationsToElasticsearch(db, es); err != nil {
			logger.WithField("error", err).Fatal("Failed to sync data")
		}
		logger.Info("Data sync completed")
	}

	// Initialize application
	app := &application{
		config: cfg,
		logger: logger,
		models: data.NewModels(db),
		ES:     es,
	}

	// Start the server
	err = app.server()
	if err != nil {
		logger.WithField("error", err).Fatal("Server error")
	}
}

func openDB(cfg DBConfig) (*sql.DB, error) {
	db, err := sql.Open("pgx", cfg.DSN)
	if err != nil {
		return nil, err
	}

	db.SetMaxIdleConns(cfg.MaxIdleConns)
	db.SetMaxOpenConns(cfg.MaxOpenConns)
	db.SetConnMaxIdleTime(cfg.MaxIdleTime)

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	err = db.PingContext(ctx)
	if err != nil {
		return nil, err
	}

	return db, nil
}
