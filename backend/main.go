package main

import (
	"database/sql"
	"log"
	"time"

	_ "github.com/lib/pq"
)

// Replace with your database connection details
const dbConn = "postgres://postgres:WintheW0rld@localhost:5432/EaseMyHealth?sslmode=disable"

// Function to check if a given date is a weekend
func isWeekend(date time.Time) bool {
	weekday := date.Weekday()
	return weekday == time.Saturday || weekday == time.Sunday
}

// Function to generate slots for a specific doctor considering weekday/weekend shifts
func generateSlotsForDoctor(db *sql.DB, doctorID string) {
	log.Println("🚀 Starting slot generation for Doctor:", doctorID)

	for i := 0; i <= 90; i++ { // Loop from today to the next 90 days
		availabilityDate := time.Now().AddDate(0, 0, i)
		dayType := "WEEKDAY"
		if isWeekend(availabilityDate) {
			dayType = "WEEKEND"
		}

		log.Printf("📅 Processing date: %s (Day Type: %s)\n", availabilityDate.Format("2006-01-02"), dayType)

		// Fetch availability config for the doctor based on the day type
		query := `
			SELECT start_time::TEXT, end_time::TEXT, slot_duration, max_patients_per_slot 
			FROM doctor_availability_config 
			WHERE doctor_id = $1 AND day_type = $2 AND is_active = TRUE
		`
		rows, err := db.Query(query, doctorID, dayType)
		if err != nil {
			log.Println("❌ Error fetching availability config:", err)
			return
		}
		defer rows.Close()

		foundAvailability := false

		for rows.Next() {
			foundAvailability = true
			var startTimeStr, endTimeStr string
			var slotDuration, maxPatients int

			if err := rows.Scan(&startTimeStr, &endTimeStr, &slotDuration, &maxPatients); err != nil {
				log.Println("❌ Error scanning row:", err)
				return
			}

			log.Printf("⏳ Doctor Available from %s to %s (Slot Duration: %d mins, Max Patients: %d)\n", startTimeStr, endTimeStr, slotDuration, maxPatients)

			// Convert start and end time to `time.Time` with today's date
			startTime, _ := time.Parse("15:04:05", startTimeStr)
			endTime, _ := time.Parse("15:04:05", endTimeStr)

			start := time.Date(availabilityDate.Year(), availabilityDate.Month(), availabilityDate.Day(), startTime.Hour(), startTime.Minute(), startTime.Second(), 0, time.UTC)
			end := time.Date(availabilityDate.Year(), availabilityDate.Month(), availabilityDate.Day(), endTime.Hour(), endTime.Minute(), endTime.Second(), 0, time.UTC)

			// Generate slots within the time range
			for current := start; current.Before(end); current = current.Add(time.Duration(slotDuration) * time.Minute) {
				slotStartTime := current.Format("15:04:05")
				slotEndTime := current.Add(time.Duration(slotDuration) * time.Minute).Format("15:04:05")

				// 🔥 Add log before inserting slot
				log.Printf("🟢 Preparing Slot: %s %s - %s\n", availabilityDate.Format("2006-01-02"), slotStartTime, slotEndTime)

				// Insert into appointment_slots if not already existing
				insertQuery := `
					INSERT INTO appointment_slots (slot_id, doctor_id, availability_date, slot_start_time, slot_end_time, status, max_capacity, current_bookings,consultation_type_id)
					SELECT gen_random_uuid(), $1, $2, $3, $4, 'AVAILABLE', $5, 0, '22277b80-a7c6-4f35-938f-e221d683f811'
					WHERE NOT EXISTS (
					    SELECT 1 FROM appointment_slots WHERE doctor_id = $1 AND availability_date = $2 AND slot_start_time = $3
					)
				`
				result, err := db.Exec(insertQuery, doctorID, availabilityDate.Format("2006-01-02"), slotStartTime, slotEndTime, maxPatients)
				if err != nil {
					log.Println("❌ Error inserting slot:", err)
				} else {
					rowsAffected, _ := result.RowsAffected()
					log.Printf("✅ Slot Inserted (Rows Affected: %d): %s %s - %s\n", rowsAffected, availabilityDate.Format("2006-01-02"), slotStartTime, slotEndTime)
				}
			}
		}

		if !foundAvailability {
			log.Printf("⚠️ No availability found for Doctor %s on %s\n", doctorID, availabilityDate.Format("2006-01-02"))
		}
	}

	log.Println("✅ Successfully generated slots for doctor:", doctorID)
}

func main() {
	// Connect to the database
	db, err := sql.Open("postgres", dbConn)
	if err != nil {
		log.Fatal("❌ Error connecting to DB:", err)
	}
	defer db.Close()

	// Replace with the doctor ID you want to generate slots for
	doctorID := "a3f46c95-aa33-4ced-8e8f-de22a572e0f5"

	// Generate slots for the doctor
	generateSlotsForDoctor(db, doctorID)
}
