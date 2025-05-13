#' Missing not at random (MNAR) classification
#'
#' @description
#' `r lifecycle::badge("stable")`
#' `mnar()` presents the statistics from [mar()] and [mcar()]. If at least one
#' p-value in [mar()] is not significant, and the p-value in [mcar()] is
#' significant then the data is MNAR.
#'
#' @details
#' There exists no formal test for MNAR data. This function therefore
#' presents the statistics for the tests in [mar()] and [mcar()]. If the
#' results suggest the data is neither MAR nor MCAR, one can use process of
#' elimination to deduce that the data is MNAR.
#'
#' @param data A data frame
#'
#' @return A list:
#'  \item{mcar}{Results of Little's MCAR test}
#'  \item{mar}{Results of MAR test}
#'
#' @export
#'
#' @examples
#' mnar(companydata)
mnar <- function(data) {
  # Input checks
  if (!is.data.frame(data)) {
    stop("Expected a data.frame object.")
  }
  if (!anyNA(data)) {
    stop("There is no missing data in this dataset.")
  }
  if (any(sapply(data, is.character))) {
    warning("Non-numeric columns encoded - verify
    interpretable.")
  }

  # Encode non-numeric columns
  data <- data.frame(data.matrix(data))
  mcar <- mcar(data)
  mar <- mar(data)
  list(
    mcar = mcar,
    mar = mar
  )
}
