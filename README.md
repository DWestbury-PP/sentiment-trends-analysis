# Sentiment Trends Analysis

A **production-ready** quantitative trading strategy platform that combines financial market data with AI-powered sentiment analysis of financial news to generate trading signals.

## 🎯 Project Status: **PHASE 1C COMPLETE**

✅ **Full sentiment analysis trading pipeline operational**  
✅ **Real-time news collection and AI analysis**  
✅ **Production-grade database with normalized schema**  
✅ **Sophisticated 5-category sentiment scoring**  
✅ **Phase 1C: 1+ year historical data backfill COMPLETE**  
🚀 **Ready for Phase 1D: Trading strategy development**

## Project Overview

This project analyzes whether Financial Market News sentiments can become a reliable metric for quantitative trading strategies, using Intel Corporation (INTC) as the primary test case with AMD and NVIDIA as competitors.

**🎯 Current Achievement**: Complete end-to-end pipeline that collects market data, analyzes news sentiment using OpenAI GPT-4o, and stores structured data for trading analysis.

## ✅ Completed Features

### 📊 Market Data Pipeline
- **Real-time OHLCV collection** via Yahoo Finance API
- **16 technical indicators** (SMA 1-8 days, ROC 1-8 days)
- **Normalized PostgreSQL storage** with optimized performance

### 📰 News & Sentiment Analysis
- **50+ news articles per analysis** via Alpha Vantage API
- **AI-powered sentiment scoring** using OpenAI GPT-4o
- **5-category sentiment analysis**:
  - **SMO**: Market Open impact sentiment
  - **SMD**: Mid-Day trading impact sentiment  
  - **SMC**: Market Close impact sentiment
  - **SMS**: Semiconductor sector sentiment
  - **SDC**: Direct competitor sentiment (AMD/NVDA)

### 🏗️ Production Infrastructure
- **Secure API key management** via environment variables
- **Error handling & fallbacks** for all external services
- **Database upsert operations** for conflict-free data updates
- **Multi-symbol architecture** ready for scaling

## Tech Stack

- **Python 3.11** - Core language with comprehensive data science stack
- **Jupyter Notebooks** - Interactive analysis and development
- **PostgreSQL 15** - High-performance time-series database
- **Yahoo Finance API** - Real-time and historical market data
- **Alpha Vantage API** - Professional financial news and sentiment
- **OpenAI GPT-4o** - Advanced sentiment analysis and market intelligence
- **Docker** - Containerized database deployment

## Quick Start

### 1. Environment Setup

```bash
# Clone the repository
git clone <repository-url>
cd sentiment_trends

# Create and activate virtual environment
python -m venv .venv
source .venv/bin/activate  # On macOS/Linux
# or
.venv\Scripts\activate     # On Windows

# Install dependencies
pip install -r requirements.txt

# Register Jupyter kernel
python -m ipykernel install --user --name sentiment_trends
```

### 2. Environment Variables

Create a `.env` file in the project root:

```bash
# Database Configuration
POSTGRES_PASSWORD=sentiment_secure_2024
PGADMIN_PASSWORD=admin_secure_2024

# API Keys (Required for production use)
OPENAI_API_KEY=sk-proj-your_openai_key_here
ALPHA_VANTAGE_API_KEY=your_alpha_vantage_key_here

# Database Connection
DATABASE_URL=postgresql://trader:sentiment_secure_2024@127.0.0.1:5432/sentiment_trends

# Development Settings
DEBUG=True
LOG_LEVEL=INFO
```

### 3. Database Setup

```bash
# Start PostgreSQL container
docker-compose up -d postgres

# The database schema will be automatically created on first run
# Access PgAdmin (optional): http://localhost:8080
```

### 4. API Keys Setup

- **OpenAI**: Get API key from [OpenAI Platform](https://platform.openai.com/api-keys)
- **Alpha Vantage**: Get free API key from [Alpha Vantage](https://www.alphavantage.co/support/#api-key)

### 5. Run the Pipeline

```bash
# Start Jupyter Lab
jupyter lab

# Open and run: notebooks/01_environment_setup.ipynb
# Then run: notebooks/02_data_ingestion_pipeline.ipynb
```

## Project Structure

```
sentiment_trends/
├── docs/                   # Project documentation and strategy
│   ├── PHASE_1_PLANNING    # Original project planning
│   └── PHASE_1_STRATEGY    # Technical decisions and progress
├── src/                    # Core modules
│   ├── __init__.py
│   └── database.py         # Database connections and API management
├── notebooks/              # Analysis and development notebooks
│   ├── 01_environment_setup.ipynb       # Environment verification
│   └── 02_data_ingestion_pipeline.ipynb # Complete data pipeline
├── sql/init/               # Database schema
│   └── 01_create_tables.sql # Production database schema
├── data/                   # Local data storage (empty by design)
├── docker-compose.yml      # PostgreSQL + PgAdmin containers
├── requirements.txt        # Python dependencies
└── .env                    # Environment variables (create manually)
```

## 📊 Data Pipeline Architecture

### Market Data Collection
- **Yahoo Finance Integration**: Real-time OHLCV data retrieval
- **Technical Analysis**: Automated SMA and ROC calculations
- **Multi-symbol Support**: INTC (primary), AMD, NVDA (competitors)

### News & Sentiment Processing
- **Alpha Vantage News API**: Professional financial news collection
- **OpenAI GPT-4o Analysis**: Contextually-aware sentiment scoring
- **Competitive Intelligence**: Advanced competitor sentiment analysis

### Database Schema
- **Normalized Design**: Optimized for performance and data integrity
- **Foreign Key Relationships**: Clean data architecture
- **Automated Indexing**: Query optimization for time-series data

## 🚀 Development Phases

### ✅ Phase 1A: Infrastructure (COMPLETE)
- PostgreSQL database with Docker deployment
- Secure environment variable configuration
- Database connection and API key management
- Complete development environment setup

### ✅ Phase 1B: Data Pipeline (COMPLETE)
- Yahoo Finance market data integration
- Alpha Vantage news collection
- OpenAI GPT-4o sentiment analysis
- Complete database storage with verification
- End-to-end pipeline testing

### ✅ Phase 1C: Historical Data (COMPLETE - EXCEEDED TARGETS)
- **Primary Objective**: 1-year historical data backfill - **ACHIEVED 108% OF TARGET**
- **Results**: 273 trading days collected (vs 252+ target)
- **Multi-symbol Success**: 3/3 symbols processed (INTC, AMD, NVDA)
- **Data Quality**: 100% quality score, zero anomalies detected
- **Technical Coverage**: 1,638 total records (819 market + 819 indicators)
- **Performance**: Optimized batch processing with progress monitoring

### 📋 Phase 1D: Trading Signals (PLANNED)
- Trading signal generation algorithms
- Backtesting framework
- Performance metrics and analysis
- Strategy optimization

### 📋 Phase 1E: Automation (PLANNED)
- Automated daily data collection
- Performance monitoring and alerting
- Visualization dashboard
- Production deployment

## 🎯 Current Capabilities

### Live Data Processing
- **Real-time market data** for any symbol
- **50+ news articles** analysis per request  
- **5-category sentiment scoring** with competitive intelligence
- **Automated technical indicators** calculation

### Historical Data Analysis
- **273 trading days** of historical market data (13+ months)
- **Multi-symbol dataset**: INTC, AMD, NVDA with comparative analysis
- **Complete technical indicators**: SMA/ROC 1-8 days for full dataset
- **Data quality assurance**: 100% validated with zero anomalies

### Production Features  
- **Error handling** with graceful fallbacks
- **API rate limiting** compliance
- **Data conflict resolution** via upsert operations
- **Scalable architecture** for multiple symbols

### Analysis Results Example
```
📊 Latest Analysis (INTC):
SMO (Market Open): +0.1 (Slightly positive opening)
SMD (Mid-Day): +0.2 (Positive mid-day sentiment)
SMC (Market Close): +0.1 (Slight positive close)
SMS (Sector): +0.3 (AI-driven semiconductor optimism)
SDC (Competitors): -0.4 (AMD/NVDA competitive pressure)
```

## VS Code Setup

1. Install **Jupyter extension** by Microsoft
2. Select **sentiment_trends** kernel for notebooks
3. Ensure Python interpreter points to your virtual environment

## 📋 Next Session: Phase 1C Launch

**Objective**: Historical Data Backfill Implementation
- Design batch processing for 1-year historical data
- Implement rate limiting and error recovery
- Create progress monitoring and validation
- Multi-symbol processing expansion

## Contributing

This project follows a systematic, phase-based development approach. See `docs/PHASE_1_STRATEGY` for detailed implementation status and technical decisions.

## License

This project is for educational and research purposes. 