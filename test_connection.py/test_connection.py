from sqlalchemy import create_engine
from urllib.parse import quote_plus

password = quote_plus("S@nika105")  # Replace with your actual password

engine = create_engine(
    f"mysql+pymysql://root:{password}@localhost:3306"
)

try:
    with engine.connect() as conn:
        print("✅ Connected to MySQL successfully!")
except Exception as e:
    print("❌ Connection failed")
    print(e)