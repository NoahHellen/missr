#' Little's missing completely at random (MCAR) test
#'
#' @description
#' `r lifecycle::badge("stable")`
#' `mcar()` performs Little's MCAR test to test for MCAR.
#' The null hypothesis is that the data is MCAR.
#'
#' @details
#' This function reproduces the d^2 statistic in equation (5) from \[1\].
#' This statistic is used to test for MCAR. Comments reference variables
#' from `vignette("background")` (in brackets) to improve readability and
#' traceability.
#'
#' @param data A data frame.
#' @param debug A logical value used only for unit testing.
#'
#' @return A [tibble::tibble()]:
#' \item{statistic}{The d^2 statistic}
#' \item{degrees_freedom}{Degrees of freedom of chi-squared distribution}
#' \item{p_val}{P-value of the test}
#' \item{missing_patterns}{Number of missing patterns}
#'
#' @note Code is adapted from `mcar_test()` from the naniar package
#' using base R instead of the tidyverse.
#'
#' @export
#'
#' @examples
#' mcar(pollutionlevels)
#'
#' @references
#' \[1\] Little RJA. A Test of Missing Completely at Random for
#' Multivariate Data with Missing Values. Journal of the
#' American Statistical Association. 1988;83(404):1198-202.
mcar <- function(data, debug = FALSE) {
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

  # Data matrix (D) with encoded non-numeric columns
  y <- data.frame(data.matrix(data))

  # Number of variables (p)
  p <- ncol(y)
  if (debug) options(p = p)

  # Missing indicator matrix (M)
  ind <- 1 * !is.na(y)
  if (debug) options(ind = ind)

  # MLE with EM algorithm for (hat{mu}) and (hat{Sigma})
  s <- norm::prelim.norm(data.matrix(y))
  theta <- norm::em.norm(s, showits = FALSE)
  fit <- norm::getparam.norm(s = s, theta = theta)
  mu <- fit$mu
  sigma <- fit$sigma
  colnames(sigma) <- rownames(sigma) <- colnames(y)

  # Missing data patterns (j) and total (J)
  miss_pattern <- apply(ind, 1, paste0, collapse = "")
  miss_pattern <- as.integer(factor(miss_pattern))
  total_miss <- length(unique(miss_pattern))
  if (debug) options(total_miss = total_miss)

  # Split data by group (S)
  grouped_y <- cbind(y, miss_pattern)
  grouped_y <- split(grouped_y, grouped_y$miss_pattern)

  # Vectors for (d^2_j) and (p_j)
  d2j <- numeric()
  pj <- numeric()

  # Compute summands of equation (5) from \[1\] separately
  for (j in seq_along(grouped_y)) {
    # Find group data (S_j) and code-equivalent of (Q_j)
    group_data <- grouped_y[[j]][, 1:p]
    complete_cols <- which(colSums(!is.na(group_data)) > 0) # (Q_j)
    pj[j] <- length(complete_cols)

    # Find (bar{D_{obs,j}} - hat{u_{obs,j}})
    group_mu <- colMeans(group_data, na.rm = TRUE) - mu
    group_mu <- group_mu[complete_cols]

    # Find (tilde{Sigma^{-1}_{obs,j}})
    inv_sigma <- solve(sigma[complete_cols, complete_cols, drop = FALSE])

    # Find (m_j)
    mj <- nrow(group_data)

    # Edge case if pattern all NA
    if (pj[j] > 0) {
      d2j[j] <- mj * as.numeric(t(group_mu) %*% inv_sigma %*% group_mu)
    } else {
      d2j[j] <- 0
    }
  }

  # Statistic (d^2), degrees of freedom, and p-value
  d2 <- sum(d2j)
  df <- sum(pj) - p
  p_val <- 1 - stats::pchisq(d2, df)

  tibble::tibble(
    statistic = d2,
    degrees_freedom = df,
    p_val = p_val,
    missing_patterns = total_miss
  )
}
