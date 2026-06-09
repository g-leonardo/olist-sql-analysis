--Quais clientes geraram maior receita para a empresa?

WITH tb_gasto AS (
    SELECT 
        c.customer_unique_id AS id_cliente,
        COUNT(DISTINCT o.order_id) AS total_pedidos,
        ROUND(SUM(i.price + i.freight_value),2) AS gasto_total
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items i
        ON o.order_id = i.order_id
    GROUP BY id_cliente
)

SELECT *,
       ROUND(gasto_total / total_pedidos, 2) AS ticket_medio
FROM tb_gasto
ORDER BY gasto_total DESC
LIMIT 10;

--Existe sazonalidade diferente entre categorias?

WITH tb_categoria AS(
    SELECT  
            substr(o.order_purchase_timestamp,1,7) AS data,
            p.product_category_name AS categoria, 
            ROUND(SUM(i.price + i.freight_value),2) AS gasto   
    FROM orders o 
    LEFT JOIN order_items i
    ON o.order_id = i.order_id
    LEFT JOIN products p 
    ON i.product_id = p.product_id
    WHERE order_status = 'delivered'
    AND p.product_category_name IS NOT NULL
    GROUP BY data, categoria 
), tb_gasto_por_categoria AS( 
SELECT *,
       ROW_NUMBER() OVER (PARTITION BY data ORDER BY gasto DESC) AS rn 
FROM tb_categoria 
), resultado_final AS(
SELECT *
FROM tb_gasto_por_categoria
WHERE rn = 1  
) 
SELECT
    categoria,
    COUNT(*) AS meses_lider
FROM resultado_final
GROUP BY categoria
ORDER BY meses_lider DESC;

--Qual categoria possui maior tempo médio de entrega?

WITH tb_prazo AS(
    SELECT
        p.product_category_name AS categoria,
        julianday(o.order_delivered_customer_date) -
        julianday(o.order_purchase_timestamp) AS prazo_entrega
    FROM orders o
    LEFT JOIN order_items i
        ON o.order_id = i.order_id
    LEFT JOIN products p
        ON i.product_id = p.product_id
    WHERE o.order_status = 'delivered'
    AND p.product_category_name IS NOT NULL
)

SELECT
    categoria,
    ROUND(AVG(prazo_entrega),2) AS prazo_medio_entrega
FROM tb_prazo
GROUP BY categoria
ORDER BY prazo_medio_entrega DESC
LIMIT 10;    
