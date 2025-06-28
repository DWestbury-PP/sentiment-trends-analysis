-- Sentiment Trends Analysis Database Schema
-- Phase 1A: Market Data and Technical Indicators

-- Create database extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Drop tables if they exist (for development)
DROP TABLE IF EXISTS news_sentiment CASCADE;
DROP TABLE IF EXISTS technical_indicators CASCADE;
DROP TABLE IF EXISTS market_data CASCADE;
DROP TABLE IF EXISTS symbols CASCADE;

-- Symbols table
CREATE TABLE symbols (
    id SERIAL PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL UNIQUE,
    company_name VARCHAR(255) NOT NULL,
    sector VARCHAR(100),
    is_primary BOOLEAN DEFAULT FALSE,
    is_competitor BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Market data table (OHLCV)
CREATE TABLE market_data (
    id SERIAL PRIMARY KEY,
    symbol_id INTEGER REFERENCES symbols(id),
    trade_date DATE NOT NULL,
    open_price DECIMAL(10, 4) NOT NULL,
    high_price DECIMAL(10, 4) NOT NULL,
    low_price DECIMAL(10, 4) NOT NULL,
    close_price DECIMAL(10, 4) NOT NULL,
    volume BIGINT NOT NULL,
    dividends DECIMAL(10, 4) DEFAULT 0,
    stock_splits DECIMAL(10, 4) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(symbol_id, trade_date)
);

-- Technical indicators table
CREATE TABLE technical_indicators (
    id SERIAL PRIMARY KEY,
    symbol_id INTEGER REFERENCES symbols(id),
    trade_date DATE NOT NULL,
    -- Simple Moving Averages (1-8 days)
    sma_1 DECIMAL(10, 4),
    sma_2 DECIMAL(10, 4),
    sma_3 DECIMAL(10, 4),
    sma_4 DECIMAL(10, 4),
    sma_5 DECIMAL(10, 4),
    sma_6 DECIMAL(10, 4),
    sma_7 DECIMAL(10, 4),
    sma_8 DECIMAL(10, 4),
    -- Rate of Change (1-8 days)
    roc_1 DECIMAL(10, 4),
    roc_2 DECIMAL(10, 4),
    roc_3 DECIMAL(10, 4),
    roc_4 DECIMAL(10, 4),
    roc_5 DECIMAL(10, 4),
    roc_6 DECIMAL(10, 4),
    roc_7 DECIMAL(10, 4),
    roc_8 DECIMAL(10, 4),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(symbol_id, trade_date)
);

-- News sentiment table
CREATE TABLE news_sentiment (
    id SERIAL PRIMARY KEY,
    symbol_id INTEGER REFERENCES symbols(id),
    trade_date DATE NOT NULL,
    -- Sentiment at different times (scale: -1 to 1)
    sentiment_market_open DECIMAL(3, 2),     -- SMO
    sentiment_mid_day DECIMAL(3, 2),         -- SMD  
    sentiment_market_close DECIMAL(3, 2),    -- SMC
    sentiment_market_sector DECIMAL(3, 2),   -- SMS
    sentiment_direct_competitor DECIMAL(3, 2), -- SDC
    -- Metadata
    news_count_open INTEGER DEFAULT 0,
    news_count_mid INTEGER DEFAULT 0,
    news_count_close INTEGER DEFAULT 0,
    news_count_sector INTEGER DEFAULT 0,
    news_count_competitor INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(symbol_id, trade_date)
);

-- Create indexes for performance
CREATE INDEX idx_market_data_symbol_date ON market_data(symbol_id, trade_date);
CREATE INDEX idx_market_data_date ON market_data(trade_date);
CREATE INDEX idx_technical_indicators_symbol_date ON technical_indicators(symbol_id, trade_date);
CREATE INDEX idx_news_sentiment_symbol_date ON news_sentiment(symbol_id, trade_date);

-- Insert initial symbols
INSERT INTO symbols (symbol, company_name, sector, is_primary, is_competitor) VALUES
('INTC', 'Intel Corporation', 'Technology', TRUE, FALSE),
('AMD', 'Advanced Micro Devices Inc', 'Technology', FALSE, TRUE),
('NVDA', 'NVIDIA Corporation', 'Technology', FALSE, TRUE);

-- Create a view for complete daily data
CREATE VIEW daily_analysis AS
SELECT 
    s.symbol,
    s.company_name,
    md.trade_date,
    md.open_price,
    md.high_price,
    md.low_price,
    md.close_price,
    md.volume,
    -- Technical indicators
    ti.sma_1, ti.sma_2, ti.sma_3, ti.sma_4, ti.sma_5, ti.sma_6, ti.sma_7, ti.sma_8,
    ti.roc_1, ti.roc_2, ti.roc_3, ti.roc_4, ti.roc_5, ti.roc_6, ti.roc_7, ti.roc_8,
    -- Sentiment data
    ns.sentiment_market_open,
    ns.sentiment_mid_day,
    ns.sentiment_market_close,
    ns.sentiment_market_sector,
    ns.sentiment_direct_competitor
FROM symbols s
LEFT JOIN market_data md ON s.id = md.symbol_id
LEFT JOIN technical_indicators ti ON s.id = ti.symbol_id AND md.trade_date = ti.trade_date
LEFT JOIN news_sentiment ns ON s.id = ns.symbol_id AND md.trade_date = ns.trade_date
ORDER BY s.symbol, md.trade_date;

-- Grant permissions
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO trader;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO trader; 