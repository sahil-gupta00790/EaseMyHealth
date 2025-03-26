package main

import (
	"net/http"

	"github.com/google/uuid"
	"github.com/sahil-gupta00790/EaseMyHealth/backend/appointment/internal/data"
)

func (app *application) registerDoctorHandler(w http.ResponseWriter, r *http.Request) {
	var input struct {
		FirstName         string    `json:"first_name"`
		LastName          string    `json:"last_name"`
		Email             string    `json:"email"`
		Phone             string    `json:"phone_number"`
		SpecialtyID       uuid.UUID `json:"specialty_id"`
		Qualification     string    `json:"qualifications"`
		YearsOfExperience int       `json:"years_of_experience"`
		Gender            string    `json:"gender"`
		ProfileImageURL   string    `json:"profile_image_url"`
	}
	err := app.readJSON(w, r, &input)
	if err != nil {
		app.badRequestResponse(w, r, err)
		return
	}

	doctor := &data.Doctor{
		FirstName:         input.FirstName,
		LastName:          input.LastName,
		Email:             input.Email,
		Phone:             input.Phone,
		SpecialtyID:       input.SpecialtyID,
		Qualification:     input.Qualification,
		YearsOfExperience: input.YearsOfExperience,
		Gender:            input.Gender,
		ProfileImageURL:   input.ProfileImageURL,
	}

	err = app.models.Doctors.Insert(doctor)
	if err != nil {
		app.logger.WithField("err", err).Info()
		app.serverErrorResponse(w, r, err)
		return
	}
	response := envelope{
		"doctor_id": doctor.DoctorID,
	}
	err = app.writeJson(w, http.StatusCreated, response, nil)
	if err != nil {
		app.serverErrorResponse(w, r, err)

	}

}
