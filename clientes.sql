--Quais os 5 estados com mais clientes?
SELECT count(*) AS clientes_por_estado,
      customer_state AS estado 
FROM customers
GROUP BY estado 
ORDER BY clientes_por_estado DESC
LIMIT 5
--Quais clientes fizeram mais de 1 pedido?

SELECT c.customer_unique_id,               -- 
       COUNT(c.customer_id) AS pedidos     
FROM orders AS o
LEFT JOIN customers AS c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id              -- 
HAVING COUNT(c.customer_id) > 1            
ORDER BY pedidos DESC;  

--Quais as 10 categorias mais vendidas?
SELECT p.product_category_name AS categoria_do_produto,
       count(i.product_id) AS qtdecategoriavendida 
FROM products AS p
LEFT JOIN order_items AS i
ON p.product_id = i.product_id
WHERE categoria_do_produto IS NOT NULL 
GROUP BY categoria_do_produto
ORDER BY qtdecategoriavendida DESC
LIMIT 10 

--Qual a categoria com maior faturamento?
SELECT p.product_category_name AS categoria_do_produto,
       count(i.product_id) AS qtdecategoriavendida,
       sum(i.price) AS faturamento
FROM products AS p
LEFT JOIN order_items AS i
ON p.product_id = i.product_id
WHERE categoria_do_produto IS NOT NULL 
GROUP BY categoria_do_produto
ORDER BY faturamento DESC
LIMIT 10 

SELECT *
FROM order_items
limit 1