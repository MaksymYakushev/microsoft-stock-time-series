# =============================================================================
# Project: Microsoft Stock Analysis
# Author:Maksym Yakushev
# Date: 2026-05-28
# Description: Clean Microsoft stock data by converting date formats 
#and sorting by date,
# =========================================================================


stock <- readRDS("data/interim/msft_raw.rds")

stock$Date <- as.Date(
  stock$Date,
  tryFormats = c("%Y-%m-%d", "%m/%d/%Y", "%d.%m.%Y")
)

stock <- stock[order(stock$Date), ]

saveRDS(stock, "data/processed/msft_clean.rds")
