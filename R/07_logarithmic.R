# =============================================================================
# Project: Microsoft Stock Analysis
# Author:  Maksym Yakushev
# Date:    2026-05-28
# Description: Basic time series analysis of Microsoft stock data
# =============================================================================


# 1. Data Loading -------------------------------------------------------------

msft_ts <- readRDS("data/processed/msft_ts.rds")


# 2. Logarithmic Transformation -----------------------------------------------

jpeg(
  filename = "outputs/msft_log.jpg"
  , width    = 1200
  , height   = 900   
  , res      = 150
)

log_data <- log(msft_ts)
plot(log_data, main = "Log-transformed Microsoft Close")

dev.off()


# 3. ACF of Log-transformed Data ----------------------------------------------

jpeg(
  filename = "outputs/msft_log_acf.jpg"
  , width    = 1200
  , height   = 900   
  , res      = 150
)

acf(log_data, lag.max = 24, main = "ACF")

dev.off()

# 4. PACF of Log-transformed Data --------------------------------------------

jpeg(
  filename = "outputs/msft_log_pacf.jpg"
  , width    = 1200
  , height   = 900   
  , res      = 150
)

pacf(log_data, lag.max = 24, main = "PACF")

dev.off()
