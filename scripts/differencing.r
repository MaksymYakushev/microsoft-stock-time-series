# =============================================================================
# Project: Microsoft Stock Analysis
# Author:  Maksym Yakushev
# Date:    2026-05-24
# Description: Differencing the Microsoft stock time series and analyzing the results
# =============================================================================


# 1. Data Loading -------------------------------------------------------------

stock <- readRDS("data/processed/msft.rds")


# 2. Differencing the Time Series ----------------------------------------------

diff_data <- diff(msft_ts) 

jpeg(
  filename = "outputs/msft_diff.jpg"
  , width    = 1200
  , height   = 900
  , res      = 150
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


# 3. Stationarity Tests on Differenced Data -----------------------------------

print(adf.test(diff_data))
print(kpss.test(diff_data))


# 4. ACF of Differenced Data --------------------------------------------------

jpeg(
  filename = "outputs/msft_acf_diff.jpg"
  , width = 1200
  , height = 900
  , res = 150
)

acf(diff_data, lag.max = 24, main = "ACF after first diff")

dev.off()


# 5. PACF of Differenced Data -------------------------------------------------

jpeg(
  filename = "outputs/msft_pacf_diff.jpg"
  , width = 1200
  , height = 900   
  , res = 150
)

pacf(diff_data, lag.max = 24, main = "PACF after first diff")

dev.off()

