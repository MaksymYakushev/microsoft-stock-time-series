# =============================================================================
# Project: Microsoft Stock Analysis
# Author:  Maksym Yakushev
# Date:    2026-06-02
# Description: Auto ARIMA Model for Microsoft Stock Analysis
# =============================================================================

# 1. Data Loading -------------------------------------------------------------

msft_ts <- readRDS("data/processed/msft_ts.rds")


# 2. Auto ARIMA Model ---------------------------------------------------------

library(forecast)

auto_model <- auto.arima(
  msft_ts
  , start.p = 7
  , start.q = 4
  , max.p = 10
  , max.q = 10
  , max.order = 15
  , d = 1
  , seasonal = FALSE
  , stepwise = FALSE
  , approximation = FALSE
)

auto.order <- arimaorder(auto_model)

cat(
    "\n## Best ARIMA model: ("
    , auto.order[1], ","
    , auto.order[2], ","
    , auto.order[3]
    , ") with AIC ="
    , auto_model$aic
    , "\n"
)


# 3. Auto ARIMA Model Plotting -----------------------------------------------

jpeg(
  filename = "outputs/msft_auto_arima_residuals.jpg"
  , width    = 1200
  , height   = 900   
  , res      = 150
)

plot.ts(
    auto_model$residuals
    , main = paste0(
        "ARIMA("
        , auto.order[1], ", "
        , auto.order[2], ", "
        , auto.order[3]
        , ") model"
    )
)

dev.off()


# 4. Ljung-Box Test for Residuals ----------------------------------------------

print(
    Box.test(
        auto_model$residuals
        , lag=log(length(auto_model$residuals))
        , type="Ljung-Box"
    )
)


# 5. Coefficients of the Auto ARIMA Model --------------------------------------

print(auto_model$coef)


# 6. Variance of the Auto ARIMA Model ------------------------------------------

print(auto_model$sigma2)