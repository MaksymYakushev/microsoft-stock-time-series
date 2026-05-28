# =============================================================================
# Project: Microsoft Stock Analysis
# Author:  Maksym Yakushev
# Date:    2026-05-28
# Description: Box–Cox transformation of Microsoft stock time series to 
#stabilize variance and analyze the transformed series
# =============================================================================

# 1. Data Loading -------------------------------------------------------------

msft_ts <- readRDS("data/processed/msft_ts.rds")


# 2. Box–Cox Transformation -----------------------------------------------------

library(forecast)

jpeg(
  filename = "outputs/msft_box_cox.jpg"
  , width    = 1200
  , height   = 900   
  , res      = 150
)

box_ts <- BoxCox(msft_ts, lambda = 0)
plot(box_ts, main = "Box–Cox transformation")

dev.off()


# 3. ACF of Box–Cox Transformed Data -------------------------------------------

jpeg(
  filename = "outputs/msft_box_acf.jpg"
  , width    = 1200
  , height   = 900   
  , res      = 150
)

acf(box_ts, lag.max = 24, main = "ACF of Box–Cox transformation")

dev.off()


# 4. PACF of Box–Cox Transformed Data ------------------------------------------

jpeg(
  filename = "outputs/msft_box_pacf.jpg"
  , width    = 1200
  , height   = 900   
  , res      = 150
)

pacf(box_ts, lag.max = 24, main = "PACF of Box–Cox transformation")

dev.off()
