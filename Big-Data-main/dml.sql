INSERT INTO dim_customers (customer_id, first_name, last_name, age, email, country, postal_code)
SELECT DISTINCT 
  id, customer_first_name, customer_last_name, customer_age, customer_email, 
  customer_country, customer_postal_code
FROM mock_data
WHERE customer_first_name IS NOT NULL;

INSERT INTO dim_pets (customer_id, type, name, breed)
SELECT DISTINCT 
  id, customer_pet_type, customer_pet_name, customer_pet_breed
FROM mock_data
WHERE customer_pet_type IS NOT NULL;

INSERT INTO dim_sellers (seller_id, first_name, last_name, email, country, postal_code)
SELECT DISTINCT 
  sale_seller_id, seller_first_name, seller_last_name, seller_email, 
  seller_country, seller_postal_code
FROM mock_data
WHERE seller_first_name IS NOT NULL;

INSERT INTO dim_suppliers (name, contact, email, phone, address, city, country)
SELECT DISTINCT 
  supplier_name, supplier_contact, supplier_email, supplier_phone,
  supplier_address, supplier_city, supplier_country
FROM mock_data
WHERE supplier_name IS NOT NULL;

INSERT INTO dim_products (
  product_id, name, category, price, quantity, weight, color, size, brand,
  material, description, rating, reviews, release_date, expiry_date, supplier_id
)
SELECT DISTINCT 
  sale_product_id, product_name, product_category, product_price, product_quantity,
  product_weight, product_color, product_size, product_brand, product_material,
  product_description, product_rating, product_reviews, product_release_date,
  product_expiry_date, 
  (SELECT supplier_id FROM dim_suppliers WHERE name = supplier_name LIMIT 1)
FROM mock_data
WHERE product_name IS NOT NULL;

INSERT INTO dim_stores (name, location, city, state, country, phone, email)
SELECT DISTINCT 
  store_name, store_location, store_city, store_state, store_country,
  store_phone, store_email
FROM mock_data
WHERE store_name IS NOT NULL;

INSERT INTO fact_sales (
  sale_id, customer_id, seller_id, product_id, store_id, quantity_sold,
  total_price, sale_date
)
SELECT 
  md.id AS sale_id,
  md.sale_customer_id AS customer_id,
  md.sale_seller_id AS seller_id,
  md.sale_product_id AS product_id,
  s.store_id,
  md.sale_quantity AS quantity_sold,
  md.sale_total_price AS total_price,
  md.sale_date
FROM mock_data md
JOIN dim_stores s ON s.name = md.store_name;