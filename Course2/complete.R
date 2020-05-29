complete <- function(directory, id = 1: 332) {
  df<- data.frame()
  vec1 <- vector()
  vec2 <- vector()
  myfiles = list.files(path=directory, pattern="*.csv", full.names=TRUE)
  for(i in id){
    t <- read.csv(myfiles[i])
    vec1[i] <- i
    cc <- complete.cases(t)
    all <- length(t[cc,][[1]])
    vec2[i] <- all
  }
  df <- data.frame(vec1, vec2)
  df[complete.cases(df),]
}