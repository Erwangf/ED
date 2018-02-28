
# World development indicators

indicatorFolder <- "../../data_raw/world development indicators/"
filePaths <- list.files(indicatorFolder)

indicatorTypes <- sapply(filePaths,function(p){substr(p,1,nchar(p)-4)},USE.NAMES = FALSE)

# install.packages("RPostgreSQL")
library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, user='postgres', password='admin123', dbname='postgres', host='127.0.0.1')

df <- data.frame(area=character(),year=numeric())
df$area = as.character(df$area)
for(id in indicatorTypes){
  df[id] = numeric()
}


# indicatorsDF$Value.Footnotes = NULL
cat("Loading indicators...")
pb <- txtProgressBar(min=0,max=length(filePaths), initial=0,style=3)
for( i in 1:length(filePaths)){
  setTxtProgressBar(pb,i)
  tmpData <- read.table(paste(indicatorFolder,filePaths[i],sep = ""), header=T, quote="\"", sep=";",fill = T)[,1:3]
  tmpData$Country.or.Area <-  as.character(tmpData$Country.or.Area)
  if(class(tmpData$Year)=="factor"){
    tmpData$Year <-  as.numeric(levels(tmpData$Year)[as.numeric(tmpData$Year)])
  }
  
  
  tableName <- indicatorTypes[i]
  
  for(j in 1:nrow(tmpData)){
    line = tmpData[j,]
    
    if(nrow(df[df$area==line[,1] & df$year==line[,2],])==0){
      df[nrow(df)+1,] <- c(area=line[,1],year=line[,2], NA, NA, NA, NA, NA, NA, NA, NA, NA)
    }
    if(is.na(line[,3]) || !is.numeric(line[,3])){
      print(line)
    } else {
      df[df$area==line[,1] & df$year==line[,2],i+2] <- line[,3]
    }
    
  }
  

}

for(id in indicatorTypes){
  df[id] = as.numeric(df[id][,1])
}

df$year <- as.numeric(df$year)

# Drop table if it already exists
if (dbExistsTable(con, "wdi")) dbRemoveTable(con, "wdi")

dbWriteTable(con, name = "wdi", value = df, row.names = FALSE)

cat("Finished import : ")
cat(paste(indicatorTypes),sep="\n")
cat("End of programm.")