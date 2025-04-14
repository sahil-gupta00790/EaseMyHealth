-- Drop indexes for doctors table
DROP INDEX IF EXISTS idx_doctors_specialty;
DROP INDEX IF EXISTS idx_doctors_email;
DROP INDEX IF EXISTS idx_doctors_active;

-- Drop indexes for clinics table
DROP INDEX IF EXISTS idx_clinics_city;
DROP INDEX IF EXISTS idx_clinics_active;

-- Drop indexes for doctor_clinics junction table
DROP INDEX IF EXISTS idx_doctor_clinics_doctor;
DROP INDEX IF EXISTS idx_doctor_clinics_clinic;

-- Drop indexes for consultation_types table
DROP INDEX IF EXISTS idx_consultation_types_doctor;
DROP INDEX IF EXISTS idx_consultation_types_active;

-- Drop indexes for doctor_consultation_prices table
DROP INDEX IF EXISTS idx_doctor_consultation_prices_doctor;
DROP INDEX IF EXISTS idx_doctor_consultation_prices_consultation;

-- Drop indexes for doctor_availability_config table
DROP INDEX IF EXISTS idx_doctor_availability_config_doctor;
DROP INDEX IF EXISTS idx_doctor_availability_config_day;
DROP INDEX IF EXISTS idx_doctor_availability_config_active;

-- Drop indexes for doctor_daily_availability table
DROP INDEX IF EXISTS idx_doctor_daily_availability_doctor;
DROP INDEX IF EXISTS idx_doctor_daily_availability_date;
DROP INDEX IF EXISTS idx_doctor_daily_availability_working;

-- Drop indexes for appointment_slots table
DROP INDEX IF EXISTS idx_appointment_slots_doctor;
DROP INDEX IF EXISTS idx_appointment_slots_date;
DROP INDEX IF EXISTS idx_appointment_slots_status;
DROP INDEX IF EXISTS idx_appointment_slots_consultation;
DROP INDEX IF EXISTS idx_appointment_slots_datetime;

-- Drop indexes for users table
DROP INDEX IF EXISTS idx_users_email;
DROP INDEX IF EXISTS idx_users_status;
DROP INDEX IF EXISTS idx_users_verified;

-- Drop indexes for user_profiles table
DROP INDEX IF EXISTS idx_user_profiles_user;
DROP INDEX IF EXISTS idx_user_profiles_name;

-- Drop indexes for appointments table
DROP INDEX IF EXISTS idx_appointments_slot;
DROP INDEX IF EXISTS idx_appointments_user;
DROP INDEX IF EXISTS idx_appointments_doctor;
DROP INDEX IF EXISTS idx_appointments_status;
DROP INDEX IF EXISTS idx_appointments_consultation;
DROP INDEX IF EXISTS idx_appointments_created;

-- Drop indexes for token_blacklist table
DROP INDEX IF EXISTS idx_token_blacklist_user;
DROP INDEX IF EXISTS idx_token_blacklist_jti;
DROP INDEX IF EXISTS idx_token_blacklist_expiration;