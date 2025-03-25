CREATE TABLE clinics (
    clinic_id UUID PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    address TEXT NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    contact_number VARCHAR(20),
    is_active BOOLEAN DEFAULT TRUE
);