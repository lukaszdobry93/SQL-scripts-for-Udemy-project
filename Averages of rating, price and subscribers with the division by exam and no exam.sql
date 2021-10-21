-- Selecting averages of rating, price, and number of subscribers in groups: exam and no exam

SELECT 		

-- CASE has been used to for creating new column containing only values for typical group, this solution allows
-- to create multiple filtered columns, and does not affect querry after joins. Also there was created average calculator formula, instead of builded-in in mySQL.ALL

    ROUND(SUM(CASE		
                WHEN ci.num_published_practice_tests >= 1 THEN rs.avg_rating		
                ELSE 0		
            END) / SUM(CASE		
                WHEN ci.num_published_practice_tests >= 1 THEN 1		
                ELSE 0		
            END),		
            2) AS avg_rating_with_exam,		
	ROUND(SUM(CASE	
                WHEN ci.num_published_practice_tests = 0 THEN rs.avg_rating		
                ELSE 0		
            END) / SUM(CASE		
                WHEN ci.num_published_practice_tests = 0 THEN 1		
                ELSE 0		
            END), 		
            2) AS avg_rating_no_exam,		
	ROUND((SUM(CASE	
                WHEN ci.num_published_practice_tests = 0 THEN pi.price_detail_amount_INR		
                ELSE 0		
            END) / SUM(CASE		
                WHEN ci.num_published_practice_tests = 0 THEN 1		
                ELSE 0		
            END)*0.013), 		
            2) AS avg_price_no_exam,		
	ROUND((SUM(CASE	
                WHEN ci.num_published_practice_tests >= 1 THEN pi.price_detail_amount_INR		
                ELSE 0		
            END) / SUM(CASE		
                WHEN ci.num_published_practice_tests >= 1 THEN 1		
                ELSE 0		
            END)*0.013), 		
            2) AS avg_price_with_exam,		
	ROUND(SUM(CASE	
                WHEN ci.num_published_practice_tests >= 1 THEN rs.num_subscribers		
                ELSE 0		
            END) / SUM(CASE		
                WHEN ci.num_published_practice_tests >= 1 THEN 1		
                ELSE 0		
            END),		
            0) AS avg_subscribers_with_exam,		
	ROUND(SUM(CASE	
                WHEN ci.num_published_practice_tests = 0 THEN rs.num_subscribers		
                ELSE 0		
            END) / SUM(CASE		
                WHEN ci.num_published_practice_tests = 0 THEN 1		
                ELSE 0		
            END), 		
            0) AS avg_subscribers_no_exam		
FROM		
    rating_subs rs		
        JOIN		
    course_info ci ON ci.id = rs.id		
		JOIN
	price_info pi ON pi.id = ci.id	
;