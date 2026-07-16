import pandas as pd
import mysql.connector

print("1. Loading CSV dataset...")
try:
    df = pd.read_csv("dataset/zomato.csv")
except FileNotFoundError:
    df = pd.read_csv("../dataset/zomato.csv")
df.columns = df.columns.str.replace(r'[\(\)]', '', regex=True).str.strip('')

print("2. Connecting to local MySQL Instance...")
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="S@nika105",  
    database="zomato_db"
)
cursor = conn.cursor()
print(f"3. Uploading {len(df)} records into 'zomato' table...")


sql = """INSERT INTO zomato (url, address, name, online_order, book_table, rate, votes, 
        phone, location, rest_type, dish_liked, cuisines, approx_cost, reviews_list, 
        menu_item, listed_in_type, listed_in_city) 
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"""
records = [[None if pd.isna(val) else str(val) for val in row] for row in df.values]
batch_size = 2000
total_records = len(records)

for i in range(0, total_records, batch_size):
    batch = records[i:i + batch_size]
    cursor.executemany(sql, batch)
    conn.commit() 
    print(f"   -> Progress: Imported rows {i} to {min(i + batch_size, total_records)}...")

print(f"✅ Success! Successfully imported {total_records} rows into zomato_db.zomato.")
cursor.close()
conn.close()