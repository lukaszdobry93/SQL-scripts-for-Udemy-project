
-- TOP 3 and The Worst 3 of exams table 

-- BEST, AND NO EXAM
(SELECT 
    published_time,
    title,
    num_published_lectures,
    num_published_practice_tests,
    num_subscribers,
    avg_rating
FROM
    course_info ci
        JOIN
    rating_subs rs ON rs.id = ci.id
WHERE
    num_published_practice_tests = 0
        AND num_subscribers > 1000
ORDER BY avg_rating DESC, num_subscribers DESC
LIMIT 3) 
-- WORST, AND NO EXAM
UNION (SELECT 
    published_time,
    title,
    num_published_lectures,
    num_published_practice_tests,
    num_subscribers,
    avg_rating
FROM
    course_info ci
        JOIN
    rating_subs rs ON rs.id = ci.id
WHERE
    num_published_practice_tests = 0
        AND num_subscribers > 1000
ORDER BY avg_rating ASC , num_subscribers ASC
LIMIT 3) 
-- BEST, WITH EXAM
UNION (SELECT 
    published_time,
    title,
    num_published_lectures,
    num_published_practice_tests,
    num_subscribers,
    avg_rating
FROM
    course_info ci
        JOIN
    rating_subs rs ON rs.id = ci.id
WHERE
    num_published_practice_tests != 0
        AND num_subscribers > 1000
ORDER BY avg_rating DESC, num_subscribers DESC
LIMIT 3) 
-- WORST, WITH EXAM
UNION (SELECT 
    published_time,
    title,
    num_published_lectures,
    num_published_practice_tests,
    num_subscribers,
    avg_rating
FROM
    course_info ci
        JOIN
    rating_subs rs ON rs.id = ci.id
WHERE
    num_published_practice_tests != 0
        AND num_subscribers > 1000
ORDER BY avg_rating ASC, num_subscribers ASC
LIMIT 3);