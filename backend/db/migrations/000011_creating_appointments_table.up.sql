CREATE TABLE appointment_slots (
    slot_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    doctor_id UUID NOT NULL REFERENCES doctors(doctor_id) ON DELETE CASCADE,
    availability_date DATE NOT NULL,
    slot_start_time TIME NOT NULL,
    slot_end_time TIME NOT NULL,
    status VARCHAR(20) CHECK (status IN ('AVAILABLE', 'PARTIALLY_BOOKED', 'FULLY_BOOKED')) NOT NULL DEFAULT 'AVAILABLE',
    max_capacity INT NOT NULL CHECK (max_capacity > 0),
    current_bookings INT NOT NULL DEFAULT 0 CHECK (current_bookings >= 0),
    consultation_type_id UUID REFERENCES consultation_types(type_id),
    
    UNIQUE(doctor_id, availability_date, slot_start_time)
);

CREATE TABLE appointments (
    appointment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    slot_id UUID NOT NULL REFERENCES appointment_slots(slot_id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    booking_timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) CHECK (status IN ('SCHEDULED', 'CONFIRMED', 'CANCELLED', 'COMPLETED')) NOT NULL DEFAULT 'SCHEDULED',
     consultation_price DECIMAL(10,2) NOT NULL CHECK (consultation_price >= 0),
    additional_notes TEXT,
    consultation_type_id UUID REFERENCES consultation_types(type_id),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
);

