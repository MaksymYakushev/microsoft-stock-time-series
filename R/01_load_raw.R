# =============================================================================
# Project: Microsoft Stock Analysis
# Author:Maksym Yakushev
# Date: 2026-05-28
# Description: Load raw Microsoft stock data and save it in RDS format for 
#further processing
# =============================================================================


stock <- read.csv(
  "data/raw/microsoft_stock.csv"
  , header = TRUE
  , sep = ","
  , stringsAsFactors = FALSE
)

saveRDS(stock, "data/interim/msft_raw.rds")
