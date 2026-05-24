# =============================================================================
# Project: Microsoft Stock Analysis
# Author:Maksym Yakushev
# Date: 2026-05-24
# Description: Data loading and preparing
# =============================================================================


stock <- read.csv(
  "data/raw/microsoft_stock.csv"
  , header = TRUE
  , sep = ","
  , stringsAsFactors = FALSE
)

stock$Date <- as.Date(
  stock$Date
  , tryFormats = c("%Y-%m-%d", "%m/%d/%Y", "%d.%m.%Y")
)

saveRDS(stock, "data/processed/msft.rds")