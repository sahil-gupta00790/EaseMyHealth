CREATE TABLE consultation_types (
    type_id UUID PRIMARY KEY,
    name TEXT NOT NULL,
    doctor_id UUID NOT NULL REFERENCES doctors(doctor_id) ON DELETE CASCADE,
    base_price DECIMAL(10, 2) CHECK (base_price >= 0),
    is_active BOOLEAN DEFAULT TRUE
);
