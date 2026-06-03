# =============================================================================
# Project: Microsoft Stock Analysis
# Author:  Maksym Yakushev
# Date:    2026-06-03
# Description: Build monthly time series object from Microsoft stock data
# =============================================================================


# 1. Data Loading -------------------------------------------------------------

library(dplyr)

stock <- readRDS("data/processed/msft_clean.rds")


# 2. Monthly Aggregation ------------------------------------------------------

stock_monthly <- stock %>%
    mutate(Month = format(Date, "%Y-%m")) %>%
    group_by(Month) %>%
    summarise(Close = mean(Close),.groups = "drop")


# 3. Monthly Time Series Creation ---------------------------------------------

first_month <- stock_monthly$Month[1]
start_year <- as.numeric(substr(first_month, 1, 4))
start_month <- as.numeric(substr(first_month, 6, 7))

msft_ts_monthly <- ts(
    stock_monthly$Close
    , frequency = 12
    , start = c(start_year, start_month)
)


# 4. Save Results -------------------------------------------------------------

saveRDS(stock_monthly,"data/processed/msft_monthly.rds")
saveRDS(msft_ts_monthly,"data/processed/msft_ts_monthly.rds")