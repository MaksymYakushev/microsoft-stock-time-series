# =============================================================================
# Project: Microsoft Stock Analysis
# Author:  Maksym Yakushev
# Date:    2026-05-22
# Description: Basic time series analysis of Microsoft stock data
# =============================================================================


# 1. Data Loading -------------------------------------------------------------
stock <- read.csv(
    "data/raw/microsoft_stock.csv"
    , header = TRUE
    , sep = ","
    , stringsAsFactors = FALSE
)


# 2. Initial Data Processing --------------------------------------------------

# Convert the 'Date' column to Date format
stock$Date <- as.Date(
    stock$Date
    , tryFormats = c("%Y-%m-%d", "%m/%d/%Y", "%d.%m.%Y"))

msft_ts <- ts(
    stock$Close
    , frequency = 252
    , start = c(2015, 1)
)


# 3. Time Series Decomposition ------------------------------------------------

decomp <- stl(
    msft_ts
    , s.window = "periodic"
)

jpeg(
  filename = "outputs/msft_trend.jpg",
  width    = 1200,
  height   = 650,
  res      = 150
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


# 4. Plotting the Decomposition ------------------------------------------------

jpeg(
  filename = "outputs/msft_stl.jpg",
  width    = 1200,
  height   = 900,
  res      = 150
)

plot(decomp, main = "STL Microsoft Stock Price")

dev.off()


# 5. Rolling Standard Deviation ------------------------------------------------

library(zoo)

rolling_sd <- rollapply(
    stock$Close
    , width = 63
    , FUN = sd
    , fill = NA
)

jpeg(
  filename = "outputs/msft_rolling_sd.jpg",
  width    = 1200,
  height   = 900,
  res      = 150
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


# 6. Stationarity Tests -------------------------------------------------------

library(tseries)

print(adf.test(msft_ts))
print(kpss.test(msft_ts))


# 7. Autocorrelation Analysis --------------------------------------------------

jpeg(
  filename = "outputs/msft_acf.jpg",
  width    = 1200,
  height   = 900,
  res      = 150
)

acf(msft_ts,lag.max = 24, main = "ACF")

dev.off()


# 8. Partial Autocorrelation Analysis ------------------------------------------

jpeg(
  filename = "outputs/msft_pacf.jpg",
  width    = 1200,
  height   = 900,
  res      = 150
)

pacf(msft_ts, lag.max = 24, main = "PACF")

dev.off()


# 9. Differencing the Time Series ----------------------------------------------

diff_data <- diff(msft_ts) 

jpeg(
  filename = "outputs/msft_diff.jpg",
  width    = 1200,
  height   = 900,
  res      = 150
)

plot(
    diff_data
    , type = "l"
    , col = "blue"
    , lwd = 1.5
    , main = "(diff) of Microsoft Close"
    , ylab = "diff(Close)", xlab = "Date"
)

dev.off()


# 10. Stationarity Tests on Differenced Data -----------------------------------

print(adf.test(diff_data))
print(kpss.test(diff_data))


# 11. ACF of Differenced Data --------------------------------------------------

jpeg(
  filename = "outputs/msft_acf_diff.jpg",
  width    = 1200,
  height   = 900,
  res      = 150
)

acf(diff_data, lag.max = 24, main = "ACF after first diff")

dev.off()


# 12. PACF of Differenced Data -------------------------------------------------

jpeg(
  filename = "outputs/msft_pacf_diff.jpg"
  , width    = 1200
  , height   = 900   
  , res      = 150
)

pacf(diff_data, lag.max = 24, main = "PACF after first diff")

dev.off()


# 13. Log Transformation -------------------------------------------------------

jpeg(
  filename = "outputs/msft_log.jpg"
  , width    = 1200
  , height   = 900   
  , res      = 150
)

log_data <- log(msft_ts)
plot(log_data, main = "Log-transformed Microsoft Close")

dev.off()

# 14. ACF of Log-transformed Data --------------------------------------------------

jpeg(
  filename = "outputs/msft_log_acf.jpg"
  , width    = 1200
  , height   = 900   
  , res      = 150
)

acf(log_data, lag.max = 24, main = "ACF")

dev.off()