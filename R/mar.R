#' Missing at random (MAR) test
#'
#' @description
#' `r lifecycle::badge("stable")`
#' `mar()` performs multiple logistic regressions to test for MAR.
#' The null hypothesis for each is that the data are not MAR.
#'
#' @details
#' In the following, each column of M with missing data is regressed on
#' D_obs. Each regression produces a vector of p-values (one for each
#' variable in D_obs). The smallest p-value is the most important. This
#' is because missing data need only be dependent on one observed variable
#' for the data to be MAR. If each reported smallest p-value is significant,
#' the data is MAR. See `vignette("background")` for definitions of M and
#' D_obs.
#'
#' @param data A data frame.
#'
#' @return A [tibble::tibble()] with m rows and six columns:
#' \item{missing}{Columns of M with missing data}
#' \item{p_value}{Smallest p-value of each regression}
#' \item{explanatory}{Corresponding variable of `p_value`}
#' \item{p_values}{The p-values of each regression}
#' \item{variables}{Corresponding variables of `p_values`}
#' \item{combined}{Paired `p_values` and `variables` for easier
#' interpretation}
#'
#' @export
#'
#' @examples
#' mar(airquality)
mar <- function(data) {
  # Inputs checks
  if (!is.data.frame(data)) {
    stop("Expected a data.frame object.")
  }
  if (!anyNA(data)) {
    stop("There is no missing data in this dataset.")
  }
  if (any(sapply(data, is.character))) {
    warning("All non-numeric columns were encoded for regression -
    verify encodings are interpretable.")
  }

  # Encode non-numeric columns
  data[] <- lapply(
    data,
    function(x) if (is.numeric(x)) x else as.numeric(factor(x))
  )

  # Indicator matrix
  ind <- as.data.frame(ifelse(is.na(data), 0, 1))

  # Columns with missing data
  cols_miss <- names(ind)[sapply(ind, function(col) any(col == 0))]

  # Lists to store regression information
  p_vals <- list()
  vars <- list()
  comb <- list()

  for (i in seq_along(cols_miss)) {
    col <- cols_miss[i]
    p_vals[[col]] <- numeric()
    vars[[col]] <- character()
    for (j in seq_len(ncol(data))) {
      s <- summary(stats::lm(ind[[col]] ~ data[[j]]))
      p_vals[[col]][[j]] <- s$coefficients[2, 4]
      vars[[col]][[j]] <- colnames(data)[j]
    }
    comb[[col]] <- stats::setNames(unlist(p_vals[[i]]), vars[[i]])
  }
  tibble::tibble(
    missing = cols_miss,
    p_value = sapply(p_vals, min),
    explanatory = mapply(function(p, v) v[which.min(p)], p_vals, vars),
    p_values = p_vals,
    variables = vars,
    combined = comb
  )
}
