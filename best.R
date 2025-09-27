best <- function(state,outcome) {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome is valid
  outcome_cols <- c(
    "heart attack" = 11,  # Hospital 30-Day Death (Mortality) Rates from Heart Attack
    "heart failure" = 17, # Hospital 30-Day Death (Mortality) Rates from Heart Failure
    "pneumonia"    = 23   # Hospital 30-Day Death (Mortality) Rates from Pneumonia
  )
  
  if (!outcome %in% names(outcome_cols)) stop("invalid outcome")
  if (!state %in% data$State) stop("invalid state")
  
  ## Return hospital name in that state with lowest 30-day death rate
  # Index of specified outcome
  col_idx <- outcome_cols[[outcome]]
  
  # Need it as a name for the c() below to work
  col_name <- names(data)[col_idx]
  
  # Filter based on state
  df <- data[data$State == state, c("Hospital.Name", "State", col_name)]
  names(df)[3] <- "Rate"
  
  ## Coerce the outcome column to numeric; drop NAs (hospitals with no data)
  suppressWarnings(df$Rate <- as.numeric(df$Rate))
  df <- df[!is.na(df$Rate), ]
  
  ## Order by (Rate ascending), then (Hospital.Name ascending) to break ties
  ord <- order(df$Rate, df$Hospital.Name)
  df$Hospital.Name[ord][1]
}