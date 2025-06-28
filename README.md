# Sentiment Trends Analysis

A quantitative trading strategy development platform that combines financial market data with LLM-powered sentiment analysis of financial news.

## Project Overview

This project analyzes whether Financial Market News sentiments can become a reliable metric for quantitative trading strategies, using Intel Corporation (INTC) as the primary test case.

## Tech Stack

- **Python 3.11** - Core language
- **Jupyter Notebooks** - Analysis and experimentation
- **PostgreSQL** - Time-series data storage
- **Yahoo Finance API** - Historical market data
- **Alpha Vantage API** - Financial news and sentiment data
- **OpenAI GPT-4o/4o-mini** - Sentiment analysis
- **Docker** - Database containerization

## Quick Start

### 1. Environment Setup

```bash
# Activate your virtual environment
source .venv/bin/activate  # On macOS/Linux
# or
.venv\Scripts\activate     # On Windows

# Install dependencies
pip install -r requirements.txt
```

### 2. Environment Variables

Create a `.env` file in the project root with:

```bash
# Database Configuration
POSTGRES_PASSWORD=your_secure_password_here
PGADMIN_PASSWORD=your_pgadmin_password_here

# API Keys
OPENAI_API_KEY=your_openai_api_key_here
ALPHA_VANTAGE_API_KEY=your_alpha_vantage_api_key_here

# Database Connection
DATABASE_URL=postgresql://trader:your_secure_password_here@localhost:5432/sentiment_trends

# Development Settings
DEBUG=True
LOG_LEVEL=INFO
```

### 3. Database Setup

```bash
# Start PostgreSQL container
docker-compose up -d postgres

# Access PgAdmin (optional)
# Navigate to http://localhost:8080
# Email: admin@example.com
# Password: [your PGADMIN_PASSWORD]
```

### 4. Get API Keys

- **OpenAI**: Get your API key from [OpenAI Platform](https://platform.openai.com/api-keys)
- **Alpha Vantage**: Get your free API key from [Alpha Vantage](https://www.alphavantage.co/support/#api-key)

## Project Structure

```
sentiment_trends/
├── docs/                   # Project documentation and planning
├── src/                    # Source code modules
├── notebooks/              # Jupyter notebooks for analysis
├── data/                   # Local data storage
├── sql/                    # Database schemas and migrations
├── docker-compose.yml      # PostgreSQL container setup
└── requirements.txt        # Python dependencies
```

## Data Pipeline

### Market Data (OHLCV)
- **Source**: Yahoo Finance via `yfinance`
- **Symbol**: INTC (Intel Corporation)
- **Period**: 1 year of historical data (post-2020)

### Technical Indicators
- **SMA**: Simple Moving Averages (1-8 day periods)
- **ROC**: Rate of Change (1-8 day periods)

### Sentiment Metrics
- **SMO**: Sentiment at Market Open (9:30 AM EST)
- **SMD**: Sentiment at Mid-Day (12:30 PM EST)
- **SMC**: Sentiment at Market Close (4:00 PM EST)
- **SMS**: Sentiment of Market Sector (semiconductors)
- **SDC**: Sentiment of Direct Competitors (AMD, NVDA)

## Development Phases

- **Phase 1A**: Data pipeline setup
- **Phase 1B**: Calculations and analysis
- **Phase 1C**: Visualization and backtesting tools

## VS Code Setup

Install the official **Jupyter extension** by Microsoft for the best notebook experience.

## Contributing

This project follows a methodical, step-by-step development approach. See `docs/PHASE_1_STRATEGY` for current implementation decisions and progress tracking.

## License

This project is for educational and research purposes. 