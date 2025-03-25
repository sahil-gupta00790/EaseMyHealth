CREATE TABLE consultation_types (
    type_id UUID PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE, 
    description TEXT,
    base_price DECIMAL(10, 2) CHECK (base_price >= 0),
    is_active BOOLEAN DEFAULT TRUE
);
