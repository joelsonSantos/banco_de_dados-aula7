-- Analysing sales and returns by country:

SELECT * FROM vendas;

CREATE VIEW view_total_country_sales AS
(
SELECT
	"ship-country",
	"ship-service-level",
	COUNT(*) AS total_sales
FROM vendas
GROUP BY "ship-country", "ship-service-level"
ORDER BY "ship-country" 
);

-- 
CREATE VIEW view_shipped_but_not_fulfilled AS
(
SELECT
	"ship-country",
	"ship-service-level",
	COUNT(*) AS shipped_but_not_fulfilled
FROM vendas
WHERE "Courier Status"  = 'Shipped'
AND "Fulfillment" = 'No'
GROUP BY "ship-country", "ship-service-level"
);

-- All shipped packages are fulfilled.

--
CREATE VIEW view_shipped_and_fulfilled AS
(
SELECT
	"ship-country",
	"ship-service-level",
	COUNT(*) AS shipped_and_fulfilled
FROM vendas
WHERE "Courier Status"  = 'Shipped'
AND "Fulfillment" = 'Yes'
GROUP BY "ship-country", "ship-service-level"
);

--
CREATE VIEW view_fulfilled_but_cancelled AS
(
SELECT
	"ship-country",
	"ship-service-level",
	COUNT(*) AS fulfilled_but_cancelled
FROM vendas
WHERE "Courier Status"  = 'Cancelled'
AND "Fulfillment" = 'Yes'
GROUP BY "ship-country", "ship-service-level"
);

-- Deliveries to Brazil tend to be cancelled after their fufillment!

--
CREATE VIEW view_cancelled_and_not_fulfilled AS
(
SELECT
	"ship-country",
	"ship-service-level",
	COUNT(*) AS cancelled_and_not_fulfilled
FROM vendas
WHERE "Courier Status"  = 'Cancelled'
AND "Fulfillment" = 'No'
GROUP BY "ship-country", "ship-service-level"
);

--

CREATE TABLE deliveries_table AS
(
SELECT 
	tcs."ship-country",
	tcs."ship-service-level",
	SUM(tcs.total_sales) AS total_sales, 
	SUM(sbnf.shipped_but_not_fulfilled) AS shipped_but_not_fulfilled,
	SUM(saf.shipped_and_fulfilled) AS shipped_and_fulfilled,
	SUM(fbc.fulfilled_but_cancelled) AS fulfilled_but_cancelled,
	SUM(canf.cancelled_and_not_fulfilled) AS cancelled_and_not_fulfilled
FROM view_total_country_sales AS tcs
FULL JOIN view_shipped_but_not_fulfilled AS sbnf 
ON tcs."ship-country" = sbnf."ship-country"
FULL JOIN view_shipped_and_fulfilled AS saf 
ON tcs."ship-country" = saf."ship-country"
FULL JOIN view_fulfilled_but_cancelled AS fbc 
ON tcs."ship-country" = fbc."ship-country"
FULL JOIN view_cancelled_and_not_fulfilled AS canf 
ON tcs."ship-country" = canf."ship-country"
GROUP BY tcs."ship-country", tcs."ship-service-level" 
);




