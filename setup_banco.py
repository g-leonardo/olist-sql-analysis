import kagglehub
import pandas as pd
import sqlite3
import os

# 1. Baixa os CSVs
try:
    path = kagglehub.dataset_download("olistbr/brazilian-ecommerce")
    print("CSVs baixados em:", path)
except Exception as e:
    print("Erro ao baixar:", e)
    exit()

# 2. Cria o banco SQLite
conn = sqlite3.connect("olist.db")

arquivos = {
    "olist_orders_dataset.csv":              "orders",
    "olist_order_items_dataset.csv":         "order_items",
    "olist_order_payments_dataset.csv":      "order_payments",
    "olist_order_reviews_dataset.csv":       "order_reviews",
    "olist_customers_dataset.csv":           "customers",
    "olist_products_dataset.csv":            "products",
    "olist_sellers_dataset.csv":             "sellers",
    "olist_geolocation_dataset.csv":         "geolocation",
    "product_category_name_translation.csv": "category_translation",
}

for arquivo, tabela in arquivos.items():
    caminho = os.path.join(path, arquivo)
    df = pd.read_csv(caminho)
    df.to_sql(tabela, conn, if_exists="replace", index=False)
    print(f"[OK] {tabela}")

conn.close()
print("\nPronto! Banco salvo em olist.db")