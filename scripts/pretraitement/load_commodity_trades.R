
# Commodity Trades

commodityFolder <- "../../data_raw/commodity trades/"
filePaths <- list.files(commodityFolder)

namesPath <- "../../data_raw/commodities.txt"
commodities <- readLines(namesPath)

commodityDF <- read.table(paste(commodityFolder,filePaths[1],sep = ""), header=T, quote="\"", sep=";",fill = T)
commodityDF$CommodityType = commodities[1]

pb <- txtProgressBar(min=0,max=length(filePaths), initial=0,style=3)
for( i in 2:length(filePaths)){
  setTxtProgressBar(pb,i)
  tmpData <- read.table(paste(commodityFolder,filePaths[i],sep = ""), header=T, quote="\"", sep=";",fill = T)
  tmpData$CommodityType = commodities[i]
  commodityDF <- rbind(commodityDF,tmpData)
}

commodityDF$CommodityType <- as.factor(commodityDF$CommodityType)

summary(commodityDF)

library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, user='postgres', password='admin123', dbname='postgres', host='127.0.0.1')

# Drop table if it already exists
if (dbExistsTable(con, "commodity")) dbRemoveTable(con, "commodity")

dbWriteTable(con, name = "commodity", value = commodityDF, row.names = FALSE)
