-- since the second dataset is to large for SQLiteonline i had to break them up into 4mb size files and create a new table. this can be seen below

create table applestorecombined as 

SELECT * from appleStore_description1

UNION ALL

SELECT * from appleStore_description2

UNION ALL

SELECT * from appleStore_description3

UNION ALL

SELECT * from appleStore_description4

-- Checking the number of UNIQUE apps in both tables to ensure no missing data 

SELECT COUNT(DISTINCT id) as uniqueappleid
from AppleStore

SELECT COUNT(DISTINCT id) as uniqueappleid
from applestorecombined

-- both tables have a count of 7197 therefore no missing values 
-- now i will check for missing VALUES in dome of the important fields

select COUNT(*) as missingvalues
from applestore
WHERE track_name is null or user_rating is NULL

select COUNT(*) as missingvalues
from applestorecombined
WHERE app_desc is null or track_name is NULL

-- no missing values in both tavles therefore dataset is clean


-- *Exploratory Data Analysis* --

-- finding the number of apps per genre
select prime_genre, COUNT (*) as numberofapps
from AppleStore
group by prime_genre
order by numberofapps DESC

-- can see that games, entertainment and eductaion are the top 3 

SELECT prime_genre, 
       SUM(CASE WHEN price = 0 THEN 1 ELSE 0 END) AS free_apps,
       SUM(CASE WHEN price > 0 THEN 1 ELSE 0 END) AS paid_apps
FROM AppleStore
GROUP BY prime_genre;

-- This query separates the genres into free and paid apps and counts how many of each are present, This query provides insight into the distribution of free and paid apps across different genres.AppleStore 
--This query allows the developer to identify trends and patterns related to pricing and popularity across different genres. For example, if they notice that certain genres tend to have a higher proportion of paid apps, they might consider exploring the reasons behind this trend and whether users in those genres are more willing to pay for apps with certain features.


-- overeview the apps ratings 

SELECT min(user_rating) as Minimunrating, max(user_rating) as Maximunrating, avg(user_rating) as Avgrating
from AppleStore

-- minimum 0, max 5 and average rating is 3.53

SELECT prime_genre, AVG(user_rating) AS avg_rating
FROM AppleStore
GROUP BY prime_genre
ORDER BY avg_rating DESC
limit 5;

--productivity,music,photo,fitness and business apps have the higest average rating 
-- The query focuses on calculating the average user rating for each genre and then orders the results in descending order of average rating. For an app developer, this information is valuable for understanding which genres tend to have the highest user satisfaction. This can help the developer prioritize and allocate resources to genres that are likely to yield better user engagement and long-term success.

SELECT prime_genre,
       MIN(size_bytes) AS min_size,
       MAX(size_bytes) AS max_size,
       AVG(size_bytes) AS avg_size
FROM AppleStore
GROUP BY prime_genre;

--This query helps you understand the range of app sizes within each genre.

--It gives the developer a snapshot of what types of apps are currently most popular, which can serve as inspiration for their new app idea.
SELECT track_name, prime_genre, rating_count_tot AS downloads
FROM AppleStore
ORDER BY downloads DESC
LIMIT 10;


--This query provides a breakdown of the number of apps in each genre. An app developer can use this information to identify genres that are saturated with apps and those that have fewer options. Opting for a less competitive genre might allow the developer's app to stand out more easily.

Average Ratings by Category:
sql
Copy code
SELECT prime_genre, AVG(user_rating) AS avg_rating
FROM AppData
GROUP BY prime_genre
ORDER BY avg_rating DESC;
Explanation: By calculating the average user rating for each genre, this query helps the developer understand which genres tend to have higher user satisfaction. Creating an app in a genre with higher average ratings increases the likelihood of users enjoying the new app as well.

Downloads and Reviews Correlation:
sql
Copy code
SELECT prime_genre, AVG(user_rating) AS avg_rating, AVG(rating_count_tot) AS avg_reviews
FROM AppData
GROUP BY prime_genre
ORDER BY avg_rating DESC;
Explanation: This query provides insight into the correlation between user ratings and the number of reviews for each genre. A developer can determine if genres with high average ratings also tend to have a significant number of reviews, indicating user engagement and potential interest in their app.

Top Apps by Downloads:
sql
Copy code
SELECT track_name, prime_genre, rating_count_tot AS downloads
FROM AppData
ORDER BY downloads DESC
LIMIT 10;
-- This query lists the top 10 apps by the number of downloads within each genre. It gives the developer a snapshot of what types of apps are currently most popular, which can serve as inspiration for their new app idea.


SELECT ROUND(user_rating) AS rounded_rating, COUNT(*) AS number_of_apps
FROM AppData
GROUP BY rounded_rating
ORDER BY rounded_rating;
--Explanation: This query breaks down the distribution of user ratings into rounded categories. This can help the developer understand the user sentiment landscape and where there might be potential gaps or opportunities for creating apps with certain rating ranges.

Downloads and Ratings Distribution:
sql
Copy code

SELECT ROUND(user_rating) AS rounded_rating, AVG(rating_count_tot) AS avg_downloads
FROM AppData
GROUP BY rounded_rating
ORDER BY rounded_rating;
--This query analyzes the average number of downloads for each rounded user rating. It helps the developer see how downloads are distributed across different user rating ranges. This information can influence the developer's decision on the expected user engagement for apps in different rating categories.
--By examining the results of these queries, the app developer can gain insights into genres with fewer apps, genres that are popular with users, potential niches with high user engagement, and trends among top-rated and highly downloaded apps. This data-driven approach can guide the developer in choosing a genre for their new app that aligns with market demand and user preferences.


SELECT prime_genre, AVG(user_rating) AS avg_rating
FROM AppleStore
GROUP BY prime_genre
ORDER BY avg_rating DESC;
--By calculating the average user rating for each genre, this query helps the developer understand which genres tend to have higher user satisfaction. Creating an app in a genre with higher average ratings increases the likelihood of users enjoying the new app as well.

Downloads and Reviews Correlation:
sql
Copy code
SELECT prime_genre, AVG(user_rating) AS avg_rating, AVG(rating_count_tot) AS avg_reviews
FROM AppData
GROUP BY prime_genre
ORDER BY avg_rating DESC;
Explanation: This query provides insight into the correlation between user ratings and the number of reviews for each genre. A developer can determine if genres with high average ratings also tend to have a significant number of reviews, indicating user engagement and potential interest in their app.

Top Apps by Downloads:
sql
Copy code
SELECT track_name, prime_genre, rating_count_tot AS downloads
FROM AppData
ORDER BY downloads DESC
LIMIT 10;
Explanation: This query lists the top 10 apps by the number of downloads within each genre. It gives the developer a snapshot of what types of apps are currently most popular, which can serve as inspiration for their new app idea.

Distribution of Ratings:
sql
Copy code
SELECT ROUND(user_rating) AS rounded_rating, COUNT(*) AS number_of_apps
FROM AppData
GROUP BY rounded_rating
ORDER BY rounded_rating;
-- This query breaks down the distribution of user ratings into rounded categories. This can help the developer understand the user sentiment landscape and where there might be potential gaps or opportunities for creating apps with certain rating ranges.

Downloads and Ratings Distribution:
sql
Copy code
SELECT ROUND(user_rating) AS rounded_rating, AVG(rating_count_tot) AS avg_downloads
FROM AppData
GROUP BY rounded_rating
ORDER BY rounded_rating;
--This query analyzes the average number of downloads for each rounded user rating. It helps the developer see how downloads are distributed across different user rating ranges. This information can influence the developer's decision on the expected user engagement for apps in different rating categories.
--By examining the results of these queries, the app developer can gain insights into genres with fewer apps, genres that are popular with users, potential niches with high user engagement, and trends among top-rated and highly downloaded apps. This data-driven approach can guide the developer in choosing a genre for their new app that aligns with market demand and user preferences.

SELECT prime_genre, MIN(price) AS min_price, MAX(price) AS max_price , avg(price) as avg_price
FROM AppleStore
GROUP BY prime_genre;

--This query provides the range of app prices within each genre. It gives the developer an idea of price trends across different genres and whether certain genres tend to have higher or lower-priced apps.

SELECT prime_genre, COUNT(*) AS number_of_apps
FROM AppleStore
GROUP BY prime_genre
ORDER BY number_of_apps DESC;


-- data analysis --

-- determine weather paid apps have higher ratings than free apps

SELECT CASE
when price  > 0 then 'paid'
else 'free'
end as App_type,
avg(user_rating) as avg_rating 
from AppleStore
group by app_type

-- we can see that paid apps (3.7) do have a higher rating than free apps (3.3)

-- want to see if apps with more than 10 languages have higer ratings?

SELECT case 
 when lang_num < 10 then '< 10 languages'
 when lang_num BETWEEN 10 and 30 then '< 10-30 languages'
 else '>30 languages'
 end as language_bucket,
 avg(user_rating) as avg_rating
 from AppleStore
 group by language_bucket
 order by avg_rating DESC
 
 -- we can see that apps that support between 10-30 languages recieve the best rating on average (4.1) in comparison to app with less than 10 (3.3) and over 30 (3.7)
 
 -- check the genres with low ratings
 
 select prime_genre , avg(user_rating) as avg_rating
 from AppleStore
 group by prime_genre
 order by avg_rating ASC
 limit 5
 
-- catalogs,finance,book,navigation,lifestyle and more have the lowest ratings out of all genres (use this as a oppourtunity create a app in this area)

-- check if there is a correlation  between the length of app description and user rating

SELECT case 
when length(b.app_desc) < 500 then 'short'
when length(b.app_desc) between 500 and 1000 then 'Medium'
else 'long'
end as descriptionlength,
avg(a.user_rating) as avgrating 

FROM

AppleStore as A
JOIN
applestorecombined as B 

on a.id = b.id

group by descriptionlength
order by avgrating DESC


-- can see that apps with long descripion length (over 1000 characters) have a average rating of 3.8 in comparison to apps with a short description lenght ( 2.5)

-- now i want to find the top app per genre 

      
SELECT prime_genre, track_name, user_rating
FROM (
    SELECT prime_genre, track_name, user_rating,
           ROW_NUMBER() OVER (PARTITION BY prime_genre ORDER BY user_rating DESC, rating_count_tot) AS row_num
    FROM AppleStore
) AS ranked_data
WHERE ranked_data.row_num = 1;

-- useful to look at for inspiration for whatever genre you pick 

SELECT prime_genre, 
       CASE 
           WHEN price = 0 THEN 'Free'
           WHEN price > 0 AND price <= 5 THEN 'Low Price'
           WHEN price > 5 AND price <= 20 THEN 'Mid Price'
           ELSE 'High Price'
       END AS price_range,
       AVG(user_rating) AS avg_user_rating
FROM AppleStore
GROUP BY prime_genre, price_range
ORDER BY prime_genre, avg_user_rating DESC;
--This query helps you see if there's a connection between app price and user ratings in various genres.

SELECT CASE 
           WHEN price = 0 THEN 'Free'
           WHEN price <= 2.99 THEN 'Low'
           ELSE 'High'
         END AS price_tier,
       AVG(user_rating) AS avg_rating,
       AVG(rating_count_tot) AS avg_reviews
FROM AppleStore
GROUP BY price_tier
ORDER BY avg_rating DESC;

--By categorizing apps into different price tiers, this query analyses the average user rating and average reviews for each tier. It helps the developer understand the relationship between app pricing, user satisfaction, and engagement.

--relationship BETWEEN app size and ratings 

SELECT prime_genre, AVG(user_rating) AS avg_rating, AVG(size_bytes) AS avg_size_bytes
FROM AppleStore
GROUP BY prime_genre
ORDER BY avg_rating DESC;

--By analyzing the relationship between app size and user ratings, this query assists the developer in understanding whether app size impacts user satisfaction.


-- based on the following results we can summerise as below
--paid apps have better ratings 
--apps with 10-20 languages have better ratings 
--games,entertainment and eduction have the highest competitionAppleStore
--apps that cost more than 2.99 have a higher avg rating than a free one 
--apps with longer descriptions tend to have better ratings on average
      