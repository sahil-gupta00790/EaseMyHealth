CREATE TABLE availability_slots (
    slot_id UUID PRIMARY KEY,
    doctor_id UUID REFERENCES doctors(doctor_id),
    clinic_id UUID REFERENCES clinics(clinic_id),
    consultation_type_id UUID REFERENCES consultation_types(type_id),
    date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    duration_minutes INT NOT NULL CHECK (duration_minutes > 0),
    is_booked BOOLEAN DEFAULT FALSE,
    max_patients INT DEFAULT 1 CHECK (max_patients > 0),
    UNIQUE(doctor_id, date, start_time)
);