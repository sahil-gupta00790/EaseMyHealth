//llm code

package data

import (
	"context"
	"database/sql"
	"fmt"
	"log"
	"time"
)

// SyncMedicationsToElasticsearch syncs all medications from PostgreSQL to Elasticsearch
func SyncMedicationsToElasticsearch(db *sql.DB, es *ElasticsearchClient) error {
	// Ensure the Elasticsearch index exists
	if err := es.CreateIndex(); err != nil {
		return fmt.Errorf("failed to create index: %w", err)
	}

	// Query all medications from PostgreSQL
	query := `
		SELECT 
			medication_id, 
			sub_category, 
			product_name,
			salt_composition,
			product_price,
			product_manufactured,
			medicine_desc,
			side_effects,
			drug_interactions,
			created_at
		FROM medications
	`

	rows, err := db.QueryContext(context.Background(), query)
	if err != nil {
		return fmt.Errorf("failed to query medications: %w", err)
	}
	defer rows.Close()

	// Collect medications for bulk indexing
	var medications []Medication
	for rows.Next() {
		var med Medication
		var drugInteractionsBytes []byte
		var createdAtSQL sql.NullTime
		var productPriceSQL sql.NullFloat64
		var subCategorySQL, saltCompositionSQL, productManufacturedSQL, medicineDescSQL, sideEffectsSQL sql.NullString

		err := rows.Scan(
			&med.ID,
			&subCategorySQL,
			&med.ProductName,
			&saltCompositionSQL,
			&productPriceSQL,
			&productManufacturedSQL,
			&medicineDescSQL,
			&sideEffectsSQL,
			&drugInteractionsBytes,
			&createdAtSQL,
		)

		// Handle nullable fields
		if subCategorySQL.Valid {
			med.SubCategory = subCategorySQL.String
		}
		if saltCompositionSQL.Valid {
			med.SaltComposition = saltCompositionSQL.String
		}
		if productPriceSQL.Valid {
			med.ProductPrice = &productPriceSQL.Float64
		}
		if productManufacturedSQL.Valid {
			med.ProductManufactured = productManufacturedSQL.String
		}
		if medicineDescSQL.Valid {
			med.MedicineDesc = medicineDescSQL.String
		}
		if sideEffectsSQL.Valid {
			med.SideEffects = sideEffectsSQL.String
		}
		if err != nil {
			return fmt.Errorf("failed to scan medication row: %w", err)
		}

		// Handle nullable created_at
		if createdAtSQL.Valid {
			med.CreatedAt = createdAtSQL.Time
		} else {
			med.CreatedAt = time.Now()
		}

		// Set drug interactions as raw JSON
		med.DrugInteractions = drugInteractionsBytes

		medications = append(medications, med)

		// Bulk index in batches of 100
		if len(medications) >= 100 {
			if err := es.BulkIndexMedications(medications); err != nil {
				return fmt.Errorf("failed to bulk index medications: %w", err)
			}
			log.Printf("Indexed batch of %d medications", len(medications))
			medications = []Medication{} // Reset the slice
		}
	}

	// Index any remaining medications
	if len(medications) > 0 {
		if err := es.BulkIndexMedications(medications); err != nil {
			return fmt.Errorf("failed to bulk index remaining medications: %w", err)
		}
		log.Printf("Indexed final batch of %d medications", len(medications))
	}

	return nil
}

// SyncSingleMedicationToElasticsearch syncs a single medication from PostgreSQL to Elasticsearch
func SyncSingleMedicationToElasticsearch(db *sql.DB, es *ElasticsearchClient, medicationID string) error {
	// Query the medication from PostgreSQL
	query := `
		SELECT 
			medication_id, 
			sub_category, 
			product_name,
			salt_composition,
			product_price,
			product_manufactured,
			medicine_desc,
			side_effects,
			drug_interactions,
			created_at
		FROM medications
		WHERE medication_id = $1
	`

	var med Medication
	var drugInteractionsBytes []byte
	var createdAtSQL sql.NullTime
	var productPriceSQL sql.NullFloat64
	var subCategorySQL, saltCompositionSQL, productManufacturedSQL, medicineDescSQL, sideEffectsSQL sql.NullString

	err := db.QueryRowContext(context.Background(), query, medicationID).Scan(
		&med.ID,
		&subCategorySQL,
		&med.ProductName,
		&saltCompositionSQL,
		&productPriceSQL,
		&productManufacturedSQL,
		&medicineDescSQL,
		&sideEffectsSQL,
		&drugInteractionsBytes,
		&createdAtSQL,
	)

	// Handle nullable fields
	if subCategorySQL.Valid {
		med.SubCategory = subCategorySQL.String
	}
	if saltCompositionSQL.Valid {
		med.SaltComposition = saltCompositionSQL.String
	}
	if productPriceSQL.Valid {
		med.ProductPrice = &productPriceSQL.Float64
	}
	if productManufacturedSQL.Valid {
		med.ProductManufactured = productManufacturedSQL.String
	}
	if medicineDescSQL.Valid {
		med.MedicineDesc = medicineDescSQL.String
	}
	if sideEffectsSQL.Valid {
		med.SideEffects = sideEffectsSQL.String
	}

	if err != nil {
		return fmt.Errorf("failed to query medication: %w", err)
	}

	// Handle nullable created_at
	if createdAtSQL.Valid {
		med.CreatedAt = createdAtSQL.Time
	} else {
		med.CreatedAt = time.Now()
	}

	// Set drug interactions as raw JSON
	med.DrugInteractions = drugInteractionsBytes

	// Index the medication
	if err := es.IndexMedication(med); err != nil {
		return fmt.Errorf("failed to index medication: %w", err)
	}

	return nil
}
