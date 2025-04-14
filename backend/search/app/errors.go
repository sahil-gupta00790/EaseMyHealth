package main

import "net/http"

func (app *application) notFoundResponse(w http.ResponseWriter, r *http.Request) {
	message := "The requested resource is not found"
	app.errorResponse(w, r, http.StatusNotFound, message)
}

func (app *application) errorResponse(w http.ResponseWriter, r *http.Request, status int, message interface{}) {
	//creating the json response
	app.logger.WithField("message", message).Info()
	env := envelope{"error": message}
	err := app.writeJson(w, status, env, nil)
	if err != nil {
		app.logError(r, err)
		w.WriteHeader(status)
	}
}
func (app *application) serverErrorResponse(w http.ResponseWriter, r *http.Request, err error) {
	//logging the error
	app.logError(r, err)
	message := "The server encounted the error and could not process the request"
	app.errorResponse(w, r, http.StatusInternalServerError, message)
}

func (app *application) logError(r *http.Request, err error) {
	app.logger.WithField(err.Error(), map[string]string{
		"request_method": r.Method,
		"request_url":    r.URL.String(),
	})
}

// Invalid token
func (app *application) invalidAuthenticationTokenResponse(w http.ResponseWriter, r *http.Request) {
	w.Header().Add("WWW-Authenticate", "Bearer")
	message := "Invalid or missing authentication token"
	app.errorResponse(w, r, http.StatusUnauthorized, message)
}

func (app *application) badRequestResponse(w http.ResponseWriter, r *http.Request, err error) {

	app.errorResponse(w, r, http.StatusBadRequest, err.Error())
}
