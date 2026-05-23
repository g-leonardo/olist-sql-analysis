--Qual o faturamento total da Olist?
SELECT sum((price) + (freight_value)) AS faturamento
FROM orders AS t1
LEFT JOIN order_items AS t2
ON t1.order_id = t2.order_id
WHERE t1.order_status = 'delivered'
-- Qual o ticket médio por pedido?
WITH tb_fat_npedidos AS(
    SELECT sum((price) + (freight_value)) AS faturamento,
        COUNT(DISTINCT t1.order_id) AS numeros_de_pedidos 
    FROM orders AS t1
    LEFT JOIN order_items AS t2
    ON t1.order_id = t2.order_id
    WHERE t1.order_status = 'delivered'
)
SELECT *,
       (faturamento) / (numeros_de_pedidos) AS ticket_medio
FROM tb_fat_npedidos
-- Quantos pedidos por mês? 
SELECT 
  strftime('%Y-%m', order_purchase_timestamp) AS mes,
  COUNT(order_id) AS total_pedidos
FROM orders
WHERE order_status = 'delivered'
GROUP BY mes
ORDER BY mes;





