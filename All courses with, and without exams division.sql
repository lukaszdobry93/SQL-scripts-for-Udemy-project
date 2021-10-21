USE udemy;

-- Division of all courses between those, which has, and has not exams included.

SELECT 
    SUM(CASE
        WHEN num_published_practice_tests > 0 THEN 1
        ELSE 0
    END) AS with_exam,
    SUM(CASE
        WHEN num_published_practice_tests = 0 THEN 1
        ELSE 0
    END) AS no_exam,
    COUNT(num_published_practice_tests) AS total
FROM
    course_info;
