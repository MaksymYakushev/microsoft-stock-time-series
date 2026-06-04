# =============================================================================
# Project: Microsoft Stock Analysis
# Author:  Maksym Yakushev
# Date:    2026-06-04
# Description: ETS Models Forecasting for Microsoft Stock Analysis
# =============================================================================

# 1. Data Loading -------------------------------------------------------------

msft_ts_monthly <- readRDS("data/processed/msft_ts_monthly.rds")


# 2. ETS Models ----------------------------------------

library(forecast)

# ETS AAA Model
ets_aaa_model <- ets(msft_ts_monthly, model = "AAA")
ets_aaa_model$par 
ets_aaa_model$sigma2

# ETS AAA Damped Model
ets_aa_da_model <- ets(msft_ts_monthly, model = "AAA", damped = TRUE)
ets_aa_da_model$par 
ets_aa_da_model$sigma2

# ETS MAA Model
ets_maa_model <- ets(msft_ts_monthly, model = "MAA")
ets_maa_model$par 
ets_maa_model$sigma2

# ETS MAA Damped Model
ets_ma_da_model <- ets(msft_ts_monthly, model = "MAA", damped = TRUE)
ets_ma_da_model$par 
ets_ma_da_model$sigma2

# ETS MAM Model
ets_mam_model <- ets(msft_ts_monthly, model = "MAM")
ets_mam_model$par 
ets_mam_model$sigma2

# ETS MA DM Model
ets_ma_dm_model <- ets(msft_ts_monthly, model = "MAM", damped = TRUE)
ets_ma_dm_model$par 
ets_ma_dm_model$sigma2

# ETS Auto Model
ets_auto <- ets(msft_ts_monthly)
ets_auto$par 
ets_auto$sigma2


# 3. ETS Models Forecasting ---------------------------------------------------

n <- length(msft_ts_monthly)
test_size <- ceiling(0.1 * n)
train_size <- n - test_size

train <- subset(msft_ts_monthly, end = train_size)
test <- subset(msft_ts_monthly, start = train_size + 1)

ets_aaa_train <- ets(train, model = "AAA")
ets_aa_da_train <- ets(train, model = "AAA", damped = TRUE)
ets_maa_train <- ets(train, model = "MAA")
ets_ma_da_train <- ets(train, model = "MAA", damped = TRUE)
ets_mam_train <- ets(train, model = "MAM")
ets_ma_dm_train <- ets(train, model = "MAM", damped = TRUE)
ets_auto_train <- ets(train)


# 4. Accuracy Metrics ----------------------------------------------------------

print(accuracy(ets_aaa_model))
print(accuracy(ets_aa_da_model))
print(accuracy(ets_maa_model))
print(accuracy(ets_ma_da_model))
print(accuracy(ets_mam_model))
print(accuracy(ets_ma_dm_model))
print(accuracy(ets_auto))


# 5. Plotting the Forecast -----------------------------------------------------

# ETS AAA Model
fc_ets_aaa <- forecast(ets_aaa_train, h = test_size)

p <- autoplot(train) +
  autolayer(test, series = "Test Data") +
  autolayer(fc_ets_aaa, series = "Forecast", PI = TRUE) +
  ggtitle("ETS AAA Forecast") +
  ylab("Closing Price") +
  xlab("Time")

jpeg(
  filename = "outputs/msft_ets_aaa_forecast.jpg",
  width = 1200,
  height = 900,
  res = 150
)

print(p)

dev.off()

# ETS AAA Damped Model
fc_ets_aa_da <- forecast(ets_aa_da_train, h = test_size)

p <- autoplot(train) +
  autolayer(test, series = "Test Data") +
  autolayer(fc_ets_aa_da, series = "Forecast", PI = TRUE) +
  ggtitle("ETS AAA Damped Forecast") +
  ylab("Closing Price") +
  xlab("Time")

jpeg(
  filename = "outputs/msft_ets_aa_da_forecast.jpg",
  width = 1200,
  height = 900,
  res = 150
)

print(p)

dev.off()

# ETS MAA Model
fc_ets_maa <- forecast(ets_maa_train, h = test_size)

p <- autoplot(train) +
  autolayer(test, series = "Test Data") +
  autolayer(fc_ets_maa, series = "Forecast", PI = TRUE) +
  ggtitle("ETS MAA Forecast") +
  ylab("Closing Price") +
  xlab("Time")

jpeg(
  filename = "outputs/msft_ets_maa_forecast.jpg",
  width = 1200,
  height = 900,
  res = 150
)

print(p)

dev.off()

# ETS MAA Damped Model
fc_ets_ma_da <- forecast(ets_ma_da_train, h = test_size)

p <- autoplot(train) +
  autolayer(test, series = "Test Data") +
  autolayer(fc_ets_ma_da, series = "Forecast", PI = TRUE) +
  ggtitle("ETS MAA Damped Forecast") +
  ylab("Closing Price") +
  xlab("Time")

jpeg(
  filename = "outputs/msft_ets_ma_da_forecast.jpg",
  width = 1200,
  height = 900,
  res = 150
)

print(p)

dev.off()

# ETS MAM Model
fc_ets_mam <- forecast(ets_mam_train, h = test_size)

p <- autoplot(train) +
  autolayer(test, series = "Test Data") +
  autolayer(fc_ets_mam, series = "Forecast", PI = TRUE) +
  ggtitle("ETS MAM Forecast") +
  ylab("Closing Price") +
  xlab("Time")

jpeg(
  filename = "outputs/msft_ets_mam_forecast.jpg",
  width = 1200,
  height = 900,
  res = 150
)       

print(p)

dev.off()


# ETS MAM Damped Model
fc_ets_ma_dm <- forecast(ets_ma_dm_train, h = test_size)

p <- autoplot(train) +
  autolayer(test, series = "Test Data") +
  autolayer(fc_ets_ma_dm, series = "Forecast", PI = TRUE) +
  ggtitle("ETS MAM Damped Forecast") +
  ylab("Closing Price") +
  xlab("Time")

jpeg(
  filename = "outputs/msft_ets_ma_dm_forecast.jpg",
  width = 1200,
  height = 900,
  res = 150
)       

print(p)

dev.off()

# ETS Auto Model
fc_ets_auto <- forecast(ets_auto_train, h = test_size)

p <- autoplot(train) +
  autolayer(test, series = "Test Data") +
  autolayer(fc_ets_auto, series = "Forecast", PI = TRUE) +
  ggtitle("ETS Auto Forecast") +
  ylab("Closing Price") +
  xlab("Time")

jpeg(
  filename = "outputs/msft_ets_auto_forecast.jpg",
  width = 1200,
  height = 900,
  res = 150
)       

print(p)

dev.off()


# 6. Accuracy Metrics ----------------------------------------------------------

print(accuracy(fc_ets_aaa, test))
print(accuracy(fc_ets_aa_da, test))
print(accuracy(fc_ets_maa, test))
print(accuracy(fc_ets_ma_da, test))
print(accuracy(fc_ets_mam, test))
print(accuracy(fc_ets_ma_dm, test))
print(accuracy(fc_ets_auto, test))