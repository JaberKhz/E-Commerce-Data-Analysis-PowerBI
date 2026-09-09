-- ====================================================================
-- 2. DATA CLEANING & TRANSFORMATION (تنظيف وتجهيز البيانات)
-- ====================================================================

-- تنظيف جدول العملاء (إزالة القيم الفارغة وتوحيد النصوص وأرقام الهواتف)
UPDATE customers SET email = 'Not Provided' WHERE email = '' OR email IS NULL;
UPDATE customers SET email = LOWER(email);
UPDATE customers SET email = TRIM(email);
UPDATE customers SET first_name = 'Unknown' WHERE first_name = '' OR first_name IS NULL;
UPDATE customers SET city = 'Unknown' WHERE city = '' OR city IS NULL;
UPDATE customers SET country = 'Unknown' WHERE country = '' OR country IS NULL;
UPDATE customers SET phone = 'Unknown' WHERE phone = '' OR phone IS NULL;
UPDATE customers SET phone = SUBSTRING_INDEX(phone, 'x', 1);
UPDATE customers SET phone = REPLACE(REPLACE(phone, '(', ''), ')', '');
UPDATE customers SET phone = REPLACE(phone, '-', '');
UPDATE customers SET phone = REPLACE(phone, '+', '');
UPDATE customers SET phone = REPLACE(phone, '.', '');

-- معالجة التواريخ التالفة في جدول العملاء
UPDATE customers SET registration_date = NULL WHERE registration_date = 'Not a Date';

-- تنظيف جدول البائعين
UPDATE sellers SET seller_name = TRIM(seller_name);
UPDATE sellers SET rating = 0.0 WHERE rating IS NULL;

-- تنظيف جدول المنتجات (معالجة الأسعار والكميات السالبة أو الشاذة)
UPDATE products SET product_name = 'Unknown_Product' WHERE product_name = '' OR product_name IS NULL;
UPDATE products SET price = ABS(price);
UPDATE products SET stock_quantity = ABS(stock_quantity);
UPDATE products SET price = 997.34 WHERE price > 100000;

-- تنظيف جدول المدفوعات
UPDATE payments SET amount_paid = ABS(amount_paid) WHERE amount_paid < 0;
UPDATE payments SET payment_method = 'Other' WHERE payment_method = 'Unknown';

-- تنظيف جدول التقييمات (ضبط النطاق بين 1 و 5)
UPDATE reviews SET rating = CASE
    WHEN rating < 1 THEN 1 
    WHEN rating > 5 THEN 5 
    ELSE rating
END;

-- تنظيف جدول الشحنات (معالجة التواريخ المنطقية)
UPDATE shipments SET actual_delivery_date = estimated_delivery_date WHERE actual_delivery_date < shipment_date;

-- إزالة التكرارات وهندسة جدول العملاء النهائي
CREATE TABLE customers_clean LIKE customers;
ALTER TABLE customers_clean ADD PRIMARY KEY (customer_id);
INSERT IGNORE INTO customers_clean SELECT * FROM customers;
DROP TABLE customers;
RENAME TABLE customers_clean TO customers;

-- ====================================================================
-- 3. DATA TYPE MODIFICATIONS (تعديل أنواع البيانات إلى صيغها الصحيحة)
-- ====================================================================

ALTER TABLE payments MODIFY amount_paid DECIMAL(10,2);
ALTER TABLE payments MODIFY payment_date DATETIME;
ALTER TABLE shipments MODIFY shipment_date DATETIME;
ALTER TABLE shipments MODIFY estimated_delivery_date DATETIME;
ALTER TABLE shipments MODIFY actual_delivery_date DATETIME;
ALTER TABLE reviews MODIFY rating DECIMAL(3,2);
ALTER TABLE reviews MODIFY review_date DATETIME;
ALTER TABLE customers MODIFY registration_date DATETIME;
ALTER TABLE products MODIFY creation_date DATE;
ALTER TABLE sellers MODIFY registration_date DATE;

-- ====================================================================
-- 4. ORPHAN RECORDS CLEANUP (إزالة السجلات اليتيمة لضمان صحة العلاقات)
-- ====================================================================

DELETE FROM products WHERE seller_id = 'SEL-9999';
DELETE FROM orders WHERE customer_id NOT IN (SELECT customer_id FROM customers);
DELETE FROM order_items WHERE order_id NOT IN (SELECT order_id FROM orders);
DELETE FROM order_items WHERE product_id NOT IN (SELECT product_id FROM products);
DELETE FROM payments WHERE order_id NOT IN (SELECT order_id FROM orders);
DELETE FROM shipments WHERE order_id NOT IN (SELECT order_id FROM orders);
DELETE FROM reviews WHERE customer_id NOT IN (SELECT customer_id FROM customers);
DELETE FROM reviews WHERE product_id NOT IN (SELECT product_id FROM products);

-- ====================================================================
-- 5. PRIMARY & FOREIGN KEYS CONSTRAINTS (تثبيت المفاتيح الأساسية والأجنبية)
-- ====================================================================

-- إضافة المفاتيح الأساسية (Primary Keys)
ALTER TABLE customers ADD PRIMARY KEY (customer_id);
ALTER TABLE categories ADD PRIMARY KEY (category_id);
ALTER TABLE products ADD PRIMARY KEY (product_id);
ALTER TABLE sellers ADD PRIMARY KEY (seller_id);
ALTER TABLE orders ADD PRIMARY KEY (order_id);
ALTER TABLE order_items ADD PRIMARY KEY (item_id);
ALTER TABLE payments ADD PRIMARY KEY (payment_id);
ALTER TABLE Shipments ADD PRIMARY KEY (shipment_id);
ALTER TABLE reviews ADD PRIMARY KEY (review_id);

-- بناء الجسور وربط المفاتيح الأجنبية (Foreign Keys)
ALTER TABLE products 
ADD CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES categories(category_id),
ADD CONSTRAINT fk_products_seller FOREIGN KEY (seller_id) REFERENCES sellers(seller_id);

ALTER TABLE orders 
ADD CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

ALTER TABLE order_items 
ADD CONSTRAINT fk_orderitems_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
ADD CONSTRAINT fk_orderitems_product FOREIGN KEY (product_id) REFERENCES products(product_id);

ALTER TABLE payments 
ADD CONSTRAINT fk_payments_order FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE Shipments 
ADD CONSTRAINT fk_shipments_order FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE reviews 
ADD CONSTRAINT fk_reviews_product FOREIGN KEY (product_id) REFERENCES products(product_id),
ADD CONSTRAINT fk_reviews_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id);