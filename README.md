# 📦 Análise de Vendas — Dataset Olist

Análise exploratória de dados de e-commerce brasileiro utilizando **SQL (SQLite)**.  
Os dados são do dataset público da [Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) disponível no Kaggle.

---

## 🎯 Objetivo

Responder perguntas de negócio sobre vendas, clientes, produtos e desempenho de entrega, utilizando SQL puro como ferramenta principal de análise.

---

## 🗂️ Estrutura do Projeto

```
olist-sql-analysis/
├── queries/
│   ├── 01_visao_geral.sql      # Faturamento, ticket médio e pedidos por mês
│   ├── 02_clientes.sql         # Distribuição geográfica e recorrência
│   ├── 03_produtos.sql         # Categorias mais vendidas e maior faturamento
│   └── 04_desempenho.sql       # Prazo médio e pedidos atrasados
├── setup_banco.py              # Script para criar o banco SQLite a partir dos CSVs
└── README.md
```

---

## ❓ Perguntas Respondidas

### 📊 Visão Geral
- Qual o faturamento total da Olist? (apenas pedidos entregues)
- Qual o ticket médio por pedido?
- Qual a evolução de pedidos ao longo dos meses?

### 👥 Clientes
- Quais os 5 estados com mais clientes?
- Quantos clientes fizeram mais de 1 pedido?

### 🛍️ Produtos
- Quais as 10 categorias mais vendidas?
- Qual a categoria com maior faturamento?

### 🚚 Desempenho
- Qual o prazo médio de entrega?
- Quantos pedidos chegaram atrasados?

---

## 💡 Principais Insights

- **São Paulo domina** a base de clientes com ~41.700 clientes, cerca de 30.000 a mais que o segundo colocado, Rio de Janeiro (12.800)
- **Baixa retenção:** de 99.441 clientes, apenas 2.997 fizeram mais de 1 pedido — indicando que a base é majoritariamente de novos clientes
- **Black Friday:** novembro de 2017 registrou o maior pico de pedidos (7.289), bem acima da média dos meses anteriores
- **cama_mesa_banho** é a categoria mais vendida em volume E está no top 3 de faturamento — mostrando consistência em vendas e receita
- **beleza_saude** lidera em faturamento mesmo com menos vendas que cama_mesa_banho, indicando produtos com ticket mais alto
- **Prazo médio de entrega:** 12,5 dias
- **8% dos pedidos** chegaram atrasados (7.827 de 96.478 entregues)

---

## 🛠️ Tecnologias

- SQL (SQLite)
- Python (apenas para setup do banco)
- VS Code + SQLite Viewer

---

## ▶️ Como Reproduzir

1. Baixe o dataset no [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
2. Instale as dependências:
```bash
pip install kagglehub pandas
```
3. Rode o script de setup:
```bash
python setup_banco.py
```
4. Abra os arquivos `.sql` na pasta `queries/` e execute no VS Code

---

## 👤 Autor

Feito por **Gabriel Leonardo** — projeto de portfólio para a área de dados.
