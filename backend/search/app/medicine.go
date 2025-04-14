package main

import (
	"encoding/json"
	"net/http"
	"strconv"

	"github.com/julienschmidt/httprouter"
	"github.com/sahil-gupta00790/EaseMyHealth/backend/search/internal/data"
)

// SearchMedicineParams represents the query parameters for medicine search
type SearchMedicineParams struct {
	Query    string  `json:"query"`
	Category string  `json:"category"`
	MinPrice float64 `json:"min_price"`
	MaxPrice float64 `json:"max_price"`
	Page     int     `json:"page"`
	PageSize int     `json:"page_size"`
}

// SearchMedicineResponse represents the response for medicine search
type SearchMedicineResponse struct {
	Medications []data.Medication `json:"medications"`
	Total       int               `json:"total"`
	Page        int               `json:"page"`
	PageSize    int               `json:"page_size"`
	TotalPages  int               `json:"total_pages"`
}

func (app *application) SearchMedicineHandler(w http.ResponseWriter, r *http.Request) {
	//getting the values
	query := r.URL.Query().Get("query")
	category := r.URL.Query().Get("category")

	var minPrice, maxPrice float64
	var err error

	if minPriceStr := r.URL.Query().Get("min_price"); minPriceStr != "" {
		minPrice, err = strconv.ParseFloat(minPriceStr, 64)
		if err != nil {
			http.Error(w, "Invalid min_price parameter", http.StatusBadRequest)
			return
		}
	}

	if maxPriceStr := r.URL.Query().Get("max_price"); maxPriceStr != "" {
		maxPrice, err = strconv.ParseFloat(maxPriceStr, 64)
		if err != nil {
			http.Error(w, "Invalid max_price parameter", http.StatusBadRequest)
			return
		}
	}

	page := 1
	pageSize := 10

	if pageStr := r.URL.Query().Get("page"); pageStr != "" {
		page, err = strconv.Atoi(pageStr)
		if err != nil || page < 1 {
			http.Error(w, "Invalid page parameter", http.StatusBadRequest)
			return
		}
	}

	if pageSizeStr := r.URL.Query().Get("page_size"); pageSizeStr != "" {
		pageSize, err = strconv.Atoi(pageSizeStr)
		if err != nil || pageSize < 1 || pageSize > 100 {
			http.Error(w, "Invalid page_size parameter (must be between 1 and 100)", http.StatusBadRequest)
			return
		}
	}

	// Search medications
	medications, total, err := app.ES.SearchMedications(query, category, minPrice, maxPrice, page, pageSize)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	totalPages := (total + pageSize - 1) / pageSize

	// Build response
	response := SearchMedicineResponse{
		Medications: medications,
		Total:       total,
		Page:        page,
		PageSize:    pageSize,
		TotalPages:  totalPages,
	}

	// Set content type and encode response
	w.Header().Set("Content-Type", "application/json")
	err = json.NewEncoder(w).Encode(response)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

func (app *application) GetMedicineHandler(w http.ResponseWriter, r *http.Request) {
	params := httprouter.ParamsFromContext(r.Context())
	medicineID := params.ByName("id")

	medication, err := app.models.MedicineModel.GetByID(medicineID)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	// Set content type and encode response
	w.Header().Set("Content-Type", "application/json")
	err = json.NewEncoder(w).Encode(medication)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}
