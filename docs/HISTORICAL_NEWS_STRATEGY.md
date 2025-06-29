# Historical News Data Strategy
## Decoupled Architecture for Real Historical Validation

### Strategic Decision: Hybrid Approach

**Problem**: Alpha Vantage lacks true historical news depth needed for strategy validation.

**Solution**: Multi-source approach with decoupled news collection and sentiment analysis.

---

## 📊 **Data Sources Strategy**

### **Option A: Polygon.io (Recommended for Production)**
- **Investment**: $99/month for historical news API
- **Benefit**: High-quality, reliable historical financial news
- **Timeline**: 2015+ historical coverage
- **ROI**: Essential for validating strategy effectiveness
- **Implementation**: 2-3 days to integrate

### **Option B: GDELT Project (Free Alternative)**
- **Investment**: Development time only
- **Benefit**: Massive free historical archive
- **Timeline**: 2015+ global financial news
- **Complexity**: Higher - requires news filtering/processing
- **Implementation**: 1-2 weeks to build robust pipeline

### **Option C: Hybrid Approach (Recommended)**
- **Phase 1**: Use GDELT for historical backfill (free)
- **Phase 2**: Upgrade to Polygon.io for production (paid)
- **Benefit**: Validate strategy viability before financial commitment

---

## 🏗️ **Decoupled Architecture**

### **1. News Collection Layer**
```
Database Tables:
- raw_news_articles (id, symbol, date, title, content, source, url)
- news_processing_queue (id, article_id, status, processing_date)
- news_sources (id, source_name, api_config, status)
```

### **2. Sentiment Analysis Layer**
```
Database Tables:
- sentiment_analysis (id, article_id, sentiment_scores, analysis_date)
- sentiment_processing_jobs (id, batch_id, status, tokens_used)
- sentiment_aggregations (id, symbol, date, final_scores)
```

### **3. Benefits of Decoupling**
- **Reprocessing**: Rerun sentiment analysis with different prompts
- **Cost Control**: Batch processing for OpenAI API efficiency
- **Data Persistence**: Never lose raw news data
- **Debugging**: Inspect raw news when sentiment seems off
- **Scaling**: Different processing speeds for different components

---

## ⚡ **Aggressive OpenAI API Strategy**

### **Rate Limiting Optimization**
- **Target**: 1 request every 10-20 seconds (180-360 requests/hour)
- **Batch Size**: 5-10 articles per request for efficiency
- **Daily Capacity**: 4,000-8,000 requests per day
- **Cost Estimate**: $20-40/day for intensive backtesting

### **Exponential Backoff Implementation**
```python
class AggressiveRateLimiter:
    def __init__(self, base_delay=10, max_delay=300):
        self.base_delay = base_delay
        self.max_delay = max_delay
        self.consecutive_failures = 0
        
    def request_with_backoff(self, api_call):
        while True:
            try:
                result = api_call()
                self.consecutive_failures = 0  # Reset on success
                return result
            except RateLimitError:
                delay = min(self.base_delay * (2 ** self.consecutive_failures), self.max_delay)
                time.sleep(delay)
                self.consecutive_failures += 1
```

### **Batch Processing Strategy**
- **News Batching**: Process 5-10 articles per OpenAI call
- **Date Batching**: Process 1 week of news at a time
- **Symbol Batching**: Process multiple symbols simultaneously
- **Queue Management**: Prioritize recent dates for live trading

---

## 📈 **Implementation Roadmap**

### **Phase 1: Database Redesign (1-2 days)**
1. Create `raw_news_articles` table
2. Create `sentiment_processing_queue` table
3. Update database schema for decoupled architecture
4. Modify existing code to use new tables

### **Phase 2: News Collection (1 week)**
1. Implement GDELT historical news collector
2. Build news filtering for INTC/AMD/NVDA relevant articles
3. Create news quality scoring system
4. Backfill 1+ years of historical news

### **Phase 3: Aggressive Sentiment Processing (3-5 days)**
1. Implement optimized OpenAI API client
2. Build batch processing system
3. Create sentiment job queue management
4. Process historical news into sentiment scores

### **Phase 4: Validation & Optimization (1 week)**
1. Compare sentiment scores against known market events
2. Optimize sentiment prompts based on results
3. Implement production monitoring
4. Document lessons learned

---

## 💰 **Cost Analysis**

### **GDELT + OpenAI Approach**
- **News Data**: $0 (free)
- **OpenAI Processing**: $20-40/day during backfill
- **Total 1-year backfill**: ~$500-1000
- **Ongoing monthly**: ~$100-200

### **Polygon.io Approach**
- **News Data**: $99/month
- **OpenAI Processing**: Same as above
- **Total 1-year backfill**: ~$1,500-2,000
- **Ongoing monthly**: ~$200-300

### **Recommendation**: Start with GDELT to prove concept, then upgrade to Polygon.io for production trading.

---

## 🎯 **Success Metrics**

### **Data Quality Metrics**
- **News Coverage**: 80%+ of trading days have relevant news
- **Sentiment Accuracy**: Manual spot-checking shows logical alignment
- **Processing Speed**: Complete 1-year backfill within 2 weeks
- **Cost Efficiency**: Under $1,000 for complete historical validation

### **Strategy Validation Metrics**
- **Correlation Analysis**: Sentiment vs. price movement correlation
- **Predictive Power**: Sentiment's ability to predict next-day returns
- **Risk-Adjusted Returns**: Sharpe ratio improvement with sentiment
- **Robustness**: Performance across different market conditions

---

## 🚀 **Next Steps**

1. **Immediate**: Implement decoupled database schema
2. **Week 1**: Build GDELT news collection pipeline
3. **Week 2**: Implement aggressive OpenAI sentiment processing
4. **Week 3**: Validate strategy with historical data
5. **Week 4**: Optimize and prepare for live trading

This approach gives you **real historical data** for strategy validation while maintaining **cost control** and **technical flexibility**.

## 🔄 **PENDING DECISION: News Data Provider**

### **Current Status: Testing GDELT (Free)**
- **Attempting**: GDELT Project integration for free historical news
- **Challenge**: Connection timeouts and reliability issues
- **Benefits**: $0 collection cost, unlimited reprocessing of sentiment
- **Strategy**: Improve error handling, retries, and rate limiting

### **Backup Plan: EOD Historical Data ($19.99/month)**
- **Reliable**: Proven infrastructure with 6+ years of historical data
- **Built-in sentiment**: Pre-computed scores (saves OpenAI costs)
- **Cost**: $240/year ongoing vs one-time GDELT collection
- **Switch trigger**: If GDELT reliability issues cannot be resolved

### **Cost Analysis**:
```
GDELT Approach (if working):
- News collection: $0
- Sentiment processing: $500-800 (one-time)
- Reprocessing: $0 (data already owned)
- Total 5-year cost: $500-800

EOD Approach:
- News + sentiment: $240/year
- Total 5-year cost: $1,200
```

**Decision criteria**: Focus on GDELT reliability improvements first, fallback to EOD if needed. 