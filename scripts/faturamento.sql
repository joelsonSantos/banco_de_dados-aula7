CREATE TABLE faturamento AS (
SELECT
	to_date(v."Date", 'MM/DD/YYYY') AS data_venda,
	SUM(v."Qty") AS qty_venda,
	COUNT(v."Qty") AS num_vendas,
	SUM(v."Qty"  * CAST(REPLACE(p."Preco", '$', '') AS FLOAT)) AS faturamento
FROM vendas AS v
JOIN produtos AS p
ON v."Codigo" = p."Codigo"
WHERE "Courier Status" != 'Cancelled' 
GROUP BY "Date", "Courier Status"
ORDER BY to_date("Date", 'MM/DD/YYYY')
);
