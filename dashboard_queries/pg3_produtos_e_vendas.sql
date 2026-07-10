-- ============================================================
-- OLIST SALES DASHBOARD — Página 3: Produtos & Vendas
-- Autor: Gabriel Leonardo
-- Descrição: Volume de vendas, ticket por categoria e dispersão
-- ============================================================


-- ============================================================
-- [1] TOP 10 CATEGORIAS POR VOLUME DE VENDAS
-- ============================================================

SELECT
    CASE
        WHEN p.product_category_name = 'cama_mesa_banho' THEN 'Cama, Mesa e Banho'
        WHEN p.product_category_name = 'beleza_saude' THEN 'Beleza'
        WHEN p.product_category_name = 'esporte_lazer' THEN 'Esporte'
        WHEN p.product_category_name = 'moveis_decoracao' THEN 'Móveis'
        WHEN p.product_category_name = 'informatica_acessorios' THEN 'Informática'
        WHEN p.product_category_name = 'utilidades_domesticas' THEN 'Utilidades'
        WHEN p.product_category_name = 'relogios_presentes' THEN 'Relógios'
        WHEN p.product_category_name = 'telefonia' THEN 'Telefonia'
        WHEN p.product_category_name = 'ferramentas_jardim' THEN 'Ferramentas'
        WHEN p.product_category_name = 'automotivo' THEN 'Automotivo'
        WHEN p.product_category_name = 'cool_stuff' THEN 'Cool Stuff'
        WHEN p.product_category_name = 'brinquedos' THEN 'Brinquedos'
        WHEN p.product_category_name = 'bebes' THEN 'Bebês'
        WHEN p.product_category_name = 'perfumaria' THEN 'Perfumaria'
        WHEN p.product_category_name = 'eletronicos' THEN 'Eletrônicos'
        WHEN p.product_category_name = 'pcs' THEN 'Computadores'
        WHEN p.product_category_name = 'portateis_casa_forno_e_cafe' THEN 'Portáteis'
        WHEN p.product_category_name = 'eletrodomesticos_2' THEN 'Eletrodomésticos'
        WHEN p.product_category_name = 'agro_industria_e_comercio' THEN 'Agro'
        WHEN p.product_category_name = 'instrumentos_musicais' THEN 'Instrumentos'
        WHEN p.product_category_name = 'portateis_cozinha_e_preparadores_de_alimentos' THEN 'Portáteis'
        WHEN p.product_category_name = 'eletroportateis' THEN 'Eletroportáteis'
        WHEN p.product_category_name = 'telefonia_fixa' THEN 'Tel. Fixa'
        WHEN p.product_category_name = 'construcao_ferramentas_ferramentas' THEN 'Construção'
        ELSE p.product_category_name
    END AS categoria,
    COUNT(i.order_item_id) AS total_vendas
FROM orders AS o
LEFT JOIN order_items AS i ON o.order_id = i.order_id
LEFT JOIN products AS p ON i.product_id = p.product_id
WHERE o.order_status = 'delivered'
  AND p.product_category_name IS NOT NULL
GROUP BY categoria
ORDER BY total_vendas DESC
LIMIT 10;


-- ============================================================
-- [2] PREÇO MÉDIO VS VOLUME DE VENDAS POR CATEGORIA
-- ============================================================

SELECT
    CASE
        WHEN p.product_category_name = 'cama_mesa_banho' THEN 'Cama, Mesa e Banho'
        WHEN p.product_category_name = 'beleza_saude' THEN 'Beleza'
        WHEN p.product_category_name = 'esporte_lazer' THEN 'Esporte'
        WHEN p.product_category_name = 'moveis_decoracao' THEN 'Móveis'
        WHEN p.product_category_name = 'informatica_acessorios' THEN 'Informática'
        WHEN p.product_category_name = 'utilidades_domesticas' THEN 'Utilidades'
        WHEN p.product_category_name = 'relogios_presentes' THEN 'Relógios'
        WHEN p.product_category_name = 'telefonia' THEN 'Telefonia'
        WHEN p.product_category_name = 'ferramentas_jardim' THEN 'Ferramentas'
        WHEN p.product_category_name = 'automotivo' THEN 'Automotivo'
        WHEN p.product_category_name = 'cool_stuff' THEN 'Cool Stuff'
        WHEN p.product_category_name = 'brinquedos' THEN 'Brinquedos'
        WHEN p.product_category_name = 'bebes' THEN 'Bebês'
        WHEN p.product_category_name = 'perfumaria' THEN 'Perfumaria'
        WHEN p.product_category_name = 'eletronicos' THEN 'Eletrônicos'
        WHEN p.product_category_name = 'pcs' THEN 'Computadores'
        WHEN p.product_category_name = 'portateis_casa_forno_e_cafe' THEN 'Portáteis'
        WHEN p.product_category_name = 'eletrodomesticos_2' THEN 'Eletrodomésticos'
        WHEN p.product_category_name = 'agro_industria_e_comercio' THEN 'Agro'
        WHEN p.product_category_name = 'instrumentos_musicais' THEN 'Instrumentos'
        WHEN p.product_category_name = 'portateis_cozinha_e_preparadores_de_alimentos' THEN 'Portáteis'
        WHEN p.product_category_name = 'eletroportateis' THEN 'Eletroportáteis'
        WHEN p.product_category_name = 'telefonia_fixa' THEN 'Tel. Fixa'
        WHEN p.product_category_name = 'construcao_ferramentas_ferramentas' THEN 'Construção'
        ELSE p.product_category_name
    END AS categoria,
    ROUND(AVG(i.price),2) AS preco_medio,
    COUNT(i.order_item_id) AS total_vendas
FROM orders AS o
LEFT JOIN order_items AS i ON o.order_id = i.order_id
LEFT JOIN products AS p ON i.product_id = p.product_id
WHERE o.order_status = 'delivered'
  AND p.product_category_name IS NOT NULL
GROUP BY categoria
ORDER BY total_vendas DESC
LIMIT 15;


-- ============================================================
-- [3] TICKET MÉDIO POR CATEGORIA
-- ============================================================

SELECT
    CASE
        WHEN p.product_category_name = 'cama_mesa_banho' THEN 'Cama, Mesa e Banho'
        WHEN p.product_category_name = 'beleza_saude' THEN 'Beleza'
        WHEN p.product_category_name = 'esporte_lazer' THEN 'Esporte'
        WHEN p.product_category_name = 'moveis_decoracao' THEN 'Móveis'
        WHEN p.product_category_name = 'informatica_acessorios' THEN 'Informática'
        WHEN p.product_category_name = 'utilidades_domesticas' THEN 'Utilidades'
        WHEN p.product_category_name = 'relogios_presentes' THEN 'Relógios'
        WHEN p.product_category_name = 'telefonia' THEN 'Telefonia'
        WHEN p.product_category_name = 'ferramentas_jardim' THEN 'Ferramentas'
        WHEN p.product_category_name = 'automotivo' THEN 'Automotivo'
        WHEN p.product_category_name = 'cool_stuff' THEN 'Cool Stuff'
        WHEN p.product_category_name = 'brinquedos' THEN 'Brinquedos'
        WHEN p.product_category_name = 'bebes' THEN 'Bebês'
        WHEN p.product_category_name = 'perfumaria' THEN 'Perfumaria'
        WHEN p.product_category_name = 'eletronicos' THEN 'Eletrônicos'
        WHEN p.product_category_name = 'pcs' THEN 'Computadores'
        WHEN p.product_category_name = 'portateis_casa_forno_e_cafe' THEN 'Portáteis'
        WHEN p.product_category_name = 'eletrodomesticos_2' THEN 'Eletrodomésticos'
        WHEN p.product_category_name = 'agro_industria_e_comercio' THEN 'Agro'
        WHEN p.product_category_name = 'instrumentos_musicais' THEN 'Instrumentos'
        WHEN p.product_category_name = 'portateis_cozinha_e_preparadores_de_alimentos' THEN 'Portáteis'
        WHEN p.product_category_name = 'eletroportateis' THEN 'Eletroportáteis'
        WHEN p.product_category_name = 'telefonia_fixa' THEN 'Tel. Fixa'
        WHEN p.product_category_name = 'construcao_ferramentas_ferramentas' THEN 'Construção'
        ELSE p.product_category_name
    END AS categoria,
    ROUND(AVG(i.price),2) AS ticket_medio,
    COUNT(i.order_item_id) AS total_vendas
FROM orders AS o
LEFT JOIN order_items AS i ON o.order_id = i.order_id
LEFT JOIN products AS p ON i.product_id = p.product_id
WHERE o.order_status = 'delivered'
  AND p.product_category_name IS NOT NULL
GROUP BY categoria
ORDER BY ticket_medio DESC
LIMIT 10;


-- ============================================================
-- [4] KPIs
-- ============================================================

SELECT
    COUNT(DISTINCT p.product_id) AS total_produtos,
    COUNT(DISTINCT p.product_category_name) AS total_categorias,
    COUNT(DISTINCT i.seller_id) AS total_vendedores
FROM order_items AS i
LEFT JOIN products AS p
    ON i.product_id = p.product_id;