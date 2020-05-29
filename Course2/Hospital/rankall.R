rankall <- function(prob, rank = "best"){
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
  states <- odata$State
  hosp <- vector()
  for (i in sort(unique(states))) {
    hosp <- c(hosp, rankhospital(i, prob, rank))
  }
  data.frame(hosp, sort(unique(states)))
}