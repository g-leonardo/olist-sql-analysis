-- ==========================================
-- ADVANCED BUSINESS ANALYSIS
-- ==========================================

-- 1. Quais clientes geraram maior receita para a empresa?

WITH cte_customer_revenue AS (
    SELECT
        c.customer_unique_id AS id_cliente,
        COUNT(DISTINCT o.order_id) AS total_pedidos,
        ROUND(
            SUM(i.price + i.freight_value),
            2
        ) AS receita_total
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
    total_pedidos,
    receita_total,
    ROUND(
        receita_total / total_pedidos,
        2
    ) AS ticket_medio
FROM cte_customer_revenue
ORDER BY receita_total DESC
LIMIT 10;


-- 2. Existe sazonalidade diferente entre categorias?

WITH cte_monthly_category_revenue AS (
    SELECT
        strftime('%Y-%m', o.order_purchase_timestamp) AS mes,
        p.product_category_name AS categoria,
        ROUND(
            SUM(i.price + i.freight_value),
            2
        ) AS faturamento
    FROM orders AS o
    LEFT JOIN order_items AS i
        ON o.order_id = i.order_id
    LEFT JOIN products AS p
        ON i.product_id = p.product_id
    WHERE o.order_status = 'delivered'
        AND p.product_category_name IS NOT NULL
    GROUP BY
        mes,
        categoria
),

cte_category_ranking AS (
    SELECT
        mes,
        categoria,
        faturamento,
        ROW_NUMBER() OVER (
            PARTITION BY mes
            ORDER BY faturamento DESC
        ) AS ranking
    FROM cte_monthly_category_revenue
),

cte_monthly_leaders AS (
    SELECT
        categoria
    FROM cte_category_ranking
    WHERE ranking = 1
)

SELECT
    categoria,
    COUNT(*) AS meses_lider
FROM cte_monthly_leaders
GROUP BY categoria
ORDER BY meses_lider DESC;


-- 3. Qual categoria possui maior tempo médio de entrega?

WITH cte_category_delivery_time AS (
    SELECT
        p.product_category_name AS categoria,
        julianday(o.order_delivered_customer_date) -
        julianday(o.order_purchase_timestamp) AS dias_entrega
    FROM orders AS o
    LEFT JOIN order_items AS i
        ON o.order_id = i.order_id
    LEFT JOIN products AS p
        ON i.product_id = p.product_id
    WHERE o.order_status = 'delivered'
        AND p.product_category_name IS NOT NULL
)

SELECT
    categoria,
    ROUND(
        AVG(dias_entrega),
        2
    ) AS prazo_medio_entrega
FROM cte_category_delivery_time
GROUP BY categoria
ORDER BY prazo_medio_entrega DESC
LIMIT 10;