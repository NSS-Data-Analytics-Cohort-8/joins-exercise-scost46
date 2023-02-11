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

