CREATE TABLE doctors (
    doctor_id UUID PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    specialty_id UUID REFERENCES specialties(specialty_id),
    qualifications TEXT,
    years_of_experience INT CHECK (years_of_experience >= 0),
    gender VARCHAR(20),
    profile_image_url TEXT,
    is_active BOOLEAN DEFAULT TRUE
);

