best <- function(state, prob){
  if(prob == "heart attack"){
    outcome <- as.numeric(11)
  } else if(prob == "heart failure"){
    outcome <- as.numeric(17)
  } else if(prob == "pneumonia"){
    outcome <- as.numeric(23)
  } else {
    stop("invalid outcome")
  }
  odata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  if((state %in% odata$state)){ stop("invalid state") }
  sp <- split(odata, odata$State)
  stateData <- data.frame(sp[state])
  best <- stateData[order(as.numeric(stateData[, outcome])), ][, c(2,outcome)][,1][1]
  ##best <- tapply(stateData[, 2], as.numeric(stateData[, outcome]), function(x) { m <- min(x, na.rm = TRUE)})[[1]]
  ##best <- tapply(stateData[, 2], as.numeric(stateData[, 17]), function(x) { sort(x) })
  best
}