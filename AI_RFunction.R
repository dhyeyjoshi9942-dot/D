# AI Assistance Declaration: I used OpenAI ChatGPT (GPT-6) on 2026-10-31
# for task framing, initial code suggestions, comments, and test design.
# Prompts are reproduced below and in AI_Prompts_Appendix.md.
# Verification methods: run these tests in RStudio, independently cross-check
# quartiles/fences in a spreadsheet, and manually inspect edge cases.
# Final calculations must be performed and verified by the student.
# Student: Dhyeykumar Joshi | BDA400 Assignment 3
# TASK: Remove extreme values from a numeric vector using the 1.5*IQR rule,
# while handling missing values and reporting which observations were removed.

# INITIAL AI-SUGGESTED VERSION (illustrates limitations)
remove_outliers_initial <- function(x) {
  q <- quantile(x, c(0.25, 0.75))  # Compute first and third quartiles.
  iqr <- IQR(x)                    # Compute interquartile range.
  x[x >= q[1] - 1.5 * iqr & x <= q[2] + 1.5 * iqr] # Filter values.
}
# Limitation: missing values can make quantile/IQR fail; no input validation,
# and the result does not identify removed positions.

# FINAL REVISED VERSION: documented, validated, and traceable.
remove_outliers <- function(x, multiplier = 1.5, na_action = "omit") {
  if (!is.numeric(x) || !is.atomic(x)) stop("x must be a numeric vector")
  if (length(dim(x)) > 0L) stop("x must be one-dimensional")
  if (length(multiplier) != 1L || !is.numeric(multiplier) ||
      is.na(multiplier) || !is.finite(multiplier) || multiplier < 0)
    stop("multiplier must be a finite, nonnegative number")
  if (length(na_action) != 1L || is.na(na_action) ||
      !na_action %in% c("omit", "keep"))
    stop("na_action must be 'omit' or 'keep'")
  if (any(is.infinite(x))) stop("infinite values are not supported")
  valid <- !is.na(x)                      # Identify available observations.
  values <- x[valid]                      # Exclude NA for fence calculation.
  if (length(values) == 0L) stop("at least one nonmissing value is required")
  q <- stats::quantile(values, c(0.25, 0.75), names = FALSE) # Quartiles.
  spread <- q[2] - q[1]                  # Interquartile range.
  lower <- q[1] - multiplier * spread    # Lower Tukey fence.
  upper <- q[2] + multiplier * spread    # Upper Tukey fence.
  outlier <- valid & (x < lower | x > upper) # Flag outside observations.
  retained <- valid & !outlier           # Retain ordinary numeric values.
  if (na_action == "keep") retained <- retained | !valid # Optional NA retention.
  list(cleaned = x[retained],             # Filtered values in original order.
       removed_values = x[outlier],      # Numeric outliers only.
       removed_positions = which(outlier), # Original positions.
       lower_fence = unname(lower), upper_fence = unname(upper),
       q1 = unname(q[1]), q3 = unname(q[2]), iqr = unname(spread),
       missing_count = sum(!valid))      # Count missing entries.
}

# LINE-BY-LINE EXPLANATION OF THE REVISED FUNCTION:
# Signature: accepts a numeric vector, IQR multiplier, and NA policy.
# First three if statements: reject invalid data, dimensions, or multiplier.
# Fourth if statement: restrict NA policy to omit/keep.
# Fifth if statement: reject infinite observations.
# valid/values: separate missing and nonmissing observations.
# quantile/spread: calculate Q1, Q3, and IQR from available data.
# lower/upper: calculate the two 1.5*IQR decision boundaries.
# outlier: identify numeric observations strictly outside the boundaries.
# retained: select values inside boundaries in original order.
# na_action keep: optionally retain missing observations in output.
# list: return cleaned data, removed observations/positions, fences,
# quartiles, IQR, and missing-data count for reproducibility.

# TESTS: execute in RStudio. Stop on any unexpected outcome.
example <- c(10, 15, 999, 20, 25)
result <- remove_outliers(example)
print(result)
stopifnot(identical(as.numeric(result$cleaned), c(10, 15, 20, 25)))
stopifnot(identical(as.numeric(result$removed_values), 999))
stopifnot(identical(result$removed_positions, 3L))
# Cross-check against base R boxplot.stats() for the chosen example.
stopifnot(identical(as.numeric(boxplot.stats(example)$out), 999))
# Note: boxplot.stats() uses Tukey hinges, which may differ from quantile()
# quartiles for some small samples; agreement is not universal.

# Edge case: NA omitted by default, but can be preserved.
with_na <- c(10, NA, 15, 20, 25, 999)
stopifnot(identical(as.numeric(remove_outliers(with_na)$cleaned), c(10, 15, 20, 25)))
stopifnot(is.na(remove_outliers(with_na, na_action = "keep")$cleaned[2]))
# Edge case: identical values, IQR = 0, no outliers.
stopifnot(identical(as.numeric(remove_outliers(c(5, 5, 5))$cleaned), c(5, 5, 5)))
# Edge case: invalid arguments should raise an error.
stopifnot(inherits(try(remove_outliers(c("a", "b")), silent = TRUE), "try-error"))
stopifnot(inherits(try(remove_outliers(c(NA_real_, NA_real_)), silent = TRUE), "try-error"))
stopifnot(inherits(try(remove_outliers(c(1, 2), -1), silent = TRUE), "try-error"))
cat("All scripted checks passed if this line appears.\n")

# SHORT STEP 2 REFLECTION (5 sentences):
# AI helped draft the initial IQR filtering idea and suggested tests.
# Code review showed that the first version fails on NA input and gives no
# record of which original observations were removed.
# The revised design adds explicit validation, an NA policy, and indices.
# I must execute the tests in RStudio and independently verify the fences
# before claiming that the revised code is correct.

# PROMPT LOG (actual design prompts used in preparing this submission):
# 1. Write an R function that removes outliers from a numeric vector using IQR.
# 2. Revise the function to include comments, argument validation, and a clean result.
# 3. Explain what each line does and how to test it.
# 4. Update the function to handle NA values and return removed indices.
# 5. Optimize readability and suggest edge cases and independent checks.
