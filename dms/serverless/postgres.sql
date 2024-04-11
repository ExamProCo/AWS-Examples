CREATE TABLE example_table (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    salary DECIMAL(10, 2),
    is_active BOOLEAN
);