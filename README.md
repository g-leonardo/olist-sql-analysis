# 📊 Olist Sales Dashboard | SQL + Power BI

![SQL](https://img.shields.io/badge/SQL-SQLite-003B57?style=for-the-badge&logo=sqlite&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Status](https://img.shields.io/badge/Status-Concluído-success?style=for-the-badge)

Projeto de análise de dados utilizando o dataset público da **Olist**, desenvolvido com **SQL (SQLite)** para exploração e transformação dos dados e **Power BI** para construção de dashboards interativos.

O objetivo do projeto é transformar dados brutos em informações estratégicas para apoiar decisões de negócio relacionadas a vendas, clientes, produtos e logística.

---

# 📊 Dashboard

O dashboard é composto por **quatro páginas analíticas**:

- 📈 Dashboard Executivo
- 👥 Análise de Clientes
- 🛍️ Produtos & Vendas
- 🚚 Análise de Entregas

Além do arquivo **.pbix**, o projeto também contém um relatório em **PDF** com todas as páginas do dashboard.

---

# 🎯 Objetivos

Responder perguntas de negócio como:

### 📈 Vendas

- Qual o faturamento total?
- Qual o ticket médio?
- Como as vendas evoluíram ao longo do tempo?
- Quais categorias geram mais receita?

### 👥 Clientes

- Quantos clientes realizaram compras?
- Qual a taxa de recorrência?
- Quais estados possuem mais clientes?
- Como o frete impacta a satisfação?

### 🛍️ Produtos

- Quais categorias vendem mais?
- Quais categorias possuem maior ticket médio?
- Existe relação entre preço e volume de vendas?

### 🚚 Entregas

- Quantas entregas foram realizadas?
- Quantas ocorreram no prazo?
- Quantas atrasaram?
- Qual região possui o maior prazo médio?
- Como o atraso impacta a avaliação do cliente?

---

# 📌 KPIs Desenvolvidos

- 💰 Receita Total
- 🛒 Ticket Médio
- 📦 Total de Pedidos
- 👥 Total de Clientes
- 🆕 Clientes Novos
- 🔄 Clientes Recorrentes
- 📈 Taxa de Recorrência
- 🛍️ Total de Produtos
- 🏷️ Total de Categorias
- 🚚 Total de Entregas
- ✅ Entregas no Prazo
- ⏰ Entregas Atrasadas
- 📅 Prazo Médio de Entrega
- ⭐ Avaliação Média

---

# 💡 Principais Insights

| Insight | Resultado |
|----------|-----------|
| 🏙️ São Paulo concentra o maior número de clientes | ~42 mil clientes |
| 🔄 Apenas 3% dos clientes realizaram mais de uma compra | Baixa recorrência |
| 📈 Novembro/2017 apresentou o maior pico de pedidos | Black Friday |
| 🛏️ Cama, Mesa e Banho lidera em volume de vendas | Categoria mais vendida |
| 💄 Beleza e Saúde lidera em faturamento | Maior receita |
| 🚚 Prazo médio de entrega | 12,56 dias |
| ⚠️ Cerca de 8% das entregas atrasaram | Impacto na satisfação |
| ⭐ Pedidos entregues no prazo receberam avaliações superiores | Melhor experiência do cliente |

---

# 🛠️ Tecnologias

| Ferramenta | Finalidade |
|------------|------------|
| SQL (SQLite) | Consultas e análise dos dados |
| Power BI | Construção dos dashboards |
| Python | Criação do banco SQLite |
| Git | Versionamento |
| GitHub | Portfólio do projeto |

---

# 📁 Estrutura do Projeto

```
olist-sales-dashboard/
│
├── dashboard/
│   ├── olist_dashboard.pbix
│   └── dashboard_preview.png
│
├── pdf/
│   └── Olist Dashboard.pdf
│
├── sql/
│   ├── 01_dashboard_executivo.sql
│   ├── 02_clientes.sql
│   ├── 03_produtos_vendas.sql
│   └── 04_entregas.sql
│
├── setup_banco.py
│
└── README.md
```

---

# ▶️ Como Executar

### 1. Clone o repositório

```bash
git clone https://github.com/g-leonardo/olist-sales-dashboard.git
```

### 2. Baixe o dataset

Dataset oficial da Olist:

https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

### 3. Instale as dependências

```bash
pip install kagglehub pandas
```

### 4. Crie o banco SQLite

```bash
python setup_banco.py
```

### 5. Execute as consultas SQL

Abra os arquivos da pasta **sql/** no VS Code ou em qualquer cliente SQLite.

### 6. Abra o Dashboard

Abra o arquivo:

```
dashboard/olist_dashboard.pbix
```

utilizando o **Power BI Desktop**.

---

# 📄 Relatório

O repositório também contém um relatório em PDF com todas as páginas do dashboard e os principais indicadores analisados.

---

# 👨‍💻 Autor

**Gabriel Leonardo**

Projeto desenvolvido para compor meu portfólio de **Análise de Dados**, aplicando SQL e Power BI na resolução de problemas de negócio utilizando dados reais do e-commerce brasileiro.

[![GitHub](https://img.shields.io/badge/GitHub-g--leonardo-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/g-leonardo)

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Conectar-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/gabriel-leonardo-9524933b1/)