CREATE TABLE doctor_consultation_prices (
    doctor_id UUID REFERENCES doctors(doctor_id),
    consultation_type_id UUID REFERENCES consultation_types(type_id),
    price_adjustment DECIMAL(10, 2) DEFAULT 0,
    PRIMARY KEY (doctor_id, consultation_type_id)
);