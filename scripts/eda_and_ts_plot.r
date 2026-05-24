# =============================================================================
# Project: Microsoft Stock Analysis
# Author:Maksym Yakushev
# Date: 2026-05-24
# Description: Data loading and initial processing of Microsoft stock data
# =============================================================================


# 1. Data Loading -------------------------------------------------------------
stock <- readRDS("data/processed/msft.rds")


# 2. Data Inspection -----------------------------------------------------------

print(head(stock))


# 3. Data Summary --------------------------------------------------------------

str(stock)


# 4. Time Series Plot ----------------------------------------------------------

msft_ts <- ts(
    stock$Close
    , frequency = 252
    , start = c(2015, 1)
)

jpeg(
  filename = "outputs/msft_time_series.jpg"
  , width    = 1200
  , height   = 650
  , res      = 150
)

plot(
    msft_ts, type = "l" # nolint
    , main = "Microsoft Stock Price Over Time"
    , ylab = "Closing Price"
    , xlab = "Date"
    , xaxt = "n"
)

time_values <- time(msft_ts)
year_positions <- seq(2015, 2021, by = 1)
axis(1, at = year_positions, labels = year_positions)

dev.off()

