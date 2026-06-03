-- ==========================================
-- SALES ANALYSIS
-- ==========================================

-- 1. Qual o faturamento total da empresa?

SELECT
    ROUND(SUM(t2.price + t2.freight_value), 2) AS faturamento_total
FROM orders AS t1
LEFT JOIN order_items AS t2
    ON t1.order_id = t2.order_id
WHERE t1.order_status = 'delivered';


-- 2. Qual o ticket médio por pedido?

WITH cte_ticket_medio AS (
    SELECT
        SUM(t2.price + t2.freight_value) AS faturamento_total,
        COUNT(DISTINCT t1.order_id) AS total_pedidos
    FROM orders AS t1
    LEFT JOIN order_items AS t2
        ON t1.order_id = t2.order_id
    WHERE t1.order_status = 'delivered'
)

SELECT
    faturamento_total,
    total_pedidos,
    ROUND(faturamento_total / total_pedidos, 2) AS ticket_medio
FROM cte_ticket_medio;


-- 3. Quantos pedidos por mês?

SELECT
    strftime('%Y-%m', order_purchase_timestamp) AS mes,
    COUNT(order_id) AS total_pedidos
FROM orders
WHERE order_status = 'delivered'
GROUP BY mes
ORDER BY mes;