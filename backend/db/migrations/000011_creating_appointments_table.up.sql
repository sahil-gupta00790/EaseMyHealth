CREATE TABLE appointments (
    appointment_id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(user_id),
    doctor_id UUID REFERENCES doctors(doctor_id),
    slot_id UUID REFERENCES availability_slots(slot_id),
    clinic_id UUID REFERENCES clinics(clinic_id),
    consultation_type_id UUID REFERENCES consultation_types(type_id),
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'SCHEDULED' 
        CHECK (status IN ('SCHEDULED', 'COMPLETED', 'CANCELLED', 'RESCHEDULED')),
    reason_for_visit TEXT,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);