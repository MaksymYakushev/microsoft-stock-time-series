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