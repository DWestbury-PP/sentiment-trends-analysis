# Database Schema Reference

A comprehensive reference for the sentiment trading analysis database schema, relationships, and usage patterns.

## 📋 **Document Overview**

**Database**: PostgreSQL 15  
**Schema**: `public`  
**Purpose**: Time-series financial data with sentiment analysis for trading strategies  
**Last Updated**: July 1, 2025  

---

## 🏗️ **Database Architecture**

### **Core Design Principles**
- **Normalized schema** with proper foreign key relationships
- **Time-series optimized** for financial data analysis
- **Scalable design** supporting multiple symbols and timeframes
- **Audit trail** with created_at/updated_at timestamps
- **Production-ready** with proper constraints and indexes

### **Entity Relationship Overview**
```
symbols (1) ──→ (many) market_data
symbols (1) ──→ (many) raw_news_articles
symbols (1) ──→ (many) processed_sentiment
symbols (1) ──→ (many) news_sentiment
symbols (1) ──→ (many) technical_indicators

daily_analysis (denormalized view for analysis)
```

---

## 📊 **Table Schemas**

### **1. SYMBOLS** (Master Reference Table)
**Purpose**: Central registry of stock symbols and company information

| Column | Type | Nullable | Default | Notes |
|--------|------|----------|---------|-------|
| `id` | integer | NO | AUTO | Primary key |
| `symbol` | varchar(10) | NO | - | Stock ticker (INTC, AMD, NVDA) |
| `company_name` | varchar(255) | NO | - | Full company name |
| `sector` | varchar(100) | YES | - | Industry sector |
| `is_primary` | boolean | YES | false | Primary analysis target |
| `is_competitor` | boolean | YES | false | Competitor symbol |
| `created_at` | timestamp | YES | CURRENT_TIMESTAMP | Record creation |
| `updated_at` | timestamp | YES | CURRENT_TIMESTAMP | Last update |

**Current Data**: 3 symbols (AMD, INTC, NVDA)

---

### **2. MARKET_DATA** (Core Financial Data)
**Purpose**: Historical OHLCV market data for all symbols

| Column | Type | Nullable | Default | Notes |
|--------|------|----------|---------|-------|
| `id` | integer | NO | AUTO | Primary key |
| `symbol_id` | integer | YES | - | FK to symbols.id |
| `trade_date` | date | NO | - | Trading date |
| `open_price` | numeric(10,4) | NO | - | Opening price |
| `high_price` | numeric(10,4) | NO | - | Daily high |
| `low_price` | numeric(10,4) | NO | - | Daily low |
| `close_price` | numeric(10,4) | NO | - | Closing price |
| `volume` | bigint | NO | - | Trading volume |
| `dividends` | numeric(10,4) | YES | 0 | Dividend payments |
| `stock_splits` | numeric(10,4) | YES | 0 | Stock split ratio |
| `created_at` | timestamp | YES | CURRENT_TIMESTAMP | Record creation |
| `updated_at` | timestamp | YES | CURRENT_TIMESTAMP | Last update |

**Current Data**: 819 records (May 24, 2024 to June 27, 2025)  
**Coverage**: 273 records per symbol (AMD, INTC, NVDA)

---

### **3. RAW_NEWS_ARTICLES** (News Collection)
**Purpose**: Raw news articles collected for sentiment analysis

| Column | Type | Nullable | Default | Notes |
|--------|------|----------|---------|-------|
| `id` | integer | NO | AUTO | Primary key |
| `symbol_id` | integer | YES | - | FK to symbols.id |
| `article_date` | date | NO | - | Article publication date |
| `title` | text | NO | - | Article headline |
| `content` | text | YES | - | Full article content |
| `summary` | text | YES | - | Article summary |
| `source` | varchar(100) | YES | - | News source |
| `url` | text | YES | - | Article URL |
| `published_at` | timestamp | YES | - | Publication timestamp |
| `relevance_score` | numeric(3,2) | YES | - | Relevance to symbol (0-1) |
| `created_at` | timestamp | YES | CURRENT_TIMESTAMP | Record creation |

**Current Data**: 606 articles (May 15 - June 28, 2025)  
**Distribution**: AMD (219), INTC (167), NVDA (220)

---

### **4. PROCESSED_SENTIMENT** (AI Sentiment Analysis)
**Purpose**: OpenAI GPT-processed sentiment scores from news articles

| Column | Type | Nullable | Default | Notes |
|--------|------|----------|---------|-------|
| `id` | integer | NO | AUTO | Primary key |
| `symbol_id` | integer | YES | - | FK to symbols.id |
| `analysis_date` | date | NO | - | Date of analysis |
| `smo_score` | numeric(3,2) | YES | - | Sentiment Market Open (-1 to +1) |
| `smd_score` | numeric(3,2) | YES | - | Sentiment Mid-Day (-1 to +1) |
| `smc_score` | numeric(3,2) | YES | - | Sentiment Market Close (-1 to +1) |
| `sms_score` | numeric(3,2) | YES | - | Sentiment Market Sector (-1 to +1) |
| `sdc_score` | numeric(3,2) | YES | - | Sentiment Direct Competitor (-1 to +1) |
| `articles_analyzed` | integer | YES | - | Number of articles processed |
| `confidence_score` | numeric(3,2) | YES | - | Analysis confidence (0-1) |
| `analysis_summary` | text | YES | - | Summary of sentiment analysis |
| `created_at` | timestamp | YES | CURRENT_TIMESTAMP | Record creation |

**Current Data**: 48 records (May 15 - June 28, 2025)  
**Distribution**: AMD (16), INTC (22), NVDA (10)

---

### **5. TECHNICAL_INDICATORS** (Technical Analysis)
**Purpose**: Calculated technical indicators for trading analysis

| Column | Type | Nullable | Default | Notes |
|--------|------|----------|---------|-------|
| `id` | integer | NO | AUTO | Primary key |
| `symbol_id` | integer | YES | - | FK to symbols.id |
| `trade_date` | date | NO | - | Trading date |
| `sma_1` to `sma_8` | numeric(10,4) | YES | - | Simple Moving Averages |
| `roc_1` to `roc_8` | numeric(10,4) | YES | - | Rate of Change indicators |
| `created_at` | timestamp | YES | CURRENT_TIMESTAMP | Record creation |
| `updated_at` | timestamp | YES | CURRENT_TIMESTAMP | Last update |

---

### **6. NEWS_SENTIMENT** (Legacy Sentiment Table)
**Purpose**: Earlier sentiment analysis format (legacy)

| Column | Type | Nullable | Default | Notes |
|--------|------|----------|---------|-------|
| `id` | integer | NO | AUTO | Primary key |
| `symbol_id` | integer | YES | - | FK to symbols.id |
| `trade_date` | date | NO | - | Trading date |
| `sentiment_market_open` | numeric(3,2) | YES | - | Market open sentiment |
| `sentiment_mid_day` | numeric(3,2) | YES | - | Mid-day sentiment |
| `sentiment_market_close` | numeric(3,2) | YES | - | Market close sentiment |
| `sentiment_market_sector` | numeric(3,2) | YES | - | Sector sentiment |
| `sentiment_direct_competitor` | numeric(3,2) | YES | - | Competitor sentiment |
| `news_count_*` | integer | YES | 0 | Article counts by category |
| `created_at` | timestamp | YES | CURRENT_TIMESTAMP | Record creation |
| `updated_at` | timestamp | YES | CURRENT_TIMESTAMP | Last update |

---

### **7. DAILY_ANALYSIS** (Denormalized Analysis View)
**Purpose**: Flattened view combining market data, technical indicators, and sentiment

| Column | Type | Notes |
|--------|------|-------|
| `symbol` | varchar(10) | Stock ticker |
| `company_name` | varchar(255) | Company name |
| `trade_date` | date | Trading date |
| `open_price` to `volume` | numeric/bigint | OHLCV market data |
| `sma_1` to `sma_8` | numeric | Moving averages |
| `roc_1` to `roc_8` | numeric | Rate of change |
| `sentiment_*` | numeric | Sentiment scores |

---

## 🔗 **Foreign Key Relationships**

```sql
-- All tables reference symbols as master
market_data.symbol_id         → symbols.id
raw_news_articles.symbol_id   → symbols.id  
processed_sentiment.symbol_id → symbols.id
news_sentiment.symbol_id      → symbols.id
technical_indicators.symbol_id → symbols.id
```

---

## 📈 **Common Query Patterns**

### **1. Market Data with Sentiment Analysis**
```sql
-- Load market data with sentiment scores (main analysis query)
SELECT 
    s.symbol,
    s.company_name,
    md.trade_date as date,
    md.open_price,
    md.high_price, 
    md.low_price,
    md.close_price,
    md.volume,
    ps.smo_score as sentiment,
    ps.confidence_score,
    ps.articles_analyzed
FROM market_data md
JOIN symbols s ON md.symbol_id = s.id  
LEFT JOIN processed_sentiment ps ON md.symbol_id = ps.symbol_id 
    AND md.trade_date = ps.analysis_date
WHERE s.symbol IN ('AMD', 'INTC', 'NVDA')
ORDER BY s.symbol, md.trade_date;
```

### **2. Symbol-Specific Analysis**
```sql
-- Get all data for a specific symbol
SELECT 
    md.trade_date,
    md.close_price,
    md.volume,
    ps.smo_score,
    ps.confidence_score,
    COUNT(rna.id) as news_articles
FROM market_data md
JOIN symbols s ON md.symbol_id = s.id
LEFT JOIN processed_sentiment ps ON md.symbol_id = ps.symbol_id 
    AND md.trade_date = ps.analysis_date  
LEFT JOIN raw_news_articles rna ON md.symbol_id = rna.symbol_id 
    AND md.trade_date = rna.article_date
WHERE s.symbol = 'NVDA'
GROUP BY md.trade_date, md.close_price, md.volume, ps.smo_score, ps.confidence_score
ORDER BY md.trade_date;
```

### **3. Sentiment Coverage Analysis**
```sql
-- Analyze sentiment data coverage
SELECT 
    s.symbol,
    COUNT(md.id) as total_market_days,
    COUNT(ps.id) as sentiment_days,
    ROUND(COUNT(ps.id)::numeric / COUNT(md.id) * 100, 1) as coverage_percent
FROM symbols s
JOIN market_data md ON s.id = md.symbol_id
LEFT JOIN processed_sentiment ps ON s.id = ps.symbol_id 
    AND md.trade_date = ps.analysis_date
GROUP BY s.symbol
ORDER BY s.symbol;
```

### **4. News Article Analysis**
```sql
-- News collection summary
SELECT 
    s.symbol,
    COUNT(rna.id) as total_articles,
    MIN(rna.article_date) as earliest_article,
    MAX(rna.article_date) as latest_article,
    AVG(rna.relevance_score) as avg_relevance
FROM symbols s
LEFT JOIN raw_news_articles rna ON s.id = rna.symbol_id
GROUP BY s.symbol
ORDER BY s.symbol;
```

### **5. Performance Analysis**
```sql
-- Daily returns with sentiment correlation
SELECT 
    s.symbol,
    md.trade_date,
    md.close_price,
    LAG(md.close_price) OVER (PARTITION BY s.symbol ORDER BY md.trade_date) as prev_close,
    (md.close_price - LAG(md.close_price) OVER (PARTITION BY s.symbol ORDER BY md.trade_date)) 
        / LAG(md.close_price) OVER (PARTITION BY s.symbol ORDER BY md.trade_date) * 100 as daily_return,
    ps.smo_score,
    ps.confidence_score
FROM market_data md
JOIN symbols s ON md.symbol_id = s.id
LEFT JOIN processed_sentiment ps ON md.symbol_id = ps.symbol_id 
    AND md.trade_date = ps.analysis_date
WHERE s.symbol IN ('AMD', 'INTC', 'NVDA')
ORDER BY s.symbol, md.trade_date;
```

---

## 🎯 **Data Quality & Coverage**

### **Current Status (July 1, 2025)**

| Data Type | Records | Date Range | Coverage |
|-----------|---------|------------|----------|
| **Market Data** | 819 | May 24, 2024 - June 27, 2025 | 100% (399 days) |
| **News Articles** | 606 | May 15 - June 28, 2025 | 1.5 months |
| **Sentiment Analysis** | 48 | May 15 - June 28, 2025 | 5.9% of market data |
| **Technical Indicators** | Variable | Calculated as needed | On-demand |

### **Coverage Analysis by Symbol**

| Symbol | Market Data | News Articles | Sentiment Records |
|--------|-------------|---------------|-------------------|
| **AMD** | 273 records | 219 articles | 16 sentiment |
| **INTC** | 273 records | 167 articles | 22 sentiment |
| **NVDA** | 273 records | 220 articles | 10 sentiment |

### **Data Quality Metrics**
- ✅ **Market Data**: 100% complete, no gaps
- ✅ **Database Integrity**: All foreign keys validated  
- ✅ **Sentiment Processing**: 100% success rate on processed records
- 🎯 **Expansion Opportunity**: Sentiment coverage from 5.9% to 50%+

---

## 🔧 **Development Patterns**

### **Adding New Symbols**
```sql
-- Add new symbol
INSERT INTO symbols (symbol, company_name, sector, is_primary)
VALUES ('AAPL', 'Apple Inc.', 'Technology', true);

-- Verify foreign key relationships work
SELECT s.symbol, COUNT(md.id) as market_records
FROM symbols s
LEFT JOIN market_data md ON s.id = md.symbol_id  
GROUP BY s.symbol;
```

### **Sentiment Data Expansion**
```sql
-- Find market days missing sentiment analysis
SELECT 
    s.symbol,
    md.trade_date,
    md.close_price
FROM market_data md
JOIN symbols s ON md.symbol_id = s.id
LEFT JOIN processed_sentiment ps ON md.symbol_id = ps.symbol_id 
    AND md.trade_date = ps.analysis_date
WHERE ps.id IS NULL
    AND s.symbol IN ('AMD', 'INTC', 'NVDA')
ORDER BY s.symbol, md.trade_date;
```

### **Performance Optimization**
```sql
-- Recommended indexes for common queries
CREATE INDEX IF NOT EXISTS idx_market_data_symbol_date ON market_data(symbol_id, trade_date);
CREATE INDEX IF NOT EXISTS idx_sentiment_symbol_date ON processed_sentiment(symbol_id, analysis_date);
CREATE INDEX IF NOT EXISTS idx_news_symbol_date ON raw_news_articles(symbol_id, article_date);
```

---

## 📊 **Analysis Use Cases**

### **1. Trading Strategy Development**
- **Primary Tables**: `market_data`, `processed_sentiment`
- **Key Joins**: symbol_id and date matching
- **Metrics**: Price returns, sentiment correlation, signal generation

### **2. Sentiment Analysis Enhancement**
- **Primary Tables**: `raw_news_articles`, `processed_sentiment`
- **Focus**: Coverage expansion, quality improvement
- **Opportunity**: Process 771 additional market days

### **3. Risk Management**
- **Primary Tables**: `market_data`, `technical_indicators`
- **Metrics**: Volatility calculation, drawdown analysis
- **Enhancement**: Sentiment-based risk scoring

### **4. Portfolio Optimization**
- **Multi-Symbol Analysis**: All tables joined on symbol_id
- **Correlation Analysis**: Cross-symbol sentiment and price relationships
- **Diversification**: Sector and competitor analysis

---

## 🚀 **Future Enhancements**

### **Schema Extensions**
- **Options Data**: Volatility and options flow tables
- **Earnings Calendar**: Earnings dates and surprise metrics  
- **Economic Indicators**: Macro economic data integration
- **Social Sentiment**: Twitter/Reddit sentiment tables

### **Performance Optimizations**
- **Partitioning**: Time-based partitioning for large datasets
- **Materialized Views**: Pre-calculated analysis views
- **Caching Layer**: Redis for frequent queries
- **Archive Strategy**: Historical data lifecycle management

### **Data Quality Enhancements**
- **Audit Tables**: Change tracking and data lineage
- **Quality Metrics**: Automated data quality scoring
- **Validation Rules**: Business rule enforcement
- **Monitoring**: Data freshness and completeness alerts

---

## 📋 **Maintenance & Operations**

### **Regular Maintenance**
```sql
-- Database health check
SELECT 
    schemaname,
    tablename,
    n_tup_ins as inserts,
    n_tup_upd as updates,
    n_tup_del as deletes,
    n_live_tup as live_rows
FROM pg_stat_user_tables
ORDER BY n_live_tup DESC;

-- Index usage analysis  
SELECT schemaname, tablename, indexname, idx_scan, idx_tup_read, idx_tup_fetch
FROM pg_stat_user_indexes
ORDER BY idx_scan DESC;
```

### **Backup Strategy**
```bash
# Daily backup
pg_dump sentiment_trends > backup_$(date +%Y%m%d).sql

# Selective backup for critical tables
pg_dump -t market_data -t processed_sentiment sentiment_trends > critical_backup.sql
```

### **Connection Management**
```python
# Production connection pattern
from database import get_database_connection
import sqlalchemy

engine = get_database_connection()
with engine.connect() as conn:
    result = conn.execute(sqlalchemy.text("SELECT COUNT(*) FROM market_data"))
    count = result.fetchone()[0]
    print(f"Market data records: {count}")
```

---

## 📋 **Document Maintenance**

**Last Updated**: July 1, 2025  
**Next Review**: After sentiment data expansion  
**Maintainer**: Development Team  
**Version**: 1.0

---

*This reference document should be updated when schema changes are made or new tables are added.* 