rankall <- function(outcome, num = "best") {
  ## Read data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Map outcomes to column indices in the CSV
  outcome_cols <- c(
    "heart attack" = 11,
    "heart failure" = 17,
    "pneumonia"    = 23
  )
  
  ## Validate outcome
  if (!outcome %in% names(outcome_cols)) stop("invalid outcome")
  
  col_idx  <- outcome_cols[[outcome]]
  col_name <- names(data)[col_idx]
  
  ## Keep only needed columns; coerce outcome to numeric
  df <- data[, c("Hospital.Name", "State", col_name)]
  names(df) <- c("Hospital", "State", "Rate")
  suppressWarnings(df$Rate <- as.numeric(df$Rate))
  
  ## Drop rows with missing rate
  df <- df[!is.na(df$Rate), ]
  
  ## Helper to pick a rank index given num
  pick_rank <- function(n, num) {
    if (identical(num, "best")) return(1L)
    if (identical(num, "worst")) return(n)
    # accept numeric or numeric-like character
    r <- suppressWarnings(as.integer(num))
    if (is.na(r)) return(NA_integer_)
    r
  }
  
  ## For each state: order by (Rate, Hospital), pick requested row
  states <- sort(unique(data$State))  # include all states, even if no valid rows -> NA
  result <- lapply(states, function(st) {
    s <- df[df$State == st, c("Hospital", "Rate")]
    if (nrow(s) == 0L) return(c(hospital = NA_character_, state = st))
    s <- s[order(s$Rate, s$Hospital), , drop = FALSE]
    r <- pick_rank(nrow(s), num)
    if (is.na(r) || r < 1L || r > nrow(s)) {
      c(hospital = NA_character_, state = st)
    } else {
      c(hospital = s$Hospital[r], state = st)
    }
  })
  
  out <- do.call(rbind, result)
  rownames(out) <- NULL
  as.data.frame(out, stringsAsFactors = FALSE)
}