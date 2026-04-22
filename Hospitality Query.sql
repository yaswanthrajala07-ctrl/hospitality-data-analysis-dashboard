use hospitality;
# Exploratory Analysis:
select * from dim_date;
select * from dim_hotels;
select * from dim_rooms;
select * from fact_aggregated_bookings;
select * from fact_bookings;

/* Important KPIs */

# Total Revenue
select concat(Round(sum(revenue_realized)/1000000,0),"M") Total_revenue from fact_bookings;

#Total Bookings
select  concat(Round(count(booking_id)/1000,0),"K") Total_bookings from fact_bookings;

#Average Raving
select  round(avg(ratings_given),1) Average_Rating from fact_bookings;

# occupancy %

select concat(round(((sum(successful_bookings)/sum(capacity))*100),2),"%") from fact_aggregated_bookings;

# Cancelation Rate 

select concat(round(((select count(booking_id) from fact_bookings 
		where booking_status = "cancelled")/ count(booking_id))*100,2),"%") as cancelation_rate
from fact_bookings;
        
select * from fact_bookings;
 
# Booking status 

Select booking_status ,
	count(booking_status) Count , 
	(count(booking_status)/sum(count(booking_id)) over())*100 percentage 
from fact_bookings
group by 1;

#Weekday and Weekend Total bookings ,Total revenue and their pecentage 
 select	day_type ,
	count(booking_id) Count,
    (count(booking_id)/sum(count(booking_id)) over())*100 count_percentage,
	sum(revenue_realized) Total_revenue,
    (sum(revenue_realized)/sum(sum(revenue_realized)) over())*100 Revenue_percentage
 from fact_bookings as fb
 join dim_date as dd
 on fb.check_in_date = dd.date
 group by 1;


# Revenue and Bookings by State & hotel

select City , property_name , 
	count(booking_id) Count,
	sum(revenue_realized) Revenue 
from fact_bookings as fb
join dim_hotels as dh
on fb.property_id = dh.property_id
group by 1,2
order by 1 asc ,4 desc;

# Class Wise Revenue and bookings

select room_class , 
	count(booking_id) count, 
    (count(booking_id)/sum(count(booking_id)) over())*100 count_percentage,
	sum(revenue_realized) Revenue ,
    (sum(revenue_realized)/sum(sum(revenue_realized)) over())*100 revenue_percentage
from fact_bookings as fb
join dim_rooms as dr
on fb.room_category = dr.room_id
group by 1
order by 3 desc; 


# Weekly trend Key trend (Revenue, Total booking, Occupancy) 

SELECT
  dd.week_no,
  SUM(fb.revenue_realized) AS total_revenue,
  SUM(fab.successful_bookings) AS total_successful_bookings,
  (SUM(fab.successful_bookings) / SUM(fab.capacity))*100 AS occupancy_ratio
FROM fact_bookings fb
JOIN fact_aggregated_bookings fab
  ON  fb.property_id   = fab.property_id
  AND fb.check_in_date = fab.check_in_date
  AND fb.room_category = fab.room_id
JOIN dim_date dd
  ON fb.check_in_date = dd.date
GROUP BY dd.week_no;
 select *from fact_aggregated_bookings;
 
 # Total revenue and Total Bookings By booking platform 
 
 select Booking_Platform ,
 count(booking_id) ,
 (count(booking_id)/sum(count(booking_id)) over())*100 count_percentage,
 sum(revenue_realized) 
 from fact_bookings
 group by 1
 order by 3 desc;
