-- Create medications table
CREATE TABLE IF NOT EXISTS medications (
    medication_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sub_category VARCHAR,
    product_name VARCHAR NOT NULL,
    salt_composition VARCHAR,
    product_price NUMERIC(10, 2),  -- Changed to NUMERIC type
    product_manufactured VARCHAR,
    medicine_desc TEXT,
    side_effects TEXT,
    drug_interactions JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for search performance
CREATE INDEX IF NOT EXISTS idx_medications_product_name ON medications(product_name);
CREATE INDEX IF NOT EXISTS idx_medications_salt_composition ON medications(salt_composition);
CREATE INDEX IF NOT EXISTS idx_medications_sub_category ON medications(sub_category);
CREATE INDEX IF NOT EXISTS idx_medications_price ON medications(product_price); 