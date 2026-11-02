# Independent verification guide

For the synthetic example `c(10, 15, 999, 20, 25)`, use a spreadsheet to calculate the 25th and 75th percentiles using an inclusive interpolation convention, then compute IQR, lower fence, and upper fence. Compare with the printed `q1`, `q3`, `iqr`, `lower_fence`, and `upper_fence` from R. Note that `boxplot.stats()` can use different hinges on some small datasets.

Run `source("AI_RFunction.R")` in RStudio. Save the console output in `Test_Output_Log.txt`, replacing the template. Capture a genuine screenshot showing the final success message if desired. Add R version, date, and any fixes actually made. Never submit generated or illustrative evidence as a real execution log.
