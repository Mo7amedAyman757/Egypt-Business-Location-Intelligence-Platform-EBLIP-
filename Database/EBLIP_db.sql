CREATE DATABASE EBLIP_db;
GO

USE EBLIP_db;
GO

-- LOCATION
CREATE TABLE LOCATION (
    Location_ID INT PRIMARY KEY IDENTITY(1,1),
    Governorate NVARCHAR(100) NOT NULL,
    City NVARCHAR(100),
    Region NVARCHAR(100),
    Latitude DECIMAL(10, 6),
    Longitude DECIMAL(10, 6)
);

-- DEMOGRAPHICS
CREATE TABLE DEMOGRAPHICS (
    Location_ID INT PRIMARY KEY,
    Population_Total INT,
    Population_Male INT,
    Population_Female INT,
    Youth_Percentage DECIMAL(5, 2),
    Avg_Monthly_Income DECIMAL(12, 2),
    CONSTRAINT FK_Demographics_Location FOREIGN KEY (Location_ID) 
        REFERENCES LOCATION(Location_ID) ON DELETE CASCADE
);

-- UNIVERSITY_STUDENTS
CREATE TABLE UNIVERSITY_STUDENTS (
    Uni_Student_ID INT PRIMARY KEY IDENTITY(1,1),
    Location_ID INT,
    University NVARCHAR(255),
    University_Type NVARCHAR(100),
    Num_Male INT,
    Num_Female INT,
    Total_Students INT,
    CONSTRAINT FK_UniStudents_Location FOREIGN KEY (Location_ID) 
        REFERENCES LOCATION(Location_ID)
);

-- LABOR_FORCE
CREATE TABLE LABOR_FORCE (
    Labor_ID INT PRIMARY KEY IDENTITY(1,1),
    Location_ID INT,
    Num_Male INT,
    Num_Female INT,
    Total_Labor_Force INT,
    CONSTRAINT FK_LaborForce_Location FOREIGN KEY (Location_ID) 
        REFERENCES LOCATION(Location_ID)
);

-- EMPLOYMENT_BY_INDUSTRY
CREATE TABLE EMPLOYMENT_BY_INDUSTRY (
    Employment_ID INT PRIMARY KEY IDENTITY(1,1),
    Location_ID INT,
    Industry NVARCHAR(150),
    Num_Male INT,
    Num_Female INT,
    Total_Employed INT,
    CONSTRAINT FK_Employment_Location FOREIGN KEY (Location_ID) 
        REFERENCES LOCATION(Location_ID)
);

-- COST_OF_LIVING
CREATE TABLE COST_OF_LIVING (
    Cost_ID INT PRIMARY KEY IDENTITY(1,1),
    Location_ID INT,
    Category NVARCHAR(100),
    Item NVARCHAR(150),
    Avg_Price_EGP DECIMAL(12, 2),
    Min_Price_EGP DECIMAL(12, 2),
    Max_Price_EGP DECIMAL(12, 2),
    CONSTRAINT FK_CostOfLiving_Location FOREIGN KEY (Location_ID) 
        REFERENCES LOCATION(Location_ID)
);

-- BUSINESS_TYPE
CREATE TABLE BUSINESS_TYPE (
    BusinessType_ID INT PRIMARY KEY IDENTITY(1,1),
    Type_Name NVARCHAR(100) NOT NULL
);

-- COMPETITOR
CREATE TABLE COMPETITOR (
    Competitor_ID INT PRIMARY KEY IDENTITY(1,1),
    Location_ID INT,
    BusinessType_ID INT,
    Business_Name NVARCHAR(255),
    Category NVARCHAR(100),
    Rating DECIMAL(2, 1),
    Reviews_Count INT,
    Price_Level NVARCHAR(50),
    CONSTRAINT FK_Competitor_Location FOREIGN KEY (Location_ID) 
        REFERENCES LOCATION(Location_ID),
    CONSTRAINT FK_Competitor_Type FOREIGN KEY (BusinessType_ID) 
        REFERENCES BUSINESS_TYPE(BusinessType_ID)
);

-- PROPERTY
CREATE TABLE PROPERTY (
    Property_ID INT PRIMARY KEY IDENTITY(1,1),
    Location_ID INT,
    Property_Type NVARCHAR(50),
    Size_sqm DECIMAL(10, 2),
    Latitude DECIMAL(10, 6),
    Longitude DECIMAL(10, 6),
    CONSTRAINT CHK_PropertyType CHECK (Property_Type IN ('Apartment', 'Shop', 'Clinic', 'Villa', 'Land', 'Office')),
    CONSTRAINT FK_Property_Location FOREIGN KEY (Location_ID) 
        REFERENCES LOCATION(Location_ID)
);

-- LISTING
CREATE TABLE LISTING (
    Listing_ID INT PRIMARY KEY IDENTITY(1,1),
    Property_ID INT,
    Listing_Type NVARCHAR(50),
    Price_EGP DECIMAL(15, 2),
    Price_Per_Sqm DECIMAL(12, 2),
    Price_Period NVARCHAR(20),
    Title NVARCHAR(255),
    Date_Listed DATE,
    CONSTRAINT CHK_ListingType CHECK (Listing_Type IN ('Rental', 'Sale', 'Commercial_Rent')),
    CONSTRAINT CHK_PricePeriod CHECK (Price_Period IN ('monthly', 'total')),
    CONSTRAINT FK_Listing_Property FOREIGN KEY (Property_ID) 
        REFERENCES PROPERTY(Property_ID) ON DELETE CASCADE
);
GO