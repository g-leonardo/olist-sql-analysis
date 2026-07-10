-- ==========================================
-- PRODUCT ANALYSIS
-- ==========================================

-- 1. Quais categorias geraram maior faturamento?

SELECT
    p.product_category_name AS categoria,
    COUNT(i.product_id) AS quantidade_vendida,
    ROUND(
        SUM(i.price + i.freight_value),
        2
    ) AS faturamento_total
FROM products AS p
LEFT JOIN order_items AS i
    ON p.product_id = i.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY p.product_category_name
ORDER BY faturamento_total DESC
LIMIT 10;


-- 2. Quais produtos mais venderam em cada mês?

WITH cte_monthly_products AS (
    SELECT
        i.product_id,
        strftime('%Y-%m', o.order_purchase_timestamp) AS mes,
        COUNT(i.product_id) AS quantidade_vendida
    FROM orders AS o
    LEFT JOIN order_items AS i
        ON o.order_id = i.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY
        i.product_id,
        mes
),

cte_product_ranking AS (
    SELECT
        mp.product_id,
        mp.mes,
        mp.quantidade_vendida,
        p.product_category_name AS categoria,
        RANK() OVER (
            PARTITION BY mp.mes
            ORDER BY mp.quantidade_vendida DESC
        ) AS ranking
    FROM cte_monthly_products AS mp
    LEFT JOIN products AS p
        ON mp.product_id = p.product_id
)

SELECT
    product_id,
    mes,
    quantidade_vendida,
    categoria
FROM cte_product_ranking
WHERE ranking = 1
ORDER BY mes;


-- 3. Quais categorias possuem as piores avaliações médias?

WITH cte_reviews AS (
    SELECT
        i.product_id,
        r.review_score AS nota_avaliacao
    FROM order_reviews AS r
    LEFT JOIN order_items AS i
        ON r.order_id = i.order_id
)

SELECT
    p.product_category_name AS categoria,
    ROUND(
        AVG(cr.nota_avaliacao),
        2
    ) AS avaliacao_media
FROM cte_reviews AS cr
LEFT JOIN products AS p
    ON cr.product_id = p.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY p.product_category_name
ORDER BY avaliacao_media ASC
LIMIT 10;