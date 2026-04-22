#Creating database 
create database hospitality;
use hospitality;

#creating table dim_date
create table dim_date(date date, mmm_yy varchar(8), week_no varchar(5) ,day_type varchar(9));
select count(*) from dim_date;

#creating table dim_hotels
create table dim_hotels(property_id int, property_name varchar(15),
category varchar(10),city varchar(12));
select * from dim_hotels;

#creating table dim_rooms
create table  dim_rooms(room_id varchar(4),room_class varchar(15));
select * from dim_rooms;

#creating table fact_aggregated_bookings
create table fact_aggregated_bookings(property_id int,check_in_date date,
room_id varchar(4), successful_bookings int, capacity int);
select * from fact_aggregated_bookings;

#creating table fact_bookings
CREATE TABLE fact_bookings (
    booking_id VARCHAR(20),
    property_id INT,
    booking_date DATE,
    check_in_date DATE,
    checkout_date DATE,
    no_guests INT,
    room_category VARCHAR(10),
    booking_platform VARCHAR(50),
    ratings_given DECIMAL(3,1) NULL,
    booking_status VARCHAR(20),
    revenue_generated INT,
    revenue_realized INT
);

LOAD DATA LOCAL INFILE "D:\\Prashant\\Excelr project\\DA_P1099 Dataset\\SQL\\SQL csv\\fact_bookings.csv"
INTO TABLE fact_bookings
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
 booking_id,
 property_id,
 booking_date,
 check_in_date,
 checkout_date,
 no_guests,
 room_category,
 booking_platform,
 @ratings_given,
 booking_status,
 revenue_generated,
 revenue_realized
)
SET ratings_given = NULLIF(@ratings_given, '');
use hospitality;
SELECT COUNT(*) FROM fact_bookings;

SHOW VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;

SHOW VARIABLES LIKE 'local_infile';


SELECT @@secure_file_priv;

LOAD DATA INFILE
"C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\fact_bookings.csv"
INTO TABLE fact_bookings
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
 booking_id,
 property_id,
 booking_date,
 check_in_date,
 checkout_date,
 no_guests,
 room_category,
 booking_platform,
 @ratings_given,
 booking_status,
 revenue_generated,
 revenue_realized
)
SET ratings_given = NULLIF(@ratings_given, '');

select * from fact_bookings;


