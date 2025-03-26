package data

import (
	"context"
	"database/sql"
	"time"

	"github.com/google/uuid"
)

type Doctor struct {
	DoctorID          uuid.UUID `db:"doctor_id" json:"doctor_id"`
	FirstName         string    `db:"first_name" json:"first_name"`
	LastName          string    `db:"last_name" json:"last_name"`
	Email             string    `db:"email" json:"email"`
	Phone             string    `db:"phone" json:"phone_number"`
	SpecialtyID       uuid.UUID `db:"specialty_id" json:"specialty_id"`
	Qualification     string    `db:"qualification" json:"qualifications"`
	YearsOfExperience int       `db:"years_of_experience" json:"years_of_experience"`
	Gender            string    `db:"gender" json:"gender"`
	ProfileImageURL   string    `db:"profile_image_url" json:"profile_image_url"`
}

type DoctorModel struct {
	DB *sql.DB
}

func (m DoctorModel) Insert(doctor *Doctor) error {
	query := `
		INSERT INTO doctors (doctor_id,first_name, last_name, email, phone_number, specialty_id, qualifications, years_of_experience,gender, profile_image_url)
		VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9,$10)
		RETURNING doctor_id
	`
	if doctor.DoctorID == uuid.Nil {
		doctor.DoctorID = uuid.New()
	}

	args := []interface{}{doctor.DoctorID, doctor.FirstName, doctor.LastName, doctor.Email, doctor.Phone, doctor.SpecialtyID, doctor.Qualification, doctor.YearsOfExperience, doctor.Gender, doctor.ProfileImageURL}
	ctx, cancel := context.WithTimeout(context.Background(), 3*time.Second)
	defer cancel()

	err := m.DB.QueryRowContext(ctx, query, args...).Scan(&doctor.DoctorID)
	if err != nil {
		if err.Error() == `ERROR: duplicate key value violates unique constraint "doctors_email_key" (SQLSTATE 23505)` {
			return err
		}
		return err
	}
	return nil
}
