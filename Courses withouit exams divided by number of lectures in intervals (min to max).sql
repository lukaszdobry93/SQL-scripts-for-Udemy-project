-- Calculating the interval number including largest and smallest number of published lectures. This will be the base for analysing data distribution.
-- Chosen amount of intervals is 6, because 6 is also largest numbers of exams in one exam course/package.

-- Creating variable to divide data on equal intervals 

SET @interval_lenght =
(SELECT (MAX(num_published_lectures)-MIN(num_published_lectures))/6 AS interval_lenght FROM course_info
WHERE num_published_practice_tests = 0 OR num_published_practice_tests IS NULL);


-- With created variable, now it is possible to split the data between intervals

SELECT 
    CASE
        WHEN
            num_published_lectures >= 0
                AND num_published_lectures <= @interval_lenght
        THEN
            '0 - 115'
        WHEN
            num_published_lectures > @interval_lenght
                AND num_published_lectures <= (@interval_lenght * 2)
        THEN
            '116 - 231'
        WHEN
            num_published_lectures > (@interval_lenght * 2)
                AND num_published_lectures <= (@interval_lenght * 3)
        THEN
            '232 - 347'
        WHEN
            num_published_lectures > (@interval_lenght * 3)
                AND num_published_lectures <= (@interval_lenght * 4)
        THEN
            '348 - 436'
        WHEN
            num_published_lectures > (@interval_lenght * 4)
                AND num_published_lectures <= (@interval_lenght * 5)
        THEN
            '437 - 579'
        WHEN
            num_published_lectures > (@interval_lenght * 5)
        THEN
            '580 >'
    END AS no_of_lectures_in_interval, COUNT(title) AS no_of_courses, ROUND(AVG(avg_rating),2) AS average_rating, ROUND(AVG(num_subscribers),0) AS average_subs
FROM
    course_info ci
JOIN rating_subs rs ON rs.id = ci.id
WHERE
    (num_published_practice_tests = 0
        OR num_published_practice_tests IS NULL)
GROUP BY no_of_lectures_in_interval
ORDER BY num_published_lectures ASC;
