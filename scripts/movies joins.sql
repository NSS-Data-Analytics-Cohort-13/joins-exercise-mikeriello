-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.

-- SELECT specs.film_title, specs.release_year, revenue.worldwide_gross
-- FROM specs 
-- INNER JOIN revenue
-- ON specs.movie_id = revenue.movie_id
-- ORDER BY worldwide_gross ASC;

-- A: Semi-Tough is the lowest grossing movie of this dataset.

-- 2. What year has the highest average imdb rating?

-- SELECT specs.release_year, AVG(rating.imdb_rating) AS avg_rating
-- FROM specs
-- INNER JOIN rating
-- USING(movie_id)
-- GROUP BY specs.release_year
-- ORDER BY avg_rating DESC;

-- A: 1991 at 7.45.

-- 3. What is the highest grossing G-rated movie? Which company distributed it?

-- SELECT specs.film_title, distributors.company_name, specs.mpaa_rating, revenue.worldwide_gross
-- FROM distributors
-- INNER JOIN specs
-- ON distributors.distributor_id = specs.domestic_distributor_id
-- INNER JOIN revenue
-- ON specs.movie_id = revenue.movie_id
-- GROUP BY specs.film_title, distributors.company_name, specs.mpaa_rating, revenue.worldwide_gross
-- ORDER BY mpaa_rating ASC, worldwide_gross DESC

-- A: The highest grossing G-rated movie is Toy Story 4, and Walt Disney distributed it. 

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

-- SELECT distributors.distributor_ID, distributors.company_name, COUNT(specs.movie_id) AS movie_count
-- FROM distributors
-- LEFT JOIN specs
-- ON distributors.distributor_ID = specs.domestic_distributor_id
-- WHERE specs.movie_id IS NOT NULL OR specs.movie_id IS NULL
-- GROUP BY distributors.distributor_ID, distributors.company_name
-- ORDER BY movie_count DESC

-- 5. Write a query that returns the five distributors with the highest average movie budget.

-- SELECT distributors.distributor_ID, distributors.company_name, AVG(film_budget) AS avg_budget 
-- FROM distributors
-- INNER JOIN specs
-- ON distributors.distributor_id = specs.domestic_distributor_id
-- INNER JOIN revenue
-- ON specs.movie_id = revenue.movie_id
-- GROUP BY distributors.distributor_ID, distributors.company_name 
-- ORDER BY avg_budget DESC
-- LIMIT 5;

-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

-- SELECT distributors.headquarters, specs.film_title, rating.imdb_rating
-- FROM distributors
-- LEFT JOIN specs
-- ON distributors.distributor_id = domestic_distributor_id
-- LEFT JOIN rating
-- ON specs.movie_id = rating.movie_id
-- WHERE headquarters NOT LIKE '%CA%'
-- GROUP BY distributors.headquarters, specs.film_title, rating.imdb_rating
-- ORDER BY rating.imdb_rating DESC;

-- SELECT distributors.headquarters, specs.film_title, rating.imdb_rating
-- FROM distributors
-- LEFT JOIN specs
-- ON distributors.distributor_id = domestic_distributor_id
-- LEFT JOIN rating
-- ON specs.movie_id = rating.movie_id
-- WHERE headquarters NOT LIKE '%CA%'
-- ORDER BY rating.imdb_rating DESC;

-- A. 2 movies, and the highest rating of those two is Dirty Dancing!

-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?

-- SELECT 
-- 	CASE 
-- 		WHEN length_in_min >=0 AND length_in_min <=120 THEN 'Under 2 Hours' 
-- 	ELSE 'Over 2 Hours'
-- 	END AS length_range, 
-- 	AVG(r.imdb_rating) as avg_rating
-- FROM specs as s
-- LEFT JOIN rating as r
-- USING(movie_id)
-- GROUP BY length_range
-- ORDER BY avg_rating DESC;

-- SELECT 'Less than 2 hours' AS movie_length, ROUND(AVG(avg_imdb_rating),2) avg_rating
-- FROM (
-- 	SELECT AVG(r.imdb_rating) AS avg_imdb_rating
-- 	FROM specs AS s
-- 	INNER JOIN rating r
-- 		USING(movie_id) 
-- 	GROUP BY s.length_in_min
-- 	HAVING s.length_in_min<120
-- 	) 
-- UNION ALL
-- SELECT 'Greater than 2 hours' AS movie_length, ROUND(AVG(avg_imdb_rating),2) avg_rating
-- FROM (
-- 	SELECT AVG(r.imdb_rating) AS avg_imdb_rating
-- 	FROM specs AS s
-- 	INNER JOIN rating r
-- 		USING(movie_id) 
-- 	GROUP BY s.length_in_min
-- 	HAVING s.length_in_min>=120
-- 	)