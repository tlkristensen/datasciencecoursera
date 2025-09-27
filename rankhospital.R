rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Map outcome -> column index
  outcome_cols <- c(
    "heart attack" = 11,
    "heart failure" = 17,
    "pneumonia"    = 23
  )
  
  ## Validate inputs
  if (!state %in% data$State) stop("invalid state")
  if (!outcome %in% names(outcome_cols)) stop("invalid outcome")
  
  ## Extract relevant data for state + outcome
  col_idx <- outcome_cols[[outcome]]
  col_name <- names(data)[col_idx]
  
  df <- data[data$State == state, c("Hospital.Name", col_name)]
  names(df) <- c("Hospital", "Rate")
  
  suppressWarnings(df$Rate <- as.numeric(df$Rate))
  df <- df[!is.na(df$Rate), ]
  
  ## Order by Rate, then Hospital name (alphabetical tiebreaker)
  df <- df[order(df$Rate, df$Hospital), ]
  
  ## Determine rank
  if (num == "best") {
    rank <- 1
  } else if (num == "worst") {
    rank <- nrow(df)
  } else if (is.numeric(num)) {
    rank <- num
  } else {
    stop("invalid num")
  }
  
  ## Return hospital name or NA if rank > available hospitals
  if (rank > nrow(df)) {
    return(NA)
  } else {
    return(df$Hospital[rank])
  }
}
