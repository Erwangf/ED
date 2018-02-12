
# World development indicators

indicatorFolder <- "../../data_raw/world development indicators/"
filePaths <- list.files(indicatorFolder)

indicatorTypes <- sapply(filePaths,function(p){substr(p,1,nchar(p)-4)},USE.NAMES = FALSE)

# install.packages("RPostgreSQL")
library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, user='postgres', password='admin123', dbname='postgres', host='127.0.0.1')



# indicatorsDF$Value.Footnotes = NULL
cat("Loading indicators...")
pb <- txtProgressBar(min=0,max=length(filePaths), initial=0,style=3)
for( i in 1:length(filePaths)){
  setTxtProgressBar(pb,i)
  tmpData <- read.table(paste(indicatorFolder,filePaths[i],sep = ""), header=T, quote="\"", sep=";",fill = T)[,1:3]
  tableName <- indicatorTypes[i]
  
  # Drop table if it already exists
  if (dbExistsTable(con, tableName)) dbRemoveTable(con, tableName)
  
  dbWriteTable(con, name = tableName, value = tmpData, row.names = FALSE)
}
cat("Finished import : ")
cat(paste(indicatorTypes),sep="\n")
cat("End of programm.")