# missr <img src="man/figures/logo.png" align="right" height="138" /></a>

## Overview

The goal of missr is to help you classify missing data as MCAR, MAR, or MNAR.

## Installation

```{r}
# Install missr from CRAN through your R terminal.
install.packages("missr")
```

## Examples

- Testing for MCAR.
    - Null hypothesis is that data is MCAR.

```{r}
test_mcar(data)
```

- Testing for MAR.
    - Null hypothesis is that data is not MAR.

```{r}
test_mar(data)
```

- Testing for MNAR.
    - No new tests, simply a process of elimination.

```{r}
# Test for MNAR.
test_mnar(data)
```

## License

missr has an MIT license, as found in the LICENSE file.
