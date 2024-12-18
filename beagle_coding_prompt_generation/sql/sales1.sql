--- CTE to create max_value temporary table to call later

WITH max_values AS (
	SELECT 
		COALESCE(CAST(MAX(CASE WHEN payment_cycle = 'BIWEEK' 
			THEN price ELSE NULL END) AS FLOAT), 0) AS biweekly_max_price,
		COALESCE(CAST(MAX(CASE WHEN payment_cycle = 'MONTH' 
			THEN price ELSE NULL END) AS FLOAT), 0) AS monthly_max_price,
		COALESCE(CAST(MAX(CASE WHEN payment_cycle = 'ANNUAL' 
			THEN price ELSE NULL END) AS FLOAT), 0) AS annually_max_price,
		status,
		shipping_state
	FROM 
		Remotask1.dbo.mode_one
	WHERE
		 YEAR(purchased_at) >= 2020 
	GROUP BY 
		status, 
		shipping_state
	)
SELECT * FROM max_values
WHERE 
	biweekly_max_price != 0 AND
	monthly_max_price != 0 AND
	annually_max_price != 0
ORDER BY 
	status ASC



-- The output would be:
-- biweekly_max_price, monthly_max_price, annually_max_price, status, shipping_state
-- 1803, 1803, 2300.090088, COMPLETED, AL
-- 1803, 35.59999847, 2300.090088, COMPLETED, AZ
-- 59.99000168,	65.98999786,	2300.090088, COMPLETED,	CA
-- 1803, 65.98999786, 2300.090088, COMPLETED, CO
-- 1439, 108.9899979, 171.8899994, COMPLETED, CT
-- 1439, 1803	1803	COMPLETED	DE