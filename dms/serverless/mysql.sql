CREATE TABLE example_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    salary DECIMAL(10,2),
    is_active BOOLEAN
);