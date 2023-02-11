--1. Give the name, release year, and worldwide gross of the lowest grossing movie.
SELECT film_title, release_year, worldwide_gross
FROM revenue
INNER JOIN specs
USING(movie_id)
ORDER BY worldwide_gross ASC
LIMIT 1;
--Semi Tough, 1977, 37,187,139

--2. What year has the highest average imdb rating?
SELECT ROUND(AVG(imdb_rating),2) AS avg_rating, release_year
FROM rating
INNER JOIN specs
USING(movie_id)
GROUP BY release_year
ORDER BY avg_rating DESC
LIMIT 1;
--1991

--3. What is the highest grossing G-rated movie? Which company distributed it?


SELECT worldwide_gross, company_name 
FROM specs
INNER JOIN distributors
ON specs.domestic_distributor_id = distributors.distributor_id
INNER JOIN revenue
ON specs.movie_id = revenue.movie_id
WHERE mpaa_rating = 'G'
ORDER BY worldwide_gross DESC
LIMIT 1;
-- Walt Disney

--4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

SELECT DISTINCT(company_name), COUNT(film_title) AS number_of_films
FROM distributors
INNER JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
GROUP BY DISTINCT(company_name)
ORDER BY number_of_films DESC;

--5. Write a query that returns the five distributors with the highest average movie budget.
SELECT DISTINCT(company_name), ROUND(AVG(film_budget),2) AS avg_budget
FROM distributors
INNER JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
INNER JOIN revenue
ON specs.movie_id = revenue.movie_id
GROUP BY company_name
ORDER BY avg_budget DESC
LIMIT 5;


--6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?
SELECT company_name, headquarters, film_title, imdb_rating
FROM distributors
FULL JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
FULL JOIN rating
ON specs.movie_id = rating.movie_id
WHERE headquarters NOT LIKE '%CA%';
-- 2, Dirty Dancing

--7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
SELECT ROUND(AVG(imdb_rating),2) AS avg_rating
FROM specs
INNER JOIN rating
USING(movie_id)
WHERE length_in_min > 120
UNION ALL
SELECT ROUND(AVG(imdb_rating),2) AS avg_rating
FROM specs
INNER JOIN rating
USING(movie_id)
WHERE length_in_min < 120;
-- over two hours