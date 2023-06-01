
create database zomato;

use zomato;

/* Identify the most popular cuisines based on the frequency of occurrence in the dataset. 
You can calculate the count of each cuisine and rank them accordingly. */

select top 10 cuisines ,count(cuisines) as count from zomato group by cuisines order by count(cuisines) desc

/* What is the average rating of restaurants in the dataset? */
select  sum(cast(rating as float))/count(cast(rating as float)) as avg_rating_of_restaurants from zomato where rating is not null

/* Which city has the highest number of restaurants? */
select city,count(city) as restaurants_count from zomato group by city order by restaurants_count desc

/* What is the average price range of restaurants in each city? 
List the cities along with their corresponding average price range.*/
select city,avg(price_range) as avg_price from zomato group by city order by avg_price desc

/* Which cuisine is the most popular in each city? 
List the cities along with the corresponding most popular cuisine. */
select city,cuisines,count(cuisines) as count_of_cuisines from zomato group by city,cuisines order by count_of_cuisines desc

/* 6.What is the distribution of restaurant ratings across different price ranges? 
List the price range along with the count of restaurants in each rating category. */
select price_range,count(restaurant_name) as total_count from zomato group by price_range

/* 7. Which restaurants have the highest average ratings? 
List the top 10 restaurants along with their average ratings. */
select top 10 restaurant_name,avg(cast(rating as float)) as avg_rating from zomato group by restaurant_name order by avg_rating desc

/* 8. What is the overall distribution of restaurant ratings? 
List the count of restaurants for each rating category. */
select rating,count(restaurant_name) as count from zomato group by rating having rating is not null

/* 9.What is the average cost of dining for each cuisine? 
List the cuisines along with their corresponding average cost. */
select cuisines,avg(average_cost) as avg_cost from zomato group by cuisines

/* 10. Which cuisines are the most popular in the largest cities? 
List the top 5 cuisines along with the count of restaurants offering those cuisines in the largest cities. */

SELECT top 5 c.cuisines, COUNT(z.restaurant_name) AS restaurant_count
FROM largest_cities lc
JOIN zomato z ON lc.city = z.city
JOIN cuisines c ON c.cuisines = z.cuisines
GROUP BY c.cuisines
ORDER BY restaurant_count DESC

/*11. What is the average cost for dining in restaurants that offer vegetarian cuisine? 
List the average cost along with the corresponding cuisine. */

select z.cuisines,avg(z.average_cost) as avg_cost 
from zomato z join cuisines c on z.Cuisines=c.cuisines 
where c.[mostly vegetarian]='yes' 
group by z.Cuisines


/* 12. What is the average rating for restaurants in each city? List the cities along with their corresponding average ratings. ? */

select city,avg(cast(rating as float)) as avg_rating from zomato group by city

/* 13.What is the percentage of restaurants that offer delivery services in each city? 
List the cities along with the corresponding percentage of restaurants offering delivery. */
update zomato set [Has Online delivery]=0 where [Has Online delivery]='No' 
update zomato set [Has Online delivery]=1 where [Has Online delivery]='Yes'
select city,sum(cast([Has Online delivery] as integer))/count([Has Online delivery])*100 as per_of_restaurants 
from zomato 
group by city 
order by per_of_restaurants desc

/* 14. Which cities have the highest number of restaurants with a high average rating? 
List the top 5 cities along with the count of restaurants having a high average rating. */
select top 5 city,avg(cast(rating as float)) as avg_rating,count(restaurant_name) as number_of_restaurants
from zomato 
group by city 
order by avg_rating desc

/*What are the top 5 most common cuisines offered by restaurants in each city? 
List the city along with the top 5 cuisines and their respective counts.*/
select top 5 city,cuisines,count(cuisines) as count from zomato group by city,cuisines order by count desc