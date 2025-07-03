# Sentiment Trends Analysis

A quantitative trading strategy platform that combines financial market data with AI-powered sentiment analysis of financial news to generate trading signals for semiconductor stocks (INTC, AMD, NVDA).

## Project Goals

This system analyzes the relationship between financial market news sentiment and quantitative trading opportunities, focusing on semiconductor stocks. The primary objectives are:

1. **Data Integration**: Combine historical market data with news sentiment analysis to create comprehensive trading datasets
2. **Sentiment Analysis**: Process financial news using AI to generate actionable sentiment scores across multiple market timing dimensions
3. **Trading Strategy Development**: Create and backtest quantitative trading strategies using multi-factor signals
4. **Scalable Architecture**: Build a system that can expand across timeframes, assets, and data sources

## Current Status

### Data Coverage
- **Market Data**: 819 records spanning May 2024 to June 2025 (13 months)
- **News Articles**: 606 articles collected from May-June 2025  
- **Sentiment Analysis**: 48 processed records across all symbols
- **Coverage Gap**: 5.9% sentiment coverage relative to market data (771 additional analyses needed)

### System Components
- **Database**: PostgreSQL with normalized schema for market data, news articles, and sentiment analysis
- **Analysis Pipeline**: Complete data processing and visualization framework
- **Sentiment Processing**: OpenAI GPT-4o-mini integration with custom 5-dimensional scoring system
- **Visualization**: Interactive dashboards using Plotly for comprehensive market analysis

### Performance Metrics
- **NVDA**: +0.210% average daily return (outperformer)
- **AMD**: +0.001% average daily return (stable)
- **INTC**: -0.032% average daily return (underperformer)
- **Average Daily Volume**: 135.9M shares across all symbols
- **Sentiment Processing**: 82% average confidence score with 96% processing success rate

## Architecture

### Data Flow
```
Market Data (EOD API) → PostgreSQL → Analysis Pipeline → Trading Signals
News Articles (EOD API) → Sentiment Processing (OpenAI) → PostgreSQL → Strategy Integration
```

### Key Design Decisions

1. **Decoupled Architecture**: Separate news collection from sentiment processing to enable cost optimization and quality control
2. **Multi-dimensional Sentiment**: 5-category SMO framework (Market Open, Mid-Day, Close, Sector, Competitor) for nuanced analysis
3. **PostgreSQL Database**: Normalized schema supporting complex joins and time-series analysis
4. **Modular Pipeline**: Jupyter notebooks for each processing stage, enabling iterative development and testing

### Technology Stack
- **Python 3.11** with pandas, numpy, SQLAlchemy 2.0+
- **PostgreSQL 15** for time-series data storage
- **EOD Historical Data API** for market data and news collection
- **OpenAI GPT-4o-mini** for sentiment analysis
- **Plotly** for interactive visualizations
- **Docker** for database containerization

## Implementation Approach

### Sentiment Analysis Framework
The system employs a custom SMO (Sentiment Market Operations) framework with five dimensions:
- **SMO**: Market open impact prediction
- **SMD**: Mid-day trading impact assessment  
- **SMC**: Market close impact evaluation
- **SMS**: Semiconductor sector impact measurement
- **SDC**: Direct competitor impact analysis

### Quality Control
- **Source Tiering**: Multi-tier quality assessment for news sources
- **Relevance Scoring**: Automated article relevance calculation
- **Confidence Metrics**: Sentiment analysis confidence scoring
- **Validation Pipeline**: Multi-layer data quality validation

### Trading Integration
- **Multi-factor Signals**: Combines sentiment (40%), technical indicators (40%), and competitive analysis (20%)
- **Position Sizing**: Sentiment strength determines position size (5-25% of portfolio)
- **Risk Management**: Confidence-based adjustments and dynamic thresholds

## Getting Started

### Prerequisites
- Python 3.11+
- Docker and Docker Compose
- API keys for OpenAI and EOD Historical Data

### Setup
1. **Environment Setup**
   ```bash
   git clone <repository-url>
   cd sentiment_trends
   python -m venv .venv
   source .venv/bin/activate  # macOS/Linux
   pip install -r requirements.txt
   ```

2. **Environment Variables**
   Create `.env` file with required API keys and database credentials:
   ```bash
   POSTGRES_PASSWORD=sentiment_secure_2024
   OPENAI_API_KEY=your_openai_key_here
   EOD_API_KEY=your_eod_api_key_here
   DATABASE_URL=postgresql://trader:sentiment_secure_2024@127.0.0.1:5432/sentiment_trends
   ```

3. **Database Setup**
   ```bash
   docker-compose up -d postgres
   ```

4. **Analysis Pipeline**
   ```bash
   jupyter lab
   # Open: 09_visualization_and_analysis.ipynb
   ```

## Project Structure

```
sentiment_trends/
├── docs/                   # Project documentation
├── src/                    # Core modules
│   └── database.py         # Database connections and API management
├── notebooks/              # Analysis and development notebooks
│   ├── 01_environment_setup.ipynb               # Environment verification
│   ├── 02_data_ingestion_pipeline.ipynb         # Market data pipeline
│   ├── 03_historical_data_backfill.ipynb        # Historical price data
│   ├── 04_historical_news_collection.ipynb      # News collection system
│   ├── 05_sentiment_processing.ipynb            # Sentiment analysis pipeline
│   ├── 06_systematic_data_collection.ipynb      # Systematic data collection
│   ├── 07_production_data_collection.ipynb      # Production data processing
│   ├── 08_trading_strategy_development.ipynb    # Trading strategy framework
│   └── 09_visualization_and_analysis.ipynb      # Main analysis pipeline
├── sql/init/               # Database schema
├── docker-compose.yml      # PostgreSQL + PgAdmin containers
├── requirements.txt        # Python dependencies
└── .env                    # Environment variables (create manually)
```

## Current Capabilities

### Market Analysis
- Historical price and volume analysis across full dataset
- Daily returns analysis with volatility metrics
- Multi-symbol performance comparison
- Trend identification and pattern analysis

### Sentiment Integration
- AI-powered sentiment scoring using OpenAI GPT-4o-mini
- Multi-dimensional sentiment analysis with confidence scoring
- News article collection and quality filtering
- Sentiment-market correlation analysis

### Trading Strategy Framework
- Multi-factor signal generation combining sentiment, technical, and competitive analysis
- Basic backtesting framework with performance metrics
- Risk assessment with volatility and drawdown analysis
- Position sizing based on signal strength and confidence

### Visualization and Analysis
- Interactive dashboards for market performance analysis
- Sentiment distribution and correlation visualizations
- Trading strategy performance metrics
- Data quality and coverage assessment tools

## Next Steps

### Immediate Priorities (Next 2-4 weeks)
1. **Sentiment Data Expansion**: Backfill sentiment analysis for historical market data to achieve 50%+ coverage
2. **Quality Enhancement**: Improve sentiment processing reliability and confidence scoring
3. **Historical Analysis**: Process sentiment for major market events and earnings periods
4. **Coverage Validation**: Ensure sentiment quality across expanded dataset

### Short-term Development (Next 1-3 months)
1. **Advanced Trading Strategies**: Implement multi-factor models with comprehensive sentiment data
2. **Full Dataset Backtesting**: Historical performance analysis with expanded sentiment coverage
3. **Risk Management Enhancement**: Advanced position sizing and portfolio optimization
4. **Real-time Processing**: Live sentiment analysis and signal generation capabilities

### Medium-term Opportunities (Next 3-6 months)
1. **Live Trading Implementation**: Paper trading with real-time signals
2. **Multi-asset Expansion**: Extend analysis to additional technology stocks
3. **Machine Learning Integration**: Sentiment prediction and market forecasting models
4. **Production Scaling**: High-frequency trading capabilities and infrastructure

### Long-term Vision (6+ months)
1. **Proprietary Models**: Custom fine-tuned models for financial sentiment analysis
2. **Multi-market Expansion**: International markets and additional asset classes
3. **Automated Trading**: Full end-to-end automated trading system
4. **Advanced Analytics**: Predictive modeling and complex strategy optimization

## Data Sources and APIs

- **EOD Historical Data**: Market data and financial news ($19.99/month)
- **OpenAI API**: GPT-4o-mini for sentiment analysis (~$0.02 per analysis)
- **PostgreSQL**: Local database for data storage and analysis

## Documentation

- `docs/CURRENT_STATUS_AND_NEXT_STEPS.md`: Detailed current capabilities and development roadmap
- `docs/DATABASE_SCHEMA_REFERENCE.md`: Complete database schema documentation
- `docs/SENTIMENT_ANALYSIS_METHODOLOGY.md`: Comprehensive sentiment analysis approach
- `docs/PHASE_1_KEY_FINDINGS.md`: Historical development achievements and lessons learned

## Development Status

**Current Version**: 3.0  
**Last Updated**: July 1, 2025  
**Primary Development Focus**: Sentiment data expansion to match market data coverage  
**Next Milestone**: 400+ sentiment analyses to achieve 50% market data coverage 