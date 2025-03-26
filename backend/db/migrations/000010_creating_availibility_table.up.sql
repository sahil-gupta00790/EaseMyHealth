CREATE TABLE doctor_availability_config (
    config_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    doctor_id UUID NOT NULL REFERENCES doctors(doctor_id) ON DELETE CASCADE,
    day_type VARCHAR(10) CHECK (day_type IN ('WEEKDAY', 'WEEKEND')) NOT NULL,
    shift_number INT NOT NULL, -- Allows multiple shifts
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    slot_duration INT NOT NULL CHECK (slot_duration > 0), -- in minutes
    max_patients_per_slot INT DEFAULT 1 CHECK (max_patients_per_slot > 0),
    is_active BOOLEAN DEFAULT TRUE,
    
    UNIQUE(doctor_id, day_type, shift_number)
);

CREATE TABLE doctor_daily_availability (
    availability_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    doctor_id UUID NOT NULL REFERENCES doctors(doctor_id) ON DELETE CASCADE,
    availability_date DATE NOT NULL,
    is_working BOOLEAN NOT NULL DEFAULT TRUE,
    override_start_time TIME,
    override_end_time TIME,
    
    UNIQUE(doctor_id, availability_date)
);
