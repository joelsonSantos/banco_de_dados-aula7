create view vendas_diarias as (
	SELECT
		to_date("Date", 'MM/DD/YYYY') AS Data_da_Venda,
		sum("Qty") AS Quantidade_de_Vendas
	FROM vendas
	WHERE "Fulfillment" = 'Yes' 
	GROUP BY "Date"
	ORDER BY to_date("Date", 'MM/DD/YYYY')
);