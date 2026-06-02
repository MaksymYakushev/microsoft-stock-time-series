# =============================================================================
# Project: Microsoft Stock Analysis
# Author:  Maksym Yakushev
# Date:    2026-06-02
# Description: ARIMA Model for Microsoft Stock Analysis
# =============================================================================

# 1. Data Loading -------------------------------------------------------------

msft_ts <- readRDS("data/processed/msft_ts.rds")


# 2. ARIMA Model Selection -----------------------------------------------------

library(forecast)

best.aic <- Inf
best.model <- NULL
best.order <- c(0, 1, 0)

for (p in 0:10) {

  for (q in 0:10) {

    model_try <- tryCatch(
      {
        suppressWarnings(
          arima(
            msft_ts
            , order = c(p, 1, q)
          )
        )
      }
      , error = function(e) NULL
    )

    if (!is.null(model_try)) {

      if (model_try$aic < best.aic) {

        best.aic <- model_try$aic
        best.model <- model_try
        best.order <- c(p, 1, q)
      }
    }
  }
}

cat(
  "\nBest ARIMA model: ("
  , best.order[1], ","
  , best.order[2], ","
  , best.order[3]
  , ") with AIC ="
  , best.aic
  , "\n"
)


# 3. The Best ARIMA Model Plotting ---------------------------------------------

best.model <- arima(
  msft_ts
  , order=c(
    best.order[1]
    , best.order[2]
    , best.order[3]
  )
)

jpeg(
  filename = "outputs/msft_arima_residuals.jpg"
  , width    = 1200
  , height   = 900   
  , res      = 150
)

plot.ts(
  best.model$residuals
  , main = paste0(
    "ARIMA("
    , best.order[1], ", "
    , best.order[2], ", "
    , best.order[3]
    , ") model"
    )
)

dev.off()


# 4. Ljung-Box Test for Residuals ----------------------------------------------

print(
  Box.test(
    best.model$residuals
    , lag=log(length(best.model$residuals))
    , type="Ljung-Box"
  )
)

# 5. Coefficients of the Best ARIMA Model --------------------------------------

print(best.model$coef)


# 6. Variance of the Best ARIMA Model ------------------------------------------

print(best.model$sigma2)
