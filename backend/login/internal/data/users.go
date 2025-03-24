package data

import (
	"context"
	"database/sql"
	"errors"
	"time"

	"github.com/google/uuid"
	"github.com/sahil-gupta00790/EaseMyHealth/backend/login/internal/validator"
	"golang.org/x/crypto/bcrypt"
)

var (
	ErrDuplicateEmail = errors.New("duplicate email")
)

type User struct {
	UserID       uuid.UUID `db:"user_id"`
	Email        string    `db:"email"`
	PasswordHash password  `db:"password_hash"`
	CreatedAt    time.Time `db:"created_at"`
	UpdatedAt    time.Time `db:"updated_at"`
	IsVerified   bool      `db:"is_verified"`
	Status       string    `db:"status"`
}

type UserDetails struct {
	ProfileID         uuid.UUID `db:"profile_id"`
	UserID            uuid.UUID `db:"user_id"`
	FirstName         string    `db:"first_name"`
	LastName          string    `db:"last_name"`
	PhoneNumber       string    `db:"phone_number"`
	ProfilePictureURL string    `json:"profile_picture_url"`
}

type password struct {
	plaintext *string
	hash      []byte
}

type UserModel struct {
	DB *sql.DB
}
type UserDetailsModel struct {
	DB *sql.DB
}

func (p *password) Set(plainText string) error {
	hash, err := bcrypt.GenerateFromPassword([]byte(plainText), 12)
	if err != nil {
		return err
	}
	p.plaintext = &plainText
	p.hash = hash
	return nil
}

func ValidateUser(v *validator.Validator, user *User) {
	ValidateEmail(v, user.Email)
	if user.PasswordHash.plaintext != nil {
		ValidatePasswordPlaintext(v, *user.PasswordHash.plaintext)
	}
	//Ensure a hashed password has been set
	if user.PasswordHash.hash == nil {
		panic("missing hashed password")
	}
}
func ValidateEmail(v *validator.Validator, email string) {
	v.Check(email != "", "email", "required,email")
	v.Check(validator.Matches(email, validator.EmailRX), "email", "must be a valid email address")
}

func ValidatePasswordPlaintext(v *validator.Validator, password string) {
	v.Check(password != "", "password", "required")
	v.Check(len(password) >= 8, "password", "must be at least 8 bytes long")
	v.Check(len(password) <= 72, "password", "must not be more than 72 bytes long")
}

// Insert a new user into the database
func (m UserModel) Insert(user *User) error {
	query := `
	INSERT INTO users (user_id, email, password_hash, status)
	VALUES($1, $2, $3, $4)
	RETURNING created_at, updated_at, is_verified`

	// Generate a new UUID if not already set
	if user.UserID == uuid.Nil {
		user.UserID = uuid.New()
	}

	args := []interface{}{user.UserID, user.Email, user.PasswordHash.hash, user.Status}

	ctx, cancel := context.WithTimeout(context.Background(), 3*time.Second)
	defer cancel()

	err := m.DB.QueryRowContext(ctx, query, args...).Scan(&user.CreatedAt, &user.UpdatedAt, &user.IsVerified)
	if err != nil {
		if err.Error() == `ERROR: duplicate key value violates unique constraint "users_email_key" (SQLSTATE 23505)` {
			return ErrDuplicateEmail
		}

		return err
	}

	return nil
}

func (m UserDetailsModel) Insert(user *UserDetails) error {
	// Set current time for created_at and updated_at if not already set
	now := time.Now().UTC()
	if user.ProfileID == uuid.Nil {
		user.ProfileID = uuid.New()
	}

	query := `
    INSERT INTO user_profiles (
        profile_id, 
        user_id, 
        first_name, 
        last_name, 
        phone_number, 
        profile_picture_url,
        created_at,
        updated_at
    ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)`

	args := []interface{}{
		user.ProfileID,
		user.UserID,
		user.FirstName,
		user.LastName,
		user.PhoneNumber,
		user.ProfilePictureURL,
		now,
		now,
	}

	ctx, cancel := context.WithTimeout(context.Background(), 3*time.Second)
	defer cancel()

	_, err := m.DB.ExecContext(ctx, query, args...)
	if err != nil {
		return err
	}

	return nil
}
