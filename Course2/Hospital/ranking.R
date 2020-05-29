rankhospital <- function(state, prob, rank){
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
  res <- stateData[order(as.numeric(stateData[, outcome]), stateData[, 2]), ][, c(2,outcome)]
  res2 <- res[res[, 2] != 'Not Available', ][,1]
  if(rank == "best") res2[1]
  else if(rank == "worst") tail(res2, 1)[1]
  else res2[rank]
}