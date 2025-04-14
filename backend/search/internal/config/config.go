// internal/config/config.go

package config

import (
	"encoding/json"
	"os"
	"strings"
)

// Config represents the application configuration
type Config struct {
	Port          int      `json:"port"`
	Database      DBConfig `json:"database"`
	Elasticsearch ESConfig `json:"elasticsearch"`
}

// DBConfig represents the database configuration
type DBConfig struct {
	DSN string `json:"dsn"`
}

// ESConfig represents the Elasticsearch configuration
type ESConfig struct {
	Addresses []string `json:"addresses"`
	Username  string   `json:"username"`
	Password  string   `json:"password"`
	Index     string   `json:"index"`
}

// LoadConfig loads the configuration from a file
func LoadConfig(path string) (*Config, error) {
	// Set default configuration
	config := &Config{
		Port: 8080,
		Database: DBConfig{
			DSN: "postgres://postgres:postgres@localhost/medicines?sslmode=disable",
		},
		Elasticsearch: ESConfig{
			Addresses: []string{"http://localhost:9200"},
			Index:     "medications",
		},
	}

	// If no config file path provided, return default config
	if path == "" {
		return config, nil
	}

	// Read config file
	file, err := os.ReadFile(path)
	if err != nil {
		return nil, err
	}

	// Parse JSON
	err = json.Unmarshal(file, config)
	if err != nil {
		return nil, err
	}

	// Override with environment variables if set
	if envPort := os.Getenv("PORT"); envPort != "" {
		config.Port = 8080 // Default to 8080 if parsing fails
		// Handle parsing error gracefully
		if parsedPort, err := parseInt(envPort); err == nil {
			config.Port = parsedPort
		}
	}

	if envDSN := os.Getenv("DATABASE_DSN"); envDSN != "" {
		config.Database.DSN = envDSN
	}

	if envAddresses := os.Getenv("ELASTICSEARCH_ADDRESSES"); envAddresses != "" {
		config.Elasticsearch.Addresses = strings.Split(envAddresses, ",")
	}

	if envUsername := os.Getenv("ELASTICSEARCH_USERNAME"); envUsername != "" {
		config.Elasticsearch.Username = envUsername
	}

	if envPassword := os.Getenv("ELASTICSEARCH_PASSWORD"); envPassword != "" {
		config.Elasticsearch.Password = envPassword
	}

	if envIndex := os.Getenv("ELASTICSEARCH_INDEX"); envIndex != "" {
		config.Elasticsearch.Index = envIndex
	}

	return config, nil
}

// Helper function to parse integer environment variables
func parseInt(value string) (int, error) {
	intValue := 0
	err := json.Unmarshal([]byte(value), &intValue)
	return intValue, err
}
