CREATE TABLE transactions (
    transaction_id INTEGER,
    account_id INTEGER,
    transaction_amount DECIMAL(12,2),
    transaction_type VARCHAR,
    transaction_date DATE,
    transaction_timestamp TIMESTAMP,
    is_successful BOOLEAN
);

INSERT INTO transactions (
    transaction_id,
    account_id,
    transaction_amount,
    transaction_type,
    transaction_date,
    transaction_timestamp,
    is_successful
)
VALUES (
    1001,
    50001,
    25000.50,
    'TRANSFER',
    '2026-09-12',
    '2026-09-12 10:30:45',
    TRUE
);

INSERT INTO transactions (
    transaction_id,
    account_id,
    transaction_amount,
    transaction_type,
    transaction_date,
    transaction_timestamp,
    is_successful
)
VALUES
    (1002, 50002, 15000.00, 'TRANSFER', '2026-09-12', '2026-09-12 11:15:20', TRUE),
    (1003, 50003, 7500.50, 'WITHDRAWAL', '2026-09-12', '2026-09-12 11:45:10', TRUE),
    (1004, 50001, 3000.00, 'PAYMENT', '2026-09-12', '2026-09-12 12:05:33', FALSE);


SELECT * 
FROM transactions
WHERE transaction_id = 1003;

UPDATE transactions
SET transaction_amount = 8000
WHERE transaction_id = 1003;

SELECT *
FROM transactions;

SELECT *
FROM transactions
WHERE transaction_id = 1004;

DELETE FROM transactions
WHERE transaction_id = 1004;

ALTER TABLE transactions 
ADD COLUMN currency VARCHAR;

UPDATE transactions
SET currency = 'NGN';

ALTER TABLE transactions
RENAME COLUMN currency TO currency_code;

SELECT *
FROM transactions
ORDER BY transaction_id;

DESCRIBE transactions;

--SELECT current_database();
--PRAGMA database_list;

-- 1. Create Drop Table Statements (For Clean Re-runs)
DROP TABLE IF EXISTS ad_conversions;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;

-- 2. Create Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    cost_price DECIMAL(10,2) NOT NULL,
    retail_price DECIMAL(10,2) NOT NULL
);

-- 3. Create Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    sale_price DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 4. Create Ad Conversions Table (Google Ads Tracking)
CREATE TABLE ad_conversions (
    conversion_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    ad_channel VARCHAR(50) NOT NULL,
    ad_spend DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 5. Insert Sample Data
INSERT INTO products (product_id, product_name, category, cost_price, retail_price) VALUES
(1, 'Ceramic Spray Polish', 'Auto Care', 5.50, 29.99),
(2, 'Wrist Compression Wrap', 'Health', 4.80, 27.99),
(3, 'Migraine Relief Cap', 'Health', 6.20, 34.99),
(4, 'Solar Pathway Lights', 'Home', 12.50, 49.99);

INSERT INTO orders (order_id, product_id, quantity, sale_price, order_date) VALUES
(101, 1, 2, 29.99, '2026-09-01'),
(102, 1, 1, 29.99, '2026-09-02'),
(103, 2, 1, 27.99, '2026-09-03'),
(104, 3, 3, 34.99, '2026-09-04'),
(105, 4, 1, 49.99, '2026-09-05'),
(106, 3, 1, 34.99, '2026-09-06');

INSERT INTO ad_conversions (conversion_id, order_id, ad_channel, ad_spend) VALUES
(1, 101, 'Google Shopping', 12.50),
(2, 102, 'Google Search', 8.00),
(3, 103, 'Google Search', 15.00),
(4, 104, 'Google Shopping', 18.00),
(5, 105, 'Meta Ads', 22.00);

SELECT 
    product_name, 
    retail_price
FROM products
WHERE retail_price > (
    -- Subquery evaluates first to return a single value ($35.74)
    SELECT AVG(retail_price) 
    FROM products
);

SELECT 
    sub.product_id, 
    sub.total_revenue
FROM (
    SELECT 
        product_id, 
        SUM(quantity * sale_price) AS total_revenue
    FROM orders
    GROUP BY product_id
) AS sub
WHERE sub.total_revenue > 50.00;

SELECT *
FROM products
WHERE retail_price > (
    SELECT AVG(retail_price)
    FROM products
);