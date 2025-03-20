package main

import "net/http"

func (app *application) logError(r *http.Request, err error) {
	app.logger.Print(err, map[string]string{
		"request_method": r.Method,
		"request_url":    r.URL.String(),
	})
}

func (app *application) errorResponse(w http.ResponseWriter, r *http.Request, status int, message interface{}) {
	//creating the json response
	env := envelope{"error": message}
	err := app.writeJson(w, status, env, nil)
	if err != nil {
		app.logError(r, err)
		w.WriteHeader(http.StatusInternalServerError)
	}
}

func (app *application) notFoundResponse(w http.ResponseWriter, r *http.Request) {
	message := "The requested resource is not found"
	app.errorResponse(w, r, http.StatusNotFound, message)
}

// server error response
func (app *application) serverErrorResponse(w http.ResponseWriter, r *http.Request, err error) {
	//logging the error
	app.logError(r, err)
	message := "The server encounted the error and could not process the request"
	app.errorResponse(w, r, http.StatusInternalServerError, message)
}
