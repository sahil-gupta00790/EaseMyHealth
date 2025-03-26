package main

import (
	"context"
	"database/sql"
	"flag"
	"log"
	"os"
	"sync"
	"time"

	_ "github.com/jackc/pgx/v5/stdlib"
	"github.com/joho/godotenv"
	"github.com/sahil-gupta00790/EaseMyHealth/backend/appointment/internal/data"
	"github.com/sirupsen/logrus"
)

const apiVersion = "v1"

type config struct {
	port int
	env  string
	db   struct {
		dsn          string
		maxOpenConns int
		maxIdleConns int
		maxIdleTime  time.Duration
	}
	limiter struct {
		rps     float64
		burst   int
		enabled bool
	}
	jwt struct {
		secret string
		expiry time.Duration
	}
}

type application struct {
	config config
	logger *logrus.Logger
	wg     sync.WaitGroup
	models data.Models
}

func main() {
	logger := logrus.New()
	logger.SetFormatter(&logrus.TextFormatter{
		FullTimestamp: true,
	})
	e := godotenv.Load("../../.env")
	if e != nil {
		logger.WithFields(
			logrus.Fields{
				"error": e,
			}).Warn("Error Loading .env file")

	}
	var cfg config
	flag.IntVar(&cfg.port, "port", 4001, "API server port")
	flag.StringVar(&cfg.env, "env", "development", "Environment (development|staging|production)")
	flag.StringVar(&cfg.db.dsn, "db-dsn", os.Getenv("DB_DSN"), "Postgres DSN")
	flag.IntVar(&cfg.db.maxOpenConns, "db-max-open-conns", 25, "Postgres max open connections")
	flag.IntVar(&cfg.db.maxIdleConns, "db-max-idle-conns", 25, "Postgres max idle connections")
	flag.DurationVar(&cfg.db.maxIdleTime, "db-max-idle-time", time.Minute, "Postgres max idle time")
	flag.Float64Var(&cfg.limiter.rps, "limiter-rps", 2, "Rate limiter maximum requests per second")
	flag.IntVar(&cfg.limiter.burst, "limiter-burst", 4, "Rate limiter maximum burst")
	flag.BoolVar(&cfg.limiter.enabled, "limiter-enabled", false, "Enable rate limiter")
	flag.Parse()
	if cfg.env == "development" {
		logger.SetLevel(logrus.DebugLevel)
	} else {
		logger.SetLevel(logrus.InfoLevel)
	}
	db, err := openDB(cfg)
	if err != nil {
		log.Fatal(err)
	}
	//id := uuid.New()
	//db.QueryRow("INSERT INTO specialties (specialty_id,name,description) VALUES ($1,'General Physician','General Physician') ON CONFLICT DO NOTHING", id)
	//id = uuid.New()
	//db.QueryRow("INSERT INTO specialties (specialty_id,name,description) VALUES ($1,'Dentist','Dentist') ON CONFLICT DO NOTHING", id)
	//id = uuid.New()
	//db.QueryRow("INSERT INTO specialties (specialty_id,name,description) VALUES ($1,'Cardiologist','Cardiologist') ON CONFLICT DO NOTHING", id)
	//id = uuid.New()
	//db.QueryRow("INSERT INTO specialties (specialty_id,name,description) VALUES ($1,'Dermatologist','Dermatologist') ON CONFLICT DO NOTHING", id)
	//id := uuid.New()
	//db.QueryRow("INSERT INTO consultation_types (type_id,doctor_id,base_price) VALUES ($1,'a3f46c95-aa33-4ced-8e8f-de22a572e0f5',500) ON CONFLICT DO NOTHING", id)
	logger.WithField("Database", err).Info("Connected to db")
	defer db.Close()
	app := &application{
		config: cfg,
		logger: logger,
		models: data.NewModels(db),
	}
	err = app.server()
	if err != nil {
		logger.WithField("error", err).Fatal("Server error")
	}

}
func openDB(cfg config) (*sql.DB, error) {
	db, err := sql.Open("pgx", cfg.db.dsn)
	if err != nil {
		return nil, err
	}
	db.SetMaxIdleConns(cfg.db.maxIdleConns)
	db.SetMaxOpenConns(cfg.db.maxOpenConns)
	duration, err := time.ParseDuration(cfg.db.maxIdleTime.String())
	if err != nil {
		return nil, err
	}
	db.SetConnMaxIdleTime(duration)
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	err = db.PingContext(ctx)
	if err != nil {
		return nil, err
	}
	return db, nil

}
