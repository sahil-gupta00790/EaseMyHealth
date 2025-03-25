CREATE TABLE doctor_clinics (
    doctor_id UUID REFERENCES doctors(doctor_id),
    clinic_id UUID REFERENCES clinics(clinic_id),
    PRIMARY KEY (doctor_id, clinic_id)
);