-- Indexes for doctors table
CREATE INDEX idx_doctors_specialty ON doctors(specialty_id);
CREATE INDEX idx_doctors_email ON doctors(email);
CREATE INDEX idx_doctors_active ON doctors(is_active);

-- Indexes for clinics table
CREATE INDEX idx_clinics_city ON clinics(city);
CREATE INDEX idx_clinics_active ON clinics(is_active);

-- Indexes for doctor_clinics junction table
CREATE INDEX idx_doctor_clinics_doctor ON doctor_clinics(doctor_id);
CREATE INDEX idx_doctor_clinics_clinic ON doctor_clinics(clinic_id);

-- Indexes for consultation_types table
CREATE INDEX idx_consultation_types_doctor ON consultation_types(doctor_id);
CREATE INDEX idx_consultation_types_active ON consultation_types(is_active);

-- Indexes for doctor_consultation_prices table
CREATE INDEX idx_doctor_consultation_prices_doctor ON doctor_consultation_prices(doctor_id);
CREATE INDEX idx_doctor_consultation_prices_consultation ON doctor_consultation_prices(consultation_type_id);

-- Indexes for doctor_availability_config table
CREATE INDEX idx_doctor_availability_config_doctor ON doctor_availability_config(doctor_id);
CREATE INDEX idx_doctor_availability_config_day ON doctor_availability_config(day_type);
CREATE INDEX idx_doctor_availability_config_active ON doctor_availability_config(is_active);

-- Indexes for doctor_daily_availability table
CREATE INDEX idx_doctor_daily_availability_doctor ON doctor_daily_availability(doctor_id);
CREATE INDEX idx_doctor_daily_availability_date ON doctor_daily_availability(availability_date);
CREATE INDEX idx_doctor_daily_availability_working ON doctor_daily_availability(is_working);

-- Indexes for appointment_slots table
CREATE INDEX idx_appointment_slots_doctor ON appointment_slots(doctor_id);
CREATE INDEX idx_appointment_slots_date ON appointment_slots(availability_date);
CREATE INDEX idx_appointment_slots_status ON appointment_slots(status);
CREATE INDEX idx_appointment_slots_consultation ON appointment_slots(consultation_type_id);
CREATE INDEX idx_appointment_slots_datetime ON appointment_slots(availability_date, slot_start_time);

-- Indexes for users table
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_status ON users(status);
CREATE INDEX idx_users_verified ON users(is_verified);

-- Indexes for user_profiles table
CREATE INDEX idx_user_profiles_user ON user_profiles(user_id);
CREATE INDEX idx_user_profiles_name ON user_profiles(first_name, last_name);

-- Indexes for appointments table
CREATE INDEX idx_appointments_slot ON appointments(slot_id);
CREATE INDEX idx_appointments_user ON appointments(user_id);
CREATE INDEX idx_appointments_doctor ON appointments(doctor_id);
CREATE INDEX idx_appointments_status ON appointments(status);
CREATE INDEX idx_appointments_consultation ON appointments(consultation_type_id);
CREATE INDEX idx_appointments_created ON appointments(created_at);

-- Indexes for token_blacklist table
CREATE INDEX idx_token_blacklist_user ON token_blacklist(user_id);
CREATE INDEX idx_token_blacklist_jti ON token_blacklist(token_jti);
CREATE INDEX idx_token_blacklist_expiration ON token_blacklist(expiration_time);