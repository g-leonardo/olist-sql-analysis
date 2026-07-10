-- ==========================================
-- DELIVERY PERFORMANCE ANALYSIS
-- ==========================================

-- 1. Qual o prazo médio de entrega dos pedidos?

WITH cte_delivery_time AS (
    SELECT
        o.order_id,
        julianday(o.order_delivered_customer_date) -
        julianday(o.order_purchase_timestamp) AS tempo_entrega
    FROM orders AS o
    WHERE o.order_status = 'delivered'
)

SELECT
    ROUND(
        AVG(tempo_entrega),
        2
    ) AS prazo_medio_entrega
FROM cte_delivery_time;


-- 2. Quais estados possuem o maior atraso médio?

WITH cte_delivery_delay AS (
    SELECT
        c.customer_state AS estado,
        julianday(o.order_delivered_customer_date) -
        julianday(o.order_estimated_delivery_date) AS dias_atraso
    FROM orders AS o
    LEFT JOIN customers AS c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
)

SELECT
    estado,
    ROUND(
        AVG(dias_atraso),
        2
    ) AS atraso_medio
FROM cte_delivery_delay
WHERE dias_atraso > 0
GROUP BY estado
ORDER BY atraso_medio DESC
LIMIT 10;


-- 3. Existe relação entre atraso na entrega e avaliação do cliente?

WITH cte_order_delay AS (
    SELECT
        o.order_id,
        r.review_score AS nota_avaliacao,
        julianday(o.order_delivered_customer_date) -
        julianday(o.order_estimated_delivery_date) AS dias_atraso
    FROM orders AS o
    LEFT JOIN order_reviews AS r
        ON o.order_id = r.order_id
    WHERE o.order_status = 'delivered'
      AND r.review_score IS NOT NULL
),

cte_delivery_status AS (
    SELECT
        order_id,
        nota_avaliacao,
        CASE
            WHEN dias_atraso > 0 THEN 'Atrasado'
            ELSE 'No Prazo'
        END AS status_entrega
    FROM cte_order_delay
)

SELECT
    status_entrega,
    ROUND(
        AVG(nota_avaliacao),
        2
    ) AS nota_media,
    COUNT(order_id) AS total_pedidos
FROM cte_delivery_status
GROUP BY status_entrega
ORDER BY nota_media;