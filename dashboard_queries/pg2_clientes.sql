-- ============================================================
-- OLIST SALES DASHBOARD — Página 2: Clientes
-- Autor: Gabriel Leonardo
-- Descrição: Distribuição geográfica, retenção e satisfação
-- ============================================================


-- ============================================================
-- [1] CLIENTES POR ESTADO (para o mapa)
--     Nome completo dos estados para geocodificação no Power BI
-- ============================================================

SELECT
    CASE c.customer_state
        WHEN 'AC' THEN 'Acre'
        WHEN 'AL' THEN 'Alagoas'
        WHEN 'AM' THEN 'Amazonas'
        WHEN 'AP' THEN 'Amapá'
        WHEN 'BA' THEN 'Bahia'
        WHEN 'CE' THEN 'Ceará'
        WHEN 'DF' THEN 'Distrito Federal'
        WHEN 'ES' THEN 'Espírito Santo'
        WHEN 'GO' THEN 'Goiás'
        WHEN 'MA' THEN 'Maranhão'
        WHEN 'MG' THEN 'Minas Gerais'
        WHEN 'MS' THEN 'Mato Grosso do Sul'
        WHEN 'MT' THEN 'Mato Grosso'
        WHEN 'PA' THEN 'Pará'
        WHEN 'PB' THEN 'Paraíba'
        WHEN 'PE' THEN 'Pernambuco'
        WHEN 'PI' THEN 'Piauí'
        WHEN 'PR' THEN 'Paraná'
        WHEN 'RJ' THEN 'Rio de Janeiro'
        WHEN 'RN' THEN 'Rio Grande do Norte'
        WHEN 'RO' THEN 'Rondônia'
        WHEN 'RR' THEN 'Roraima'
        WHEN 'RS' THEN 'Rio Grande do Sul'
        WHEN 'SC' THEN 'Santa Catarina'
        WHEN 'SE' THEN 'Sergipe'
        WHEN 'SP' THEN 'São Paulo'
        WHEN 'TO' THEN 'Tocantins'
    END                              AS estado,
    'Brazil'                         AS pais,
    COUNT(DISTINCT c.customer_id)    AS total_clientes
FROM customers AS c
GROUP BY c.customer_state
ORDER BY total_clientes DESC;


-- ============================================================
-- [2] CLIENTES NOVOS VS RECORRENTES (para gráfico rosca 🍩)
--     Novo = 1 pedido | Recorrente = mais de 1 pedido
-- ============================================================

WITH cte_pedidos_por_cliente AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id)   AS total_pedidos
    FROM orders AS o
    INNER JOIN customers AS c ON o.customer_id = c.customer_id
    WHERE LOWER(o.order_status) = 'delivered'
    GROUP BY c.customer_unique_id
)

SELECT
    CASE
        WHEN total_pedidos = 1 THEN 'Novo'
        WHEN total_pedidos > 1 THEN 'Recorrente'
    END                              AS tipo_cliente,
    COUNT(*)                         AS total_clientes,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    )                                AS percentual
FROM cte_pedidos_por_cliente
GROUP BY tipo_cliente;


-- ============================================================
-- [3]  Gráfico de Dispersão (Scatter Plot) de Preço do Frete vs. Avaliação
--     Satisfação dos clientes por região 
-- ============================================================

SELECT
    CASE c.customer_state
        WHEN 'SP' THEN 'Sudeste' 
        WHEN 'RJ' THEN 'Sudeste' 
        WHEN 'MG' THEN 'Sudeste' 
        WHEN 'ES' THEN 'Sudeste'
        WHEN 'PR' THEN 'Sul'     
        WHEN 'RS' THEN 'Sul'     
        WHEN 'SC' THEN 'Sul'
        WHEN 'BA' THEN 'Nordeste' 
        WHEN 'PE' THEN 'Nordeste' 
        WHEN 'CE' THEN 'Nordeste' 
        WHEN 'RN' THEN 'Nordeste' 
        WHEN 'PB' THEN 'Nordeste' 
        WHEN 'AL' THEN 'Nordeste' 
        WHEN 'SE' THEN 'Nordeste' 
        WHEN 'PI' THEN 'Nordeste' 
        WHEN 'MA' THEN 'Nordeste'
        WHEN 'DF' THEN 'Centro-Oeste' 
        WHEN 'GO' THEN 'Centro-Oeste' 
        WHEN 'MT' THEN 'Centro-Oeste' 
        WHEN 'MS' THEN 'Centro-Oeste'
        ELSE 'Norte' -- AC, AM, AP, PA, RO, RR, TO
    END                              AS regiao,
    ROUND(AVG(r.review_score), 2)    AS review_medio,
    ROUND(AVG(i.freight_value), 2)   AS media_frete
FROM customers AS c
INNER JOIN orders AS o       ON c.customer_id = o.customer_id
INNER JOIN order_items AS i  ON o.order_id = i.order_id
INNER JOIN order_reviews AS r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND r.review_score IS NOT NULL
GROUP BY regiao
ORDER BY media_frete DESC;




-- ============================================================
-- [4] QUANTIDADE DE CLIENTES POR MÊS (para gráfico de linha 📈)
--     Evolução mensal da base de clientes
-- ============================================================
 
SELECT
    strftime('%Y-%m', o.order_purchase_timestamp) AS mes,
    COUNT(DISTINCT c.customer_unique_id)           AS total_clientes
FROM orders AS o
INNER JOIN customers AS c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY mes
ORDER BY mes;