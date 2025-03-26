package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net/http"
	"os"
	"strings"

	"github.com/golang-jwt/jwt"
	"github.com/joho/godotenv"
)

type envelope map[string]interface{}

var jwtKey []byte

type Claims struct {
	UserID int64 `json:"user_id"`
	jwt.StandardClaims
}

func (app *application) writeJson(w http.ResponseWriter, status int, data envelope, headers http.Header) error {
	//convert map to json
	js, err := json.MarshalIndent(data, "", "\t")
	if err != nil {
		return err
	}
	js = append(js, '\n')
	//add the headers
	for key, value := range headers {
		w.Header()[key] = value
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	w.Write(js)

	return nil
}

func init() {
	err := godotenv.Load("../../.env")
	if err != nil {
		//todo
		panic("Error loading .env file")
	}

	jwtKeyStr := os.Getenv("JWT_SECRET_KEY")
	if jwtKeyStr == "" {

		panic("JWT_SECRET_KEY is not set in the environment")
	}
	jwtKey = []byte(jwtKeyStr)
}

// check the plainest token is 26 byte long
var ErrInvalidToken = errors.New("invalid token")

func (app *application) ValidateJWT(tokenString string) (*Claims, error) {
	claims := &Claims{}
	token, err := jwt.ParseWithClaims(tokenString, claims, func(token *jwt.Token) (interface{}, error) {
		return jwtKey, nil
	})

	if err != nil {
		if err == jwt.ErrSignatureInvalid {
			return nil, ErrInvalidToken
		}
		return nil, err
	}

	if !token.Valid {
		return nil, ErrInvalidToken
	}

	return claims, nil
}

func (app *application) readJSON(w http.ResponseWriter, r *http.Request, dst interface{}) error {
	//Use http.MaxByteReader() to limit the size of the request body to 1MB
	maxBytes := 1_048_576
	r.Body = http.MaxBytesReader(w, r.Body, int64(maxBytes))

	//decode request body into the target destination
	dec := json.NewDecoder(r.Body)
	dec.DisallowUnknownFields()
	err := dec.Decode(dst)
	if err != nil {
		var syntaxError *json.SyntaxError
		var unMarshalTypeError *json.UnmarshalTypeError //difference between what we expect and what we get
		var invalidUnmarshalError *json.InvalidUnmarshalError
		switch {
		case errors.As(err, &syntaxError):
			return fmt.Errorf("body contains badly found JSON (at character %d)", syntaxError.Offset)
		case errors.Is(err, io.ErrUnexpectedEOF): //syntax problem with json as it is being decoded
			return errors.New("body contains badly formed JSON")
		//checkinf for wrong types
		case errors.As(err, &unMarshalTypeError):
			if unMarshalTypeError.Field != "" {
				return fmt.Errorf("body contains incorrect JSON type for field %q", unMarshalTypeError.Field)
			}
			return fmt.Errorf("body contains incorrect JSON type (at character %d)", unMarshalTypeError.Offset)
		case errors.Is(err, io.EOF):
			return errors.New("body must not be empty")
			//Unmapable fields
		case strings.HasPrefix(err.Error(), "json: unknown field"):
			fieldName := strings.TrimPrefix(err.Error(), "json: unknown field")
			return fmt.Errorf("body contains unknown key %s", fieldName)
			//too large
		case err.Error() == "http: request body too large":
			return fmt.Errorf("body must not be larger than %d bytes", maxBytes)

		//pass non-nil pointer error

		case errors.As(err, &invalidUnmarshalError):
			panic(err)
		default:
			return err

		}

	}
	//check iof some value is given twice
	err = dec.Decode(&struct{}{})
	if err != io.EOF {
		return errors.New("body must contain a single JSON value")
	}
	return nil
}
