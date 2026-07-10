-- ============================================================
-- OLIST SALES DASHBOARD — Página 4: Entregas
-- Autor: Gabriel Leonardo
-- Descrição: Indicadores de desempenho logístico e entregas
-- ============================================================


-- ============================================================
-- [1] KPI — TOTAL DE ENTREGAS
-- ============================================================

SELECT
    COUNT(*) AS total_entregas
FROM orders
WHERE order_status = 'delivered';


-- ============================================================
-- [2] KPI — ENTREGAS NO PRAZO x ATRASADAS
-- ============================================================

SELECT
    CASE
        WHEN order_delivered_customer_date <= order_estimated_delivery_date
            THEN 'No Prazo'
        ELSE 'Atrasado'
    END AS status_entrega,

    COUNT(*) AS total_entregas

FROM orders

WHERE order_status = 'delivered'

GROUP BY status_entrega

ORDER BY total_entregas DESC;


-- ============================================================
-- [3] KPI — PRAZO MÉDIO DE ENTREGA
-- ============================================================

SELECT

ROUND(
    AVG(
        julianday(order_delivered_customer_date) -
        julianday(order_purchase_timestamp)
    ),2
) AS prazo_medio_dias

FROM orders

WHERE order_status='delivered';


-- ============================================================
-- [4] EVOLUÇÃO DAS ENTREGAS MENSAIS
-- ============================================================

SELECT
    strftime('%Y-%m', order_delivered_customer_date) AS mes,
    COUNT(order_id) AS total_entregas
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
GROUP BY mes
ORDER BY mes;


-- ============================================================
-- [5] PRAZO MÉDIO DE ENTREGA POR REGIÃO
-- ============================================================

SELECT

CASE
    WHEN c.customer_state IN ('SP','RJ','MG','ES')
        THEN 'Sudeste'

    WHEN c.customer_state IN ('PR','SC','RS')
        THEN 'Sul'

    WHEN c.customer_state IN ('GO','MT','MS','DF')
        THEN 'Centro-Oeste'

    WHEN c.customer_state IN ('BA','PE','CE','PB','RN','AL','SE','PI','MA')
        THEN 'Nordeste'

    ELSE 'Norte'
END AS regiao,

ROUND(

AVG(
julianday(o.order_delivered_customer_date)-
julianday(o.order_purchase_timestamp)
)

,2) AS prazo_medio_dias

FROM orders o

JOIN customers c
ON o.customer_id=c.customer_id

WHERE o.order_status='delivered'

GROUP BY regiao

ORDER BY prazo_medio_dias DESC;


-- ============================================================
-- [6] IMPACTO DO ATRASO NA SATISFAÇÃO DO CLIENTE
-- ============================================================

SELECT

CASE
    WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date
        THEN 'No Prazo'
    ELSE 'Atrasado'
END AS status_entrega,

ROUND(AVG(r.review_score),2) AS review_medio,

COUNT(*) AS total_pedidos

FROM orders o

JOIN order_reviews r
ON o.order_id=r.order_id

WHERE o.order_status='delivered'

GROUP BY status_entrega

ORDER BY review_medio DESC;