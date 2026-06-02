# =============================================================================
# Project: Microsoft Stock Analysis
# Author:  Maksym Yakushev
# Date:    2026-06-02
# Description: Auto ARIMA Forecasting for Microsoft Stock Analysis
# =============================================================================

# 1. Data Loading -------------------------------------------------------------

msft_ts <- readRDS("data/processed/msft_ts.rds")


# 2. Auto ARIMA Forecasting ---------------------------------------------------

n <- length(msft_ts)
test_size <- ceiling(0.1 * n)
train_size <- n - test_size

train <- window(msft_ts, end = c(time(msft_ts)[train_size]))
test <- window(msft_ts, start = c(time(msft_ts)[train_size + 1]))

model_auto_arima_model <- suppressWarnings(
    arima(
        train
        , order=c(5, 1, 8)
        , method = "ML"
    )
)


# 3. Residual Analysis of Auto ARIMA Model --------------------------------

print(
    Box.test(
        model_auto_arima_model$residuals
        , lag=log(length(model_auto_arima_model$residuals))
        , type="Ljung-Box"
    )
)


# 4. Train and Test Lengths ----------------------------------------------------

cat("Train length:", length(train), "\n")

cat("Test length:", length(test), "\n")


# 5. Forecasting with the Auto ARIMA Model -------------------------------------

forecast_auto_arima_model <- forecast(model_auto_arima_model, h = length(test))

jpeg(
  filename = "outputs/msft_auto_arima_forecast.jpg"
  , width    = 1200
  , height   = 900   
  , res      = 150
)

plot(forecast_auto_arima_model, main="Forecast Auto ARIMA(5,1,8)")
lines(test, col = "red")

dev.off()


# 6. Accuracy of the Forecasting Model -----------------------------------------

print(accuracy(forecast_auto_arima_model, test))