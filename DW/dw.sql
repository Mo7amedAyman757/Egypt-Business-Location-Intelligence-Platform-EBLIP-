
-- Star Schema SQL Script

CREATE DATABASE IF NOT EXISTS real_estate_dw;
USE real_estate_dw;

-- =========================================================
-- DIMENSION TABLES
-- =========================================================

CREATE TABLE dim_location (
    location_key INT AUTO_INCREMENT PRIMARY KEY,
    location_id INT,
    governorate VARCHAR(100),
    city VARCHAR(100),
    region VARCHAR(100),
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6),
    population_total INT,
    population_male INT,
    population_female INT,
    youth_percentage DECIMAL(5,2),
    avg_monthly_income DECIMAL(12,2)
);

CREATE TABLE dim_property_type (
    property_type_key INT AUTO_INCREMENT PRIMARY KEY,
    property_type VARCHAR(50) UNIQUE
);

CREATE TABLE dim_listing_type (
    listing_type_key INT AUTO_INCREMENT PRIMARY KEY,
    listing_type VARCHAR(50) UNIQUE
);

CREATE TABLE dim_price_period (
    price_period_key INT AUTO_INCREMENT PRIMARY KEY,
    price_period VARCHAR(50) UNIQUE
);

CREATE TABLE dim_businesstype (
    businesstype_key INT AUTO_INCREMENT PRIMARY KEY,
    businesstype_id INT,
    type_name VARCHAR(100)
);

CREATE TABLE dim_competitor (
    competitor_key INT AUTO_INCREMENT PRIMARY KEY,
    competitor_id INT,
    location_id INT,
    business_name VARCHAR(200),
    businesstype_id INT,
    category VARCHAR(100),
    rating DECIMAL(3,2),
    reviews_count INT,
    price_level VARCHAR(20)
);

CREATE TABLE dim_cost_of_living (
    costofliving_key INT AUTO_INCREMENT PRIMARY KEY,
    cost_id INT,
    location_id INT,
    category VARCHAR(100),
    item VARCHAR(200),
    avg_price_egp DECIMAL(12,2),
    min_price_egp DECIMAL(12,2),
    max_price_egp DECIMAL(12,2)
);

CREATE TABLE dim_date (
    date_key INT PRIMARY KEY, 
    full_date DATE,
    day_num INT,
    day_name VARCHAR(20),
    week_num INT,
    month_num INT,
    month_name VARCHAR(20),
    quarter_num INT,
    year_num INT
);

-- =========================================================
-- FACT TABLE
-- =========================================================

CREATE TABLE fact_listing_market (
    fact_id BIGINT AUTO_INCREMENT PRIMARY KEY,

    location_key INT NOT NULL,
    property_type_key INT NOT NULL,
    listing_type_key INT NOT NULL,
    price_period_key INT NOT NULL,
    businesstype_key INT,
    competitor_key INT,
    costofliving_key INT,
    date_key INT NOT NULL,

    listing_count INT DEFAULT 1,
    total_listing_price DECIMAL(18,2),
    avg_price_egp DECIMAL(18,2),
    avg_price_per_sqm DECIMAL(18,2),
    min_price_egp DECIMAL(18,2),
    max_price_egp DECIMAL(18,2),

    CONSTRAINT fk_fact_location
        FOREIGN KEY (location_key)
        REFERENCES dim_location(location_key),

    CONSTRAINT fk_fact_property_type
        FOREIGN KEY (property_type_key)
        REFERENCES dim_property_type(property_type_key),

    CONSTRAINT fk_fact_listing_type
        FOREIGN KEY (listing_type_key)
        REFERENCES dim_listing_type(listing_type_key),

    CONSTRAINT fk_fact_price_period
        FOREIGN KEY (price_period_key)
        REFERENCES dim_price_period(price_period_key),

    CONSTRAINT fk_fact_businesstype
        FOREIGN KEY (businesstype_key)
        REFERENCES dim_businesstype(businesstype_key),

    CONSTRAINT fk_fact_competitor
        FOREIGN KEY (competitor_key)
        REFERENCES dim_competitor(competitor_key),

    CONSTRAINT fk_fact_cost_of_living
        FOREIGN KEY (costofliving_key)
        REFERENCES dim_cost_of_living(costofliving_key),

    CONSTRAINT fk_fact_date
        FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key)
);

