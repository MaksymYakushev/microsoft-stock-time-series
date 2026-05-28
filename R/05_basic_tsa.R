# =============================================================================
# Project: Microsoft Stock Analysis
# Author:  Maksym Yakushev
# Date:    2026-05-28
# Description: Basic time series analysis of Microsoft stock data
# =============================================================================


# 1. Data Loading -------------------------------------------------------------

msft_ts <- readRDS("data/processed/msft_ts.rds")


# 2. Time Series Decomposition ------------------------------------------------

decomp <- stl(
    msft_ts
    , s.window = "periodic"
)

jpeg(
  filename = "outputs/msft_trend.jpg"
  , width    = 1200
  , height   = 650
  , res      = 150
)

plot(
    decomp$time.series[, "trend"]
    , type = "l"
    , main = "Trend Microsoft Stock Price"
    , ylab = "Closing Price"
    , xlab = "Date"
    , xaxt = "n"
)

year_positions <- seq(2015, 2021, by = 1)
axis(1, at = year_positions, labels = year_positions)

dev.off()


# 3. Plotting the Decomposition ------------------------------------------------

jpeg(
  filename = "outputs/msft_stl.jpg"
  , width = 1200
  , height = 900
  , res = 150
)

plot(decomp, main = "STL Microsoft Stock Price")

dev.off()


# 4. Rolling Standard Deviation ------------------------------------------------

library(zoo)

rolling_sd <- rollapply(
    stock$Close
    , width = 63
    , FUN = sd
    , fill = NA
)

jpeg(
  filename = "outputs/msft_rolling_sd.jpg"
  , width    = 1200
  , height   = 900
  , res      = 150
)

plot(
    stock$Date
    , rolling_sd
    , type = "l"
    , col = "purple"
    , lwd = 2
    , main = "Rolling Standard Deviation of Microsoft Stock"
    , xlab = "Date"
    , ylab = "SD (63 days)"
)

dev.off()


# 5. Stationarity Tests -------------------------------------------------------

library(tseries)

print(adf.test(msft_ts))
print(kpss.test(msft_ts))


# 6. Autocorrelation Analysis --------------------------------------------------

jpeg(
  filename = "outputs/msft_acf.jpg"
  , width = 1200
  , height = 900
  , res = 150
)

acf(msft_ts, lag.max = 24, main = "ACF")

dev.off()


# 7. Partial Autocorrelation Analysis ------------------------------------------

jpeg(
  filename = "outputs/msft_pacf.jpg"
  , width = 1200
  , height = 900
  , res = 150
)

pacf(msft_ts, lag.max = 24, main = "PACF")

dev.off()
