# =============================================================================
# Project: Microsoft Stock Analysis
# Author:Maksym Yakushev
# Date: 2026-05-28
# Description: Build time series object from cleaned Microsoft stock data 
# for further analysis
# =========================================================================


stock <- readRDS("data/processed/msft_clean.rds")

msft_ts <- ts(
    stock$Close
    , frequency = 252
    , start = c(2015, 1)
)

saveRDS(msft_ts, "data/processed/msft_ts.rds")
