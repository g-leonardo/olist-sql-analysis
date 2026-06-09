--Qual o prazo médio de entrega?

WITH tb_dias_entrega AS(
    SELECT order_id,
    julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp)  AS tempo_entrega

    FROM orders
    WHERE order_status = 'delivered'
    GROUP BY order_id
 
)
SELECT ROUND(AVG(tempo_entrega),2) AS prazo_médio
FROM tb_dias_entrega;

--Quais estados possuem maior atraso?

WITH tb_atrasos AS(
    SELECT c.customer_state AS estados,
           julianday(order_delivered_customer_date) - julianday(order_estimated_delivery_date)  AS tempo_atraso

    FROM orders o 
    LEFT JOIN customers c
    ON o.customer_id = c.customer_id
    WHERE order_status = 'delivered'
)
SELECT ROUND(AVG(tempo_atraso),2) AS atraso_medio,
       estados 

FROM tb_atrasos 
WHERE tempo_atraso > 0
GROUP BY estados
ORDER BY atraso_medio DESC
LIMIT 10

--Existe relação entre atraso e review?

WITH tb_atraso AS (
    SELECT 
        o.order_id,
        r.review_score AS nota,
        julianday(o.order_delivered_customer_date) - julianday(o.order_estimated_delivery_date) AS atraso
    FROM orders o
    LEFT JOIN order_reviews r
        ON o.order_id = r.order_id
    WHERE o.order_status = 'delivered'
      AND r.review_score IS NOT NULL
),

tb_review AS (
    SELECT *,
        CASE
            WHEN atraso > 0 THEN 'Atrasado'
            ELSE 'No Prazo'
        END AS status
    FROM tb_atraso
)

SELECT
    status,
    ROUND(AVG(nota), 2) AS nota_media,
    COUNT(*) AS total_pedidos
FROM tb_review
GROUP BY status
ORDER BY nota_media;



 