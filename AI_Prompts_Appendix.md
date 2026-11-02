# AI Prompt Appendix — BDA400 Assignment 3

**Student:** Dhyeykumar Joshi
**Tool:** OpenAI ChatGPT (GPT-6)  
**Date:** 2026-10-31

## Task
Remove outliers from a numeric vector using the 1.5 × IQR rule, handle missing values, and report removed observations and original indices.

## Prompt iterations and key response summaries

1. **Seed:** “Write an R function that removes outliers from a numeric vector using IQR.”  
   **Key response:** An initial `quantile()` / `IQR()` based filter, represented by `remove_outliers_initial()` in the R script.
2. **Refinement:** “Revise the function to include comments, argument validation, and return a clean result.”  
   **Key response:** Validate vector type and multiplier; return a named list of results.
3. **Explanation:** “Explain what each line of the R code does and how you might test if it works correctly.”  
   **Key response:** Line-by-line explanatory comments and ordinary/edge-case test suggestions.
4. **Debugging:** “Update the function to handle NA values and return removed indices.”  
   **Key response:** Exclude missing values from quartile calculations and report original positions.
5. **Optimization:** “Optimize the function for efficiency and readability. How could you test this function with edge cases?”  
   **Key response:** Vectorized indexing, constant-vector and invalid-input tests, and comparison to `boxplot.stats()`.
6. **Reflection:** “Summarize how this R function changed across revisions. Highlight what improvements were human-driven vs. AI-generated.”  
   **Key response:** The first draft was minimal; the revised draft adds validation, missing-value handling, and traceability. The student must confirm their own testing and manual changes.

## Verification status
The R script includes executable checks, but an authentic RStudio console log and independent spreadsheet calculation must be added by the student. Do not treat suggested outcomes as executed evidence.

## AI assistance declaration
AI Assistance Declaration: I used OpenAI ChatGPT (GPT-6) for task framing, code suggestions, comments, and test planning. Prompts are listed above. I will verify outputs in RStudio, independently cross-check IQR fences in a spreadsheet, and manually inspect edge cases. All final calculations must be completed and checked by me. I am responsible for the accuracy and originality of this work.
