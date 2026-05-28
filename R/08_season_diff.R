# =============================================================================
# Project: Microsoft Stock Analysis
# Author:  Maksym Yakushev
# Date:    2026-05-28
# Description: Seasonal differencing of Microsoft stock time series to remove 
#seasonality and analyze the seasonally differenced series
# =============================================================================


# 1. Data Loading -------------------------------------------------------------

msft_ts <- readRDS("data/processed/msft_ts.rds")


# 2. Seasonal Differencing -----------------------------------------------------

jpeg(
  filename = "outputs/msft_season_diff.jpg"
  , width    = 1200
  , height   = 900   
  , res      = 150
)

diff_season <- diff(msft_ts, lag = 252)
plot(diff_season, main = "Seasonal Difference")

dev.off()


# 3. ACF of Seasonally Differenced Data ----------------------------------------

jpeg(
  filename = "outputs/msft_acf_season_diff.jpg"
  , width    = 1200
  , height   = 900   
  , res      = 150
)

acf(diff_season, lag.max = 24, main = "ACF of Seasonal Difference")

dev.off()


# 4. PACF of Seasonally Differenced Data ---------------------------------------

jpeg(
  filename = "outputs/msft_pacf_season_diff.jpg"
  , width    = 1200
  , height   = 900   
  , res      = 150
)

pacf(diff_season, lag.max = 24, main = "PACF of Seasonal Difference")

dev.off()
