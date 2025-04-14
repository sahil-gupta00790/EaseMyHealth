package main

import (
	"net/http"

	"github.com/julienschmidt/httprouter"
)

func (app *application) routes() http.Handler {
	router := httprouter.New()
	router.NotFound = http.HandlerFunc(app.notFoundResponse)
	router.HandlerFunc(http.MethodGet, "/v1/healthcheck", app.healthCheckHandler)
	router.HandlerFunc(http.MethodGet, "/v1/medicines/search", app.SearchMedicineHandler)
	router.HandlerFunc(http.MethodGet, "/v1/medicines/id/:id", app.GetMedicineHandler)
	return app.authenticate(router)
}
