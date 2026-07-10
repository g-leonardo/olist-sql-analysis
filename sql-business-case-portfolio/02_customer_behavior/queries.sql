-- ==========================================
-- CUSTOMER ANALYSIS
-- ==========================================

-- 1. Quais estados possuem mais clientes?

SELECT
customer_state AS estado,
COUNT(*) AS total_clientes
FROM customers
GROUP BY customer_state
ORDER BY total_clientes DESC
LIMIT 5;

-- 2. Quantos clientes compraram mais de uma vez?

WITH cte_customer_orders AS (
SELECT
c.customer_unique_id AS id_cliente,
COUNT(DISTINCT o.order_id) AS total_pedidos
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
)

SELECT
COUNT(
CASE
WHEN total_pedidos > 1 THEN 1
END
) AS clientes_recorrentes,
COUNT(*) AS total_clientes,
ROUND(
100.0 *
COUNT(
CASE
WHEN total_pedidos > 1 THEN 1
END
) / COUNT(*),
2
) AS percentual_recorrentes
FROM cte_customer_orders;

-- 3. Quais clientes mais gastaram?

WITH cte_customer_revenue AS (
SELECT
c.customer_unique_id AS id_cliente,
ROUND(
SUM(i.price + i.freight_value),
2
) AS gasto_total
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
LEFT JOIN order_items AS i
ON o.order_id = i.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id
)

SELECT
id_cliente,
gasto_total
FROM cte_customer_revenue
ORDER BY gasto_total DESC
LIMIT 10;
