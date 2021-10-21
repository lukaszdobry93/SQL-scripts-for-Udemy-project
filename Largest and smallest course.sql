
-- Calculating smallest, and largest number of lectures in course.

USE udemy;
(SELECT 
    title, num_published_lectures
FROM
    course_info
WHERE
    (num_published_practice_tests = 0
        OR num_published_practice_tests IS NULL)
ORDER BY num_published_lectures ASC
LIMIT 1)
UNION ALL
(SELECT 
    title, num_published_lectures
FROM
    course_info
WHERE
    (num_published_practice_tests = 0
        OR num_published_practice_tests IS NULL)
ORDER BY num_published_lectures DESC
LIMIT 1);

