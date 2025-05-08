#' Little's Missing completely at random (MCAR) test
#'
#' @description
#' `r lifecycle::badge("stable")`
#' `mcar()` performs Little's MCAR test to test for MCAR.
#' The null hypothesis is that the data is not MCAR.
#'
#' @details
#' This function reproduces the d^2 statistic in equation (5) from \[1\].
#' This statistic is used to test for MCAR. Comments reference variables
#' from the paper (in brackets) to improve readability and traceability.
#' See `vignette("background")` for a more thorough description of the
#' test and definitions of the variables shown (in brackets).
#'
#' @param data A data frame.
#'
#' @return A `data.frame`:
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
#' mcar(airquality)
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

  # Data matrix (y) with encoded non-numeric columns
  y <- data.frame(data.matrix(data))

  # Number of variables (p)
  p <- ncol(y)
  if (debug) options(p = p)

  # Missing indicator matrix (r)
  ind <- 1 * !is.na(y)

  # MLE with EM algorithm for (mu) and (Sigma)
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

  # Split data by group (S)
  grouped_y <- cbind(y, miss_pattern)
  grouped_y <- split(grouped_y, grouped_y$miss_pattern)

  # Vectors for (d^2_j) and (p_j)
  d2j <- numeric()
  pj <- numeric()

  # Compute summands of equation (5) from [1] separately
  for (j in seq_along(grouped_y)) {
    # Find group data (S_j) and code-equivalent of (D_j)
    group_data <- grouped_y[[j]][, 1:p]
    complete_cols <- which(colSums(!is.na(group_data)) > 0) # (D_j)
    pj[j] <- length(complete_cols)

    # Find (bar{y_{obs,j}} - hat{u_{obs,j}})
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

  data.frame(
    statistic = d2,
    degrees_freedom = df,
    p_val = p_val,
    missing_patterns = total_miss
  )
<<<<<<< HEAD
}

mcar_test_base <- function(data) {
  if (!is.data.frame(data)) stop("Input must be a data frame")

  data <- data.matrix(data)
  n_var <- ncol(data)
  n <- nrow(data)
  var_names <- colnames(data)

  # Calculate missing data pattern
  r <- 1 * !is.na(data)
  mdp <- (r %*% (2^((1:n_var - 1)))) + 1
  x_miss_pattern <- data.frame(data, miss_pattern = mdp)
  n_miss_pattern <- length(unique(x_miss_pattern$miss_pattern))

  # Recode pattern as factor levels
  x_miss_pattern$miss_pattern <- as.integer(factor(x_miss_pattern$miss_pattern))

  # MLE using {norm} package
  s <- norm::prelim.norm(data)
  ll <- norm::em.norm(s, showits = FALSE)
  fit <- norm::getparam.norm(s = s, theta = ll)
  grand_mean <- fit$mu
  grand_cov <- fit$sigma
  colnames(grand_cov) <- rownames(grand_cov) <- colnames(data)

  # Group by missing pattern (base R version of group_by + nest)
  pattern_list <- split(x_miss_pattern[, -ncol(x_miss_pattern)], x_miss_pattern$miss_pattern)

  # Prepare to collect stats
  d2_vals <- numeric(length(pattern_list))
  kj_vals <- numeric(length(pattern_list))

  for (i in seq_along(pattern_list)) {
    group_data <- pattern_list[[i]]
    complete_cols <- which(colSums(!is.na(group_data)) > 0)

    # Degrees of freedom kj
    kj_vals[i] <- length(complete_cols)

    # Subset to non-missing variables
    group_mu <- colMeans(group_data, na.rm = TRUE) - grand_mean
    group_mu <- group_mu[complete_cols]

    sigma_sub <- grand_cov[complete_cols, complete_cols, drop = FALSE]

    if (length(group_mu) > 0) {
      d2_vals[i] <- nrow(group_data) * as.numeric(t(group_mu) %*% solve(sigma_sub) %*% group_mu)
    } else {
      d2_vals[i] <- 0
    }
  }

  d2 <- sum(d2_vals)
  df <- sum(kj_vals) - n_var
  p_value <- 1 - stats::pchisq(d2, df)

  # Return results
  data.frame(
    statistic = d2,
    df = df,
    p.value = p_value,
    missing.patterns = n_miss_pattern
  )
}
=======
}
>>>>>>> 0a6dfbe (Using options() to add more tests)
