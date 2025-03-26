package main

import (
	"net/http"
)

func (app *application) slotsAvailableHandler(w http.ResponseWriter, r *http.Request) {
	var input struct {
		Date            string `json:"date"`
		DoctorID        string `json:"doctor_id"`
		ConsultancyType string `json:"consultation_type_id"`
	}
	err := app.readJSON(w, r, &input)
	if err != nil {
		app.badRequestResponse(w, r, err)
		return
	}

	ans, err := app.models.DoctorAvailabilitySlot.GetByDateAndDoctorID(input.Date, input.DoctorID, input.ConsultancyType)
	if err != nil {
		app.logger.WithField("err", err).Info()
		app.serverErrorResponse(w, r, err)
		return
	}
	response := envelope{
		"slots": ans,
	}
	err = app.writeJson(w, http.StatusOK, response, nil)
	if err != nil {
		app.serverErrorResponse(w, r, err)
	}

}
func (app *application) bookAppointmentHandler(w http.ResponseWriter, r *http.Request) {
	var input struct {
		SlotId string `json:"slot_id"`
		UserId string `json:"user_id"`
	}
	err := app.readJSON(w, r, &input)
	if err != nil {
		app.badRequestResponse(w, r, err)
		return
	}
	appointmentId, err := app.models.AppointmentModel.BookAppointment(input.SlotId, input.UserId)
	if err != nil {
		app.logger.WithField("err", err).Info()
		app.serverErrorResponse(w, r, err)
		return
	}
	response := envelope{
		"appointment_id": appointmentId,
	}
	err = app.writeJson(w, http.StatusCreated, response, nil)

	if err != nil {
		app.serverErrorResponse(w, r, err)
	}

}
