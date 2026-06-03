--Quais categorias mais faturaram?

SELECT
    p.product_category_name AS categoria_do_produto,
    COUNT(i.product_id) AS quantidade_vendida,
    ROUND(SUM(i.price + i.freight_value), 2) AS faturamento
FROM products p
LEFT JOIN order_items i
    ON p.product_id = i.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY p.product_category_name
ORDER BY faturamento DESC
LIMIT 10;

--Quais produtos mais venderam por mês?
WITH tb_produto_vendido AS(
SELECT 
    i.product_id, 
    strftime('%Y-%m', o.order_purchase_timestamp) AS mes,
    COUNT(i.product_id) AS quantidade_vendida

FROM orders o 
LEFT JOIN order_items i 
ON o.order_id = i.order_id
WHERE order_status = 'delivered'
GROUP BY i.product_id, mes 
), tb_vendas_por_mes AS(
SELECT *,
       RANK() OVER (PARTITION BY mes ORDER BY quantidade_vendida DESC) AS rn
FROM tb_produto_vendido v
LEFT JOIN products p 
ON v.product_id = p.product_id
) 
SELECT product_id,
       mes,
       quantidade_vendida,
       product_category_name  
FROM tb_vendas_por_mes
WHERE rn = 1;
--Quais categorias possuem pior avaliação média?
WITH tb_reviews AS(
    SELECT i.order_id,
           r.review_score AS avaliacao,
           i.product_id  
    FROM order_reviews r
    LEFT JOIN order_items i 
    ON r.order_id = i.order_id
)
    SELECT 
    ROUND(AVG(avaliacao),2) AS avaliacao_media,
    p.product_category_name  AS categoria
    FROM tb_reviews r 
    LEFT JOIN products p 
    ON r.product_id = p.product_id
    WHERE p.product_category_name IS NOT NULL
    GROUP BY categoria
    ORDER BY avaliacao_media ASC
   
    LIMIT 10
   



