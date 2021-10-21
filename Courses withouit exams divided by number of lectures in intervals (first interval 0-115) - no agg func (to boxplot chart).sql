use udemy;
-- Because majority of courses are inside 0 - 115 interval, there have been decided to analyze that interval separetly. 

SET @interval_lenght2 =
(SELECT (115-MIN(num_published_lectures))/6 AS interval_lenght2 FROM course_info
WHERE num_published_practice_tests = 0 OR num_published_practice_tests IS NULL);

SELECT 
    CASE
        WHEN
            num_published_lectures >= 0
                AND num_published_lectures <= @interval_lenght2
        THEN
            '4 - 22'
        WHEN
            num_published_lectures > @interval_lenght2
                AND num_published_lectures <= (@interval_lenght2 * 2)
        THEN
            '23 - 41'
        WHEN
            num_published_lectures > (@interval_lenght2 * 2)
                AND num_published_lectures <= (@interval_lenght2 * 3)
        THEN
            '42 - 60'
        WHEN
            num_published_lectures > (@interval_lenght2 * 3)
                AND num_published_lectures <= (@interval_lenght2 * 4)
        THEN
            '61 - 78'
        WHEN
            num_published_lectures > (@interval_lenght2 * 4)
                AND num_published_lectures <= (@interval_lenght2 * 5)
        THEN
            '79 - 97'
        WHEN num_published_lectures > (@interval_lenght2 * 5) THEN '98 >'
    END AS no_of_lectures_in_interval,
    avg_rating,
    num_subscribers
FROM
    course_info ci
        JOIN
    rating_subs rs ON rs.id = ci.id
WHERE
    (num_published_practice_tests = 0
        OR num_published_practice_tests IS NULL)
        AND (num_published_lectures < 116)
;
