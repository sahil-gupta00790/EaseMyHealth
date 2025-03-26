package main

import (
	"net/http"

	"github.com/julienschmidt/httprouter"
)

func (app *application) routes() http.Handler {
	router := httprouter.New()
	router.NotFound = http.HandlerFunc(app.notFoundResponse)
	router.HandlerFunc(http.MethodGet, "/v1/healthcheck", app.healthCheckHandler)
	router.HandlerFunc(http.MethodPost, "/v1/slots/available", app.slotsAvailableHandler)
	router.HandlerFunc(http.MethodPost, "/v1/doctor", app.registerDoctorHandler)
	router.HandlerFunc(http.MethodPost, "/v1/appointment", app.bookAppointmentHandler)

	return app.authenticate(router)
}
