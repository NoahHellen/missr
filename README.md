
<!-- README.md is generated from README.Rmd. Please edit that file -->

# missr <img src="man/figures/logo.png" align="right" height="138" /></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/missr)](https://cran.r-project.org/package=missr)
[![R-CMD-check](https://github.com/NoahHellen/missr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/NoahHellen/missr/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/NoahHellen/missr/graph/badge.svg)](https://app.codecov.io/gh/NoahHellen/missr)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![CRAN RStudio mirror
downloads](https://cranlogs.r-pkg.org/badges/grand-total/missr?color=blue)](https://r-pkg.org/pkg/missr)
<!-- badges: end -->

The goal of missr is to help you classify missing data as MCAR, MAR, or
MNAR. It does this by providing:

- Statistical tests for MCAR and MAR:
  - `mcar()`
  - `mar()`
- Process of elimination for MNAR:
  - `mnar()`

## Installation

You can install missr from CRAN:

``` r
install.packages("missr")
```

Or you can install the development version on github using remotes:

``` r
# install.packages("remotes")
remotes::install_github("NoahHellen/missr")
```

## Examples

- Testing for MCAR.
  - Null hypothesis is that data is MCAR; if the p-value is not
    significant, there is evidence the data is MCAR.

``` r
mcar(data)
```

- Testing for MAR.
  - Each null hypothesis is that data is not MAR; if each p-value is
    significant, there is evidence the data is MAR.

``` r
mar(data)
```

- Testing for MNAR.
  - No new tests, simply a process of elimination.

``` r
mnar(data)
```

## License

missr has an MIT license, as found in the LICENSE file.
