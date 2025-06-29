# Phase 1: Systematic Data Collection Strategy

## 📋 **Executive Summary**
This document outlines a systematic approach to building a complete, high-quality dataset for sentiment-based trading strategy development, replacing the current patchwork of "opportunistic shortcuts" with a properly planned data foundation.

---

## 🚨 **Current State Assessment**

### **Data Quality Issues Identified:**
- ✅ **Market Data**: Excellent (273 days, May 2024 → June 2025)
- ⚠️ **News Data**: Spotty (14 days, uneven symbol coverage)
- ⚠️ **Sentiment Data**: Limited (27 records, follows news gaps)
- ❌ **Alignment**: Poor NVDA coverage (22.2%), weekend gaps

### **Root Causes:**
1. **Opportunistic collection** without systematic planning
2. **Uneven symbol prioritization** (NVDA severely under-covered)
3. **Calendar misalignment** (weekends, market holidays)
4. **Volume imbalance** (119 articles/day vs 4 articles/day)

---

## 🎯 **Strategic Objectives**

### **Primary Goals:**
1. **Complete Data Alignment**: All symbols covered for same time periods
2. **Quality over Quantity**: Curated sources, smart article selection
3. **Scalable Architecture**: Foundation for 1-year+ expansion
4. **Cost Optimization**: Efficient processing without signal loss

### **Success Metrics:**
- **Coverage**: ≥90% data alignment across all symbols
- **Depth**: Minimum 30 trading days for proof of concept
- **Quality**: ≥0.80 average confidence in sentiment analysis
- **Efficiency**: <$50/month processing costs for 3 symbols

---

## 📅 **Phased Collection Strategy**

### **Phase 1A: Foundation Dataset (30 Days)**
**Timeline**: 1-2 weeks  
**Scope**: Build solid 30-day foundation with complete alignment

**Target Period**: `2025-05-15 to 2025-06-28` (30 trading days)
- **Market Data**: ✅ Already available
- **News Data**: Systematic collection for all symbols
- **Sentiment Data**: Process with enhanced article selection

**Symbol Coverage**:
- **INTC**: 30 trading days × 3-5 articles/day = ~120 articles
- **AMD**: 30 trading days × 3-5 articles/day = ~120 articles  
- **NVDA**: 30 trading days × 3-5 articles/day = ~120 articles
- **Total**: ~360 high-quality articles (vs current 552 low-quality mix)

### **Phase 1B: Extended Dataset (90 Days)**
**Timeline**: 2-3 weeks  
**Scope**: Expand to quarterly coverage for robust backtesting

**Target Period**: `2025-03-01 to 2025-06-28` (90 trading days)
- **Total Articles**: ~1,080 curated articles
- **Sentiment Records**: ~270 analyses (3 symbols × 90 days)

### **Phase 1C: Annual Dataset (250 Days)**
**Timeline**: Future expansion after strategy validation
**Target Period**: `2024-06-01 to 2025-06-28` (250 trading days)

---

## 🏗️ **Technical Implementation Plan**

### **1. Enhanced News Collection Architecture**

**Source Quality Tiers** (from Phase 1 Key Findings):
```python
TIER_1_SOURCES = {
    'reuters.com': 2.0,
    'bloomberg.com': 2.0, 
    'marketwatch.com': 2.0,
    'seekingalpha.com': 2.0,
    'finance.yahoo.com': 2.0
}

TIER_2_SOURCES = {
    'cnbc.com': 1.0,
    'forbes.com': 1.0,
    'barrons.com': 1.0
}
```

**Daily Collection Targets**:
- **Tier 1**: 2-3 articles per symbol per day
- **Tier 2**: 1-2 articles per symbol per day  
- **Total**: 3-5 articles per symbol per day
- **Quality Gate**: Minimum 0.70 relevance score

### **2. Systematic Date Range Processing**

**Calendar Strategy**:
```python
def get_systematic_date_ranges(start_date, end_date):
    """Generate aligned trading day ranges for all data types"""
    
    # 1. Get trading days (exclude weekends/holidays)
    trading_days = get_trading_calendar(start_date, end_date)
    
    # 2. Extend news collection to weekends
    # (news published on weekends affects Monday trading)
    news_days = get_extended_calendar(start_date, end_date)
    
    # 3. Align sentiment processing to trading days
    sentiment_days = trading_days
    
    return trading_days, news_days, sentiment_days
```

### **3. Balanced Collection Algorithm**

**Daily Processing Workflow**:
```python
def collect_balanced_daily_data(symbol, target_date, max_articles=5):
    """Systematic daily collection with quality controls"""
    
    # 1. Fetch all available articles for date
    raw_articles = fetch_eod_articles(symbol, target_date)
    
    # 2. Apply source quality weighting  
    weighted_articles = apply_source_weighting(raw_articles)
    
    # 3. Smart selection (tier-balanced, deduped)
    selected_articles = smart_article_selection(
        weighted_articles, 
        max_articles=max_articles,
        tier_distribution="2-2-1"  # 2 Tier1, 2 Tier2, 1 Tier3
    )
    
    # 4. Quality gate
    if avg_relevance(selected_articles) < 0.70:
        expand_search_or_skip(symbol, target_date)
    
    return selected_articles
```

---

## 💰 **Cost Optimization Strategy**

### **Processing Economics**:
- **Current Inefficient**: 552 articles → $11-15 processing cost
- **Optimized Target**: 360 articles → $7-9 processing cost
- **Quality Improvement**: 70% cost reduction + better signal

**Monthly Budget Estimate**:
- **EOD API**: $19.99/month
- **OpenAI Processing**: ~$25/month (360 articles × $0.02)
- **Total**: ~$45/month for 3 symbols

### **Scaling Economics** (Future):
- **Phase 1B (90 days)**: ~$75 one-time processing cost
- **Phase 1C (250 days)**: ~$200 one-time processing cost
- **Ongoing**: $45/month for real-time updates

---

## 📊 **Data Quality Assurance**

### **Validation Checkpoints**:

**1. Collection Validation**:
```sql
-- Daily completeness check
SELECT symbol, date, article_count, tier1_count, tier2_count
FROM daily_collection_summary 
WHERE article_count < 3 OR tier1_count < 1;

-- Alignment validation  
SELECT symbol, 
       market_days, news_days, sentiment_days,
       (least(market_days, news_days, sentiment_days) / 
        greatest(market_days, news_days, sentiment_days)) * 100 as alignment_pct
FROM data_completeness_summary;
```

**2. Quality Metrics**:
- **Coverage**: ≥95% trading days with 3+ articles
- **Source Mix**: ≥40% Tier 1 sources
- **Relevance**: ≥0.70 average relevance score
- **Confidence**: ≥0.75 average sentiment confidence

**3. Alignment Standards**:
- **Symbol Parity**: <10% variance in coverage between symbols
- **Calendar Sync**: ≥90% trading days with complete data
- **Processing Lag**: <24 hours from collection to sentiment

---

## 🚀 **Implementation Roadmap**

### **Week 1: Foundation Setup**
- [ ] **Day 1-2**: Implement enhanced article selection algorithm
- [ ] **Day 3-4**: Build systematic date range processing
- [ ] **Day 5-7**: Test and validate on 2025-06-15 to 2025-06-28 (2 weeks)

### **Week 2: Backfill Execution**  
- [ ] **Day 1-3**: Backfill 2025-06-01 to 2025-06-14 (2 weeks)
- [ ] **Day 4-5**: Process sentiment for all new articles
- [ ] **Day 6-7**: Quality validation and gap analysis

### **Week 3: Expansion**
- [ ] **Day 1-5**: Extend to 2025-05-15 to 2025-05-31 (2 weeks)
- [ ] **Day 6-7**: Final validation and strategy preparation

### **Target Outcome**: 
**6 weeks of complete, high-quality data** (30 trading days) ready for strategy development

---

## 🎯 **Success Criteria**

### **Phase 1A Completion Criteria**:
- ✅ **30 trading days** of complete data for all symbols
- ✅ **≥90% alignment** between market/news/sentiment data
- ✅ **3-5 articles/day** average with ≥70% from Tier 1-2 sources
- ✅ **≥0.75 confidence** in sentiment analysis
- ✅ **<$50 total cost** for complete dataset

### **Ready for Strategy Development When**:
- All symbols have equal coverage (±5% variance)
- No missing trading days in target period
- Quality metrics meet all thresholds
- Data pipeline validated and repeatable

---

## 📋 **Risk Mitigation**

### **Data Risks**:
- **EOD API Limits**: Rate limiting, backup collection methods
- **News Source Changes**: Multiple Tier 1 sources, graceful degradation
- **Weekend Gaps**: Extended collection windows, Monday preprocessing

### **Cost Risks**:
- **OpenAI Overruns**: Daily processing limits, batch optimization
- **EOD Charges**: Monthly usage monitoring, alternative sources ready

### **Quality Risks**:
- **Relevance Drift**: Regular scoring calibration, manual validation samples
- **Source Bias**: Balanced tier distribution, diverse source mix

---

## 📈 **Future Scaling Path**

### **Phase 2: Production Dataset**
- **Timeline**: After strategy validation
- **Scope**: 6-12 months historical data
- **Symbols**: Expand to 10+ semiconductor/tech stocks
- **Features**: Intraday sentiment, social media integration

### **Phase 3: Real-time Pipeline**  
- **Timeline**: After backtesting success
- **Scope**: Live data ingestion and processing
- **Latency**: <15 minutes from news to sentiment
- **Integration**: Direct trading platform connectivity

---

*This strategy transforms our opportunistic data collection into a systematic, high-quality foundation for serious trading strategy development.* 