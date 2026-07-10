-- ============================================================
-- OLIST SALES DASHBOARD — Página 1: Visão Geral
-- Autor: Gabriel Leonardo
-- Descrição: KPIs executivos, receita mensal e top categorias
-- ============================================================


-- ============================================================
-- [1] KPIs EXECUTIVOS
--     Faturamento Total | Ticket Médio | Total de Pedidos
--     Prazo Médio de Entrega | Review Médio
-- ============================================================

WITH cte_sales_metrics AS (
    SELECT
        ROUND(SUM(i.price + i.freight_value), 2)                    AS faturamento_total,
        COUNT(DISTINCT o.order_id)                                   AS total_pedidos,
        ROUND(SUM(i.price + i.freight_value) / 
              COUNT(DISTINCT o.order_id), 2)                         AS ticket_medio
    FROM orders AS o
    LEFT JOIN order_items AS i ON o.order_id = i.order_id
    WHERE o.order_status = 'delivered'
),

cte_delivery_metrics AS (
    SELECT
        ROUND(AVG(
            julianday(order_delivered_customer_date) -
            julianday(order_purchase_timestamp)
        ), 2)                                                        AS prazo_medio_entrega
    FROM orders
    WHERE order_status = 'delivered'
),

cte_review_metrics AS (
    SELECT
        ROUND(AVG(review_score), 2)                                  AS review_medio
    FROM order_reviews
)

SELECT *
FROM cte_sales_metrics
CROSS JOIN cte_delivery_metrics
CROSS JOIN cte_review_metrics;


-- ============================================================
-- [2] RECEITA MENSAL
--     Evolução do faturamento mês a mês
-- ============================================================

SELECT
    strftime('%Y-%m', o.order_purchase_timestamp)                    AS mes,
    ROUND(SUM(i.price + i.freight_value), 2)                        AS faturamento
FROM orders AS o
LEFT JOIN order_items AS i ON o.order_id = i.order_id
WHERE o.order_status = 'delivered'
GROUP BY mes
ORDER BY mes;


-- ============================================================
-- [3] TOP 10 CATEGORIAS POR FATURAMENTO
--     Ranking das categorias com maior receita
-- ============================================================

SELECT
    p.product_category_name                                          AS categoria,
    ROUND(SUM(i.price + i.freight_value), 2)                        AS faturamento
FROM orders AS o
LEFT JOIN order_items AS i  ON o.order_id = i.order_id
LEFT JOIN products    AS p  ON i.product_id = p.product_id
WHERE o.order_status = 'delivered'
  AND p.product_category_name IS NOT NULL
GROUP BY categoria
ORDER BY faturamento DESC
LIMIT 10;