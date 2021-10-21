SELECT 
    CASE
        WHEN num_published_practice_tests = 1 THEN '1 exam'
        WHEN num_published_practice_tests = 2 THEN '2 exams'
        WHEN num_published_practice_tests = 3 THEN '3 exams'
        WHEN num_published_practice_tests = 4 THEN '4 exams'
        WHEN num_published_practice_tests = 5 THEN '5 exams'
        WHEN num_published_practice_tests = 6 THEN '6 exams'
    END AS no_of_exams_in_interval,
    title,
    ROUND(avg_rating, 2) AS average_rating,
    num_subscribers
FROM
    course_info ci
        JOIN
    rating_subs rs ON rs.id = ci.id
WHERE
    num_published_practice_tests != 0
ORDER BY num_published_practice_tests ASC;