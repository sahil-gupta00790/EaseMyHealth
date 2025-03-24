package main

import (
	"errors"
	"fmt"
	"net/http"
	"time"

	"github.com/google/uuid"
	"github.com/sahil-gupta00790/EaseMyHealth/backend/login/internal/data"
	"github.com/sahil-gupta00790/EaseMyHealth/backend/login/internal/validator"
)

func (app *application) registerUserHandler(w http.ResponseWriter, r *http.Request) {
	var input struct {
		Email    string `json:"email"`
		Password string `json:"password"`
	}
	err := app.readJSON(w, r, &input)
	if err != nil {
		app.badRequestResponse(w, r, err)
		return
	}

	user := &data.User{
		Email: input.Email,
	}
	err = user.PasswordHash.Set(input.Password)
	if err != nil {
		app.serverErrorResponse(w, r, err)
		return
	}
	v := validator.New()
	if data.ValidateUser(v, user); !v.Valid() {
		app.failedValidation(w, r, v.Errors)
		return
	}

	err = app.models.Users.Insert(user)
	if err != nil {
		fmt.Print(err)
		app.logger.WithField("err", err).Info()
		if errors.Is(err, data.ErrDuplicateEmail) {
			v.AddError("email", "a user with this email already exists")
			app.failedValidation(w, r, v.Errors)
			return
		}
		app.serverErrorResponse(w, r, err)
		return
	}
	//generating a token
	token, expiry, err := app.generateJWT(user)
	if err != nil {
		app.serverErrorResponse(w, r, err)
		return
	}
	response := envelope{
		"userid":     user.UserID,
		"token":      token,
		"expirytime": expiry.Format(time.RFC3339),
	}
	err = app.writeJson(w, http.StatusCreated, response, nil)
	if err != nil {
		app.serverErrorResponse(w, r, err)
	}

}

func (app *application) getUserDetailsHandler(w http.ResponseWriter, r *http.Request) {
	var input struct {
		UserID            uuid.UUID `json:"user_id"`
		FirstName         string    `json:"first_name"`
		LastName          string    `json:"last_name"`
		PhoneNumber       string    `json:"phone_number"`
		ProfilePictureURL string    `json:"profile_picture_url"`
	}

	err := app.readJSON(w, r, &input)
	if err != nil {
		app.badRequestResponse(w, r, err)
		return
	}
	app.logger.WithField("reached here", input).Info()

	v := validator.New()

	// Check if all required fields are present
	v.CheckRequiredFields(map[string]string{
		"user_id":      input.UserID.String(),
		"first_name":   input.FirstName,
		"last_name":    input.LastName,
		"phone_number": input.PhoneNumber,
	})

	// Check if there are any validation errors
	if !v.Valid() {
		app.failedValidation(w, r, v.Errors)
		return
	}

	user_details := &data.UserDetails{
		UserID:            input.UserID,
		FirstName:         input.FirstName,
		LastName:          input.LastName,
		PhoneNumber:       input.PhoneNumber,
		ProfilePictureURL: input.ProfilePictureURL,
	}

	err = app.models.UserDetails.Insert(user_details)
	if err != nil {
		app.serverErrorResponse(w, r, err)
		return
	}

	response := envelope{
		"message": "User details added successfully",
	}

	err = app.writeJson(w, http.StatusCreated, response, nil)
	if err != nil {
		app.serverErrorResponse(w, r, err)
	}

}
