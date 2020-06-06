library(data.table)
library(ggplot2)

stormDT <- read.csv("repdata_data_StormData.csv")
stormDT <- as.data.table(stormDT)
