"""
Database connection and operations module
"""

import os
import pandas as pd
from sqlalchemy import create_engine, text
from dotenv import load_dotenv

def get_api_key(service_name):
    """Get API key from environment variables"""
    load_dotenv()
    
    key_map = {
        'openai': 'OPENAI_API_KEY',
        'alpha_vantage': 'ALPHA_VANTAGE_API_KEY'
    }
    
    env_var = key_map.get(service_name.lower())
    if not env_var:
        raise ValueError(f"Unknown service: {service_name}")
    
    api_key = os.getenv(env_var)
    if not api_key or api_key == f"your_{service_name.lower()}_api_key_here":
        raise ValueError(f"{env_var} not set in .env file")
    
    return api_key

def get_database_connection():
    """Create and return database connection using environment variables"""
    # Load environment variables from .env file
    load_dotenv()
    
    # Get database URL from environment variable
    db_url = os.getenv('DATABASE_URL')
    
    if not db_url:
        # Fallback construction from individual environment variables
        password = os.getenv('POSTGRES_PASSWORD', 'changeme123')
        db_url = f'postgresql://trader:{password}@127.0.0.1:5432/sentiment_trends'
    
    # Create engine
    engine = create_engine(db_url)
    return engine

def test_database_connection():
    """Test database connectivity and show initial data"""
    try:
        engine = get_database_connection()
        
        print("🔍 Testing database connection...")
        
        # Test basic connectivity
        with engine.connect() as conn:
            result = conn.execute(text("SELECT version();"))
            version = result.fetchone()[0]
            print(f"✅ Connected to PostgreSQL: {version.split()[0]} {version.split()[1]}")
        
        # Check our symbols
        print("\n📊 Checking symbols table:")
        symbols_df = pd.read_sql_query(
            "SELECT symbol, company_name, is_primary, is_competitor FROM symbols ORDER BY symbol", 
            engine
        )
        print(symbols_df.to_string(index=False))
        
        # Check table counts
        print("\n📋 Table status:")
        tables = ['symbols', 'market_data', 'technical_indicators', 'news_sentiment']
        for table in tables:
            count_df = pd.read_sql_query(f"SELECT COUNT(*) as count FROM {table}", engine)
            count = count_df.iloc[0]['count']
            print(f"  {table}: {count} rows")
        
        print("\n🎉 Database setup complete and functional!")
        return True
        
    except Exception as e:
        print(f"❌ Database connection error: {e}")
        return False

if __name__ == "__main__":
    test_database_connection() 