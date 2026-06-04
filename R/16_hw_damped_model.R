# =============================================================================
# Project: Microsoft Stock Analysis
# Author:  Maksym Yakushev
# Date:    2026-06-04
# Description: Holt-Winters Additive Damped Model Forecasting for Microsoft 
#Stock Analysis
# =============================================================================

# 1. Data Loading -------------------------------------------------------------

msft_ts_monthly <- readRDS("data/processed/msft_ts_monthly.rds")

# 2. Holt-Winters Additive Damped Model ----------------------------------------


library(forecast)

hw_add_damped_model <- hw(msft_ts_monthly, seasonal = "additive", damped = TRUE)
hw_add_damped_model$model


# 3. Holt-Winters Additive Damped Model Forecasting ----------------------------

n <- length(msft_ts_monthly)
test_size <- ceiling(0.1 * n)
train_size <- n - test_size

train <- subset(msft_ts_monthly, end = train_size)
test <- subset(msft_ts_monthly, start = train_size + 1)

hw_add_damped_train <- hw(train, seasonal = "additive", damped = TRUE)


# 4. Accuracy Metrics ----------------------------------------------------------

print(accuracy(hw_add_damped_model))


# 5. Plotting the Forecast -----------------------------------------------------

library(ggplot2)

fc_hw_add_damp  <- forecast(hw_add_damped_train, h = test_size)

p <- autoplot(train) +
  autolayer(test, series = "Test Data") +
  autolayer(fc_hw_add_damp, series = "Forecast", PI = TRUE) +
  ggtitle("Holt-Winters Additive Damped Forecast") +
  ylab("Closing Price") +
  xlab("Time")

jpeg(
  filename = "outputs/msft_hw_additive_damped_forecast.jpg",
  width = 1200,
  height = 900,
  res = 150
)

print(p)

dev.off()


# 6. Accuracy Metrics ----------------------------------------------------------

print(accuracy(fc_hw_add_damp, test))


# 7. Plotting Original and Fitted Values ---------------------------------------

p <- autoplot(msft_ts_monthly, series = "Original Series") +
  autolayer(fitted(hw_add_damped_model), series = "Fitted Value") +
  ggtitle("Original and Fitted Time Series - Holt-Winters Additive Damped") +
  ylab("Closing Price") + xlab("Time")

jpeg(
  filename = "outputs/msft_hw_additive_damped_fitted.jpg",
  width = 1200,
  height = 900,
  res = 150
)

print(p)

dev.off()