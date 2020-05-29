corr <- function(directory, threshold = 0) {
  v <- vector()
  myfiles = list.files(path=directory, pattern="*.csv", full.names=TRUE)
  for(i in myfiles){
    t <- read.csv(i)
    cc <- complete.cases(t)
    all <- length(t[cc,][[1]])
    if(all > threshold){
      v[i] <- cor(t["sulfate"], t["nitrate"], use="complete.obs")
    }
  }
  data.frame(v)
}