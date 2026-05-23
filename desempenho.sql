--Qual o prazo médio de entrega?
WITH tb_dias_entrega AS(
SELECT order_id,
julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp)  AS tempo_entrega

FROM orders
WHERE order_status = 'delivered'
GROUP BY order_id
 
)
SELECT sum(tempo_entrega) / count(order_id) AS prazo_médio
FROM tb_dias_entrega
--Quais pedidos chegaram atrasados?
--Quais pedidos chegaram atrasados?
SELECT order_id,
       order_estimated_delivery_date, 
       order_delivered_customer_date 

FROM orders
WHERE order_estimated_delivery_date <  order_delivered_customer_date 

--7.827 / 96.478 entregues = ~8% de atraso