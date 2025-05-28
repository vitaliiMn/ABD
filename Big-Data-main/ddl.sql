CREATE TABLE IF NOT EXISTS dim_customers (
  customer_id INTEGER PRIMARY KEY,
  first_name TEXT,
  last_name TEXT,
  age INTEGER,
  email TEXT,
  country TEXT,
  postal_code TEXT
);

CREATE TABLE IF NOT EXISTS dim_pets (
  pet_id SERIAL PRIMARY KEY,
  customer_id INTEGER REFERENCES dim_customers(customer_id),
  type TEXT,
  name TEXT,
  breed TEXT
);

CREATE TABLE IF NOT EXISTS dim_sellers (
  seller_id INTEGER PRIMARY KEY,
  first_name TEXT,
  last_name TEXT,
  email TEXT,
  country TEXT,
  postal_code TEXT
);

CREATE TABLE IF NOT EXISTS dim_suppliers (
  supplier_id SERIAL PRIMARY KEY,
  name TEXT,
  contact TEXT,
  email TEXT,
  phone TEXT,
  address TEXT,
  city TEXT,
  country TEXT
);

CREATE TABLE IF NOT EXISTS dim_products (
  product_id INTEGER PRIMARY KEY,
  name TEXT,
  category TEXT,
  price NUMERIC,
  quantity INTEGER,
  weight NUMERIC,
  color TEXT,
  size TEXT,
  brand TEXT,
  material TEXT,
  description TEXT,
  rating NUMERIC,
  reviews INTEGER,
  release_date DATE,
  expiry_date DATE,
  supplier_id INTEGER REFERENCES dim_suppliers(supplier_id)
);

CREATE TABLE IF NOT EXISTS dim_stores (
  store_id SERIAL PRIMARY KEY,
  name TEXT,
  location TEXT,
  city TEXT,
  state TEXT,
  country TEXT,
  phone TEXT,
  email TEXT
);

CREATE TABLE IF NOT EXISTS fact_sales (
  sale_id SERIAL PRIMARY KEY,
  customer_id INTEGER REFERENCES dim_customers(customer_id),
  seller_id INTEGER REFERENCES dim_sellers(seller_id),
  product_id INTEGER REFERENCES dim_products(product_id),
  store_id INTEGER REFERENCES dim_stores(store_id),
  quantity_sold INTEGER,
  total_price NUMERIC,
  sale_date DATE
);