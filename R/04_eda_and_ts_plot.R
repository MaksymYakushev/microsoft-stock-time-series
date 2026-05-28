# =============================================================================
# Project: Microsoft Stock Analysis
# Author:Maksym Yakushev
# Date: 2026-05-28
# Description: Exploratory data analysis and time series plotting for Microsoft 
#stock data
# =============================================================================


# 1. Data Loading -------------------------------------------------------------

msft_ts <- readRDS("data/processed/msft_ts.rds")


# 2. Data Summary --------------------------------------------------------------

summary(msft_ts)


# 3. Time Series Plot ----------------------------------------------------------

jpeg(
  filename = "outputs/msft_time_series.jpg"
  , width    = 1200
  , height   = 650
  , res      = 150
)

plot(
    msft_ts
    , type = "l" 
    , main = "Microsoft Stock Price Over Time"
    , ylab = "Closing Price"
    , xlab = "Date"
    , xaxt = "n"
)

time_values <- time(msft_ts)
year_positions <- seq(2015, 2021, by = 1)
axis(1, at = year_positions, labels = year_positions)

dev.off()
