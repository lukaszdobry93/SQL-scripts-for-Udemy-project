SELECT 

-- CASE has been used to for creating new column containing only values for typical group, this solution allows
-- to create multiple filtered columns, and does not affect querry after joins. Also there was created average calculator formula, instead of builded-in in mySQL.
-- Price was given in Indian rupiee, and was transformed in dolars at the course of the day 07.11.2021 (0.013 INR - USD)


    ROUND(SUM(CASE
                WHEN
                    discount_price_amount_INR IS NULL
                        OR discount_price_amount_INR = 0
                THEN
                    price_detail_amount_INR
                ELSE 0
            END) / SUM(CASE
                WHEN
                    discount_price_amount_INR IS NULL
                        OR discount_price_amount_INR = 0
                THEN
                    1
                ELSE 0
            END) * 0.013,
            2) AS avg_price_where_no_discount,
    ROUND(SUM(CASE
                WHEN
                    discount_price_amount_INR IS NOT NULL
                        OR discount_price_amount_INR > 0
                THEN
                    price_detail_amount_INR
                ELSE 0
            END) / SUM(CASE
                WHEN
                    discount_price_amount_INR IS NOT NULL
                        OR discount_price_amount_INR > 0
                THEN
                    1
                ELSE 0
            END) * 0.013,
            2) AS avg_price_where_were_discounts,
    ROUND(SUM(CASE
                WHEN
                    discount_price_amount_INR IS NULL
                        OR discount_price_amount_INR = 0
                THEN
                    num_subscribers
                ELSE 0
            END) / SUM(CASE
                WHEN
                    discount_price_amount_INR IS NULL
                        OR discount_price_amount_INR = 0
                THEN
                    1
                ELSE 0
            END),
            0) AS avg_subs_no_discount,
    ROUND(SUM(CASE
                WHEN
                    discount_price_amount_INR IS NOT NULL
                        OR discount_price_amount_INR > 0
                THEN
                    num_subscribers
                ELSE 0
            END) / SUM(CASE
                WHEN
                    discount_price_amount_INR IS NOT NULL
                        OR discount_price_amount_INR > 0
                THEN
                    1
                ELSE 0
            END),
            0) AS avg_subs_where_were_discount
FROM
    price_info pi
        JOIN
    rating_subs rs ON pi.id = rs.id
        JOIN
    course_info ci ON ci.id = rs.id
;
