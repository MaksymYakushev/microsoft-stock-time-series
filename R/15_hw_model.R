# =============================================================================
# Project: Microsoft Stock Analysis
# Author:  Maksym Yakushev
# Date:    2026-06-03
# Description: Holt-Winters Additive Model Forecasting for Microsoft Stock 
# Analysis
# =============================================================================

# 1. Data Loading -------------------------------------------------------------

msft_ts_monthly <- readRDS("data/processed/msft_ts_monthly.rds")

# 2. Holt-Winters Additive Model ----------------------------------------------

library(forecast)

hw_additive_model <- hw(msft_ts_monthly, seasonal = "additive")
print(hw_additive_model$model)


# 3. Holt-Winters Additive Model Forecasting ----------------------------------

n <- length(msft_ts_monthly)
test_size <- ceiling(0.1 * n)
train_size <- n - test_size

train <- subset(msft_ts_monthly, end = train_size)
test <- subset(msft_ts_monthly, start = train_size + 1)

hw_add_train <- hw(train, seasonal = "additive")


# 4. Plotting the Forecast -----------------------------------------------------

library(ggplot2)

fc_hw_add <- forecast(hw_add_train, h = test_size)

p <- autoplot(train) +
  autolayer(test, series = "Test Data") +
  autolayer(fc_hw_add, series = "Forecast", PI = TRUE) +
  ggtitle("Holt-Winters Additive Forecast") +
  ylab("Closing Price") +
  xlab("Time")

jpeg(
  filename = "outputs/msft_hw_additive_forecast.jpg",
  width = 1200,
  height = 900,
  res = 150
)

print(p)

dev.off()


# 5. Accuracy Metrics ----------------------------------------------------------

print(accuracy(fc_hw_add, test))