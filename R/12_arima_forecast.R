# =============================================================================
# Project: Microsoft Stock Analysis
# Author:  Maksym Yakushev
# Date:    2026-06-02
# Description: ARIMA Forecasting for Microsoft Stock Analysis
# =============================================================================

# 1. Data Loading -------------------------------------------------------------

msft_ts <- readRDS("data/processed/msft_ts.rds")


# 2. ARIMA Forecasting ---------------------------------------------------------

n <- length(msft_ts)
test_size <- ceiling(0.1 * n)
train_size <- n - test_size

train <- window(msft_ts, end = c(time(msft_ts)[train_size]))
test <- window(msft_ts, start = c(time(msft_ts)[train_size + 1]))

model_best_arima_model <- suppressWarnings(
    arima(
        train
        , order=c(10, 1, 6)
        , method = "ML"
    )
)


# 3. Residual Analysis of the Best ARIMA Model --------------------------------

print(
    Box.test(
        model_best_arima_model$residuals
        , lag=log(length(model_best_arima_model$residuals))
        , type="Ljung-Box"
    )
)


# 4. Train and Test Lengths ----------------------------------------------------

cat("Train length:", length(train), "\n")

cat("Test length:", length(test), "\n")


# 5. Forecasting with the Best ARIMA Model -------------------------------------

forecast_best_arima_model <- forecast(model_best_arima_model, h = length(test))

jpeg(
  filename = "outputs/msft_arima_forecast.jpg"
  , width    = 1200
  , height   = 900   
  , res      = 150
)

plot(forecast_best_arima_model, main="Forecast ARIMA(10,1,6)")
lines(test, col = "red")

dev.off()


# 6. Accuracy of the Forecasting Model -----------------------------------------

print(accuracy(forecast_best_arima_model, test))