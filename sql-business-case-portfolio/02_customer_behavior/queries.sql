--Quais estados possuem mais clientes?

SELECT
    customer_state AS estado,
    COUNT(*) AS total_clientes
FROM customers
GROUP BY customer_state
ORDER BY total_clientes DESC
LIMIT 5;

--Quantos clientes compraram mais de uma vez?  

WITH clientes AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_pedidos
    FROM orders o
    LEFT JOIN customers c
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    COUNT(CASE WHEN total_pedidos > 1 THEN 1 END) AS clientes_recorrentes,
    COUNT(*) AS total_clientes,
    ROUND(
        100.0 * COUNT(CASE WHEN total_pedidos > 1 THEN 1 END) / COUNT(*),
        2
    ) AS percentual_recorrentes
FROM clientes;

--Quais clientes mais gastaram?
WITH tb_clientes_pedido AS(
      SELECT o.order_id,
            c.customer_unique_id     
      FROM customers c
      LEFT JOIN orders o
      ON c.customer_id = o.customer_id
      WHERE order_status = 'delivered'
) 
SELECT
    customer_unique_id AS cliente,
    ROUND(SUM(price + freight_value), 2) AS gasto

FROM tb_clientes_pedido cp
LEFT JOIN order_items i 
      ON cp.order_id = i.order_id
GROUP BY customer_unique_id
ORDER BY gasto DESC 
LIMIT 10