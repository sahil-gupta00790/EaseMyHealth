CREATE INDEX idx_appointments_user_doctor ON appointments(user_id, doctor_id);
CREATE INDEX idx_appointments_status ON appointments(status);
CREATE INDEX idx_availability_slots_doctor_date ON availability_slots(doctor_id, date);