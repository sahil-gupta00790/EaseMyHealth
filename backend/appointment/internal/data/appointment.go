package data

import (
	"context"
	"database/sql"
	"errors"
	"fmt"
	"log"
	"time"

	"github.com/google/uuid"
)

type DoctorAvailabilitySlot struct {
	SlotID             uuid.UUID `db:"id"`  //db:"slot_id"
	SlotStartTime      string    `db:"st"`  //db:"slot_start_time"
	AvailableSlots     int       `db:"as"`  //db:"available_spots"
	ConsultationTypeID string    `db:"cid"` //db:"consultation_type_id"
	ConsultationType   string    `db:"ct"`  //db:"consultation_type"
}

type DoctorAvailabilitySlotModel struct {
	DB *sql.DB
}
type AppointmentModel struct {
	DB *sql.DB
}

func (m DoctorAvailabilitySlotModel) GetByDateAndDoctorID(date string, doctorID string, consultationTypeID string) ([]DoctorAvailabilitySlot, error) {
	query := `
	SELECT 
	    s.slot_id,
	    s.slot_start_time::TEXT,
	    (s.max_capacity - s.current_bookings) AS available_spots,
	    s.consultation_type_id,  
	    ct.name AS consultation_type  
	FROM appointment_slots s
	JOIN consultation_types ct ON s.consultation_type_id = ct.type_id
	WHERE s.doctor_id = $1
	AND s.availability_date = $2
	AND s.status != 'FULLY_BOOKED'
	AND s.consultation_type_id = $3
	AND (s.max_capacity - s.current_bookings) > 0
	ORDER BY s.slot_start_time;
	`

	// Prepare query arguments
	args := []interface{}{doctorID, date, consultationTypeID}

	// Execute query
	rows, err := m.DB.Query(query, args...)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	// Prepare results
	var slots []DoctorAvailabilitySlot
	for rows.Next() {
		var slot DoctorAvailabilitySlot
		err := rows.Scan(
			&slot.SlotID,
			&slot.SlotStartTime,
			&slot.AvailableSlots,
			&slot.ConsultationTypeID,
			&slot.ConsultationType,
		)
		if err != nil {
			return nil, err
		}
		slots = append(slots, slot)
	}

	// Return results
	return slots, nil

}

func (m *AppointmentModel) BookAppointment(slotID, patientID string) (string, error) {
	// Start a SERIALIZABLE transaction
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	tx, err := m.DB.BeginTx(ctx, &sql.TxOptions{Isolation: sql.LevelSerializable})
	if err != nil {
		return "transaction_error", fmt.Errorf("begin transaction: %w", err)
	}
	defer func() {
		if r := recover(); r != nil {
			tx.Rollback()
			log.Printf("Panic recovered during booking: %v", r)
		}
	}()
	defer tx.Rollback() // Ensure rollback if anything goes wrong
	var doctorID, consultationTypeID string
	err = tx.QueryRow(`
		SELECT doctor_id, consultation_type_id
		FROM appointment_slots 
		WHERE slot_id = $1 
		FOR UPDATE`, slotID).Scan(&doctorID, &consultationTypeID)
	if err != nil {
		if err == sql.ErrNoRows {
			return "slot_not_found", nil
		}
		return "slot_check_error", fmt.Errorf("checking slot: %w", err)
	}
	// Step 1: Check patient's existing bookings in this slot (prevent double booking)
	var existingBookings int
	err = tx.QueryRow(`
		SELECT COUNT(*) 
		FROM appointments 
		WHERE slot_id = $1 AND user_id = $2`,
		slotID, patientID).Scan(&existingBookings)
	if err != nil {
		return "check_booking_error", err
	}
	if existingBookings > 0 {
		return "already_booked", errors.New("patient already booked in this slot")
	}

	// Step 2: Check slot availability and lock it
	var maxCapacity, currentBookings int
	var slotStatus string
	err = tx.QueryRow(`
		SELECT max_capacity, current_bookings, status 
		FROM appointment_slots 
		WHERE slot_id = $1 
		FOR UPDATE`, slotID).Scan(&maxCapacity, &currentBookings, &slotStatus)

	if err != nil {
		if err == sql.ErrNoRows {
			return "slot_not_found", nil
		}
		return "slot_check_error", fmt.Errorf("checking slot: %w", err)
	}

	// Step 3: Validate slot availability
	if currentBookings >= maxCapacity || slotStatus == "FULLY_BOOKED" {
		return "slot_full", errors.New("slot is fully booked")
	}

	// Step 4: Insert new appointment with additional validation
	appointmentID := uuid.New().String()
	_, err = tx.Exec(`
		INSERT INTO appointments (
			appointment_id, 
			slot_id, 
			user_id, 
			doctor_id, 
			consultation_type_id, 
			status,
			consultation_price,
			created_at
		) VALUES ($1, $2, $3, $4, $5, 'SCHEDULED', 500,CURRENT_TIMESTAMP)`,
		appointmentID, slotID, patientID, doctorID, consultationTypeID)
	if err != nil {
		return "booking_error", fmt.Errorf("insert appointment: %w", err)
	}

	// Step 5: Update slot booking count with more robust status management
	_, err = tx.Exec(`
		UPDATE appointment_slots 
		SET 
			current_bookings = current_bookings + 1, 
			status = CASE 
				WHEN current_bookings + 1 >= max_capacity THEN 'FULLY_BOOKED' 
				ELSE 'PARTIALLY_BOOKED' 
			END
		WHERE slot_id = $1`, slotID)
	if err != nil {
		return "update_slot_error", fmt.Errorf("updating slot: %w", err)
	}

	// Step 6: Commit transaction
	err = tx.Commit()
	if err != nil {
		return "commit_error", fmt.Errorf("commit transaction: %w", err)
	}

	// Optional: Trigger notification or additional processing
	go m.sendBookingConfirmation(appointmentID)

	return appointmentID, nil
}

// Additional helper method for async notification
func (m *AppointmentModel) sendBookingConfirmation(appointmentID string) {
	// Implement booking confirmation logic
	// Could send SMS, email, or push notification
	// Log any errors without blocking the main thread
}
