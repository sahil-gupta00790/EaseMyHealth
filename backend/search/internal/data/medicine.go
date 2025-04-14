package data

import (
	"database/sql"
	"encoding/json"
	"time"

	"github.com/sahil-gupta00790/EaseMyHealth/backend/search/internal/validator"
)

type MedicineModel struct {
	DB *sql.DB
}

type Medication struct {
	ID                  string          `json:"id"`
	SubCategory         string          `json:"sub_category,omitempty"`
	ProductName         string          `json:"product_name"`
	SaltComposition     string          `json:"salt_composition,omitempty"`
	ProductPrice        *float64        `json:"product_price,omitempty"`
	ProductManufactured string          `json:"product_manufactured,omitempty"`
	MedicineDesc        string          `json:"medicine_desc,omitempty"`
	SideEffects         string          `json:"side_effects,omitempty"`
	DrugInteractions    json.RawMessage `json:"drug_interactions,omitempty"`
	CreatedAt           time.Time       `json:"created_at,omitempty"`
}

func (m MedicineModel) GetByID(id string) (*Medication, error) {
	query := `SELECT 
		medication_id, 
		sub_category, 
		product_name,
		salt_composition,
		product_price,
		product_manufactured,
		medicine_desc,
		side_effects,
		created_at
	FROM medications
	WHERE medication_id = $1`

	var med Medication
	var createdAtSQL sql.NullTime
	var productPriceSQL sql.NullFloat64
	var subCategorySQL, saltCompositionSQL, productManufacturedSQL, medicineDescSQL, sideEffectsSQL sql.NullString

	err := m.DB.QueryRow(query, id).Scan(
		&med.ID,
		&subCategorySQL,
		&med.ProductName,
		&saltCompositionSQL,
		&productPriceSQL,
		&productManufacturedSQL,
		&medicineDescSQL,
		&sideEffectsSQL,
		&createdAtSQL,
	)

	if err != nil {
		return nil, err
	}
	med.SubCategory = validator.StringFromNullString(subCategorySQL)
	med.SaltComposition = validator.StringFromNullString(saltCompositionSQL)
	med.ProductPrice = validator.Float64PtrFromNullFloat64(productPriceSQL)
	med.ProductManufactured = validator.StringFromNullString(productManufacturedSQL)
	med.MedicineDesc = validator.StringFromNullString(medicineDescSQL)
	med.SideEffects = validator.StringFromNullString(sideEffectsSQL)
	med.CreatedAt = validator.TimeFromNullTime(createdAtSQL)

	return &med, nil
}
