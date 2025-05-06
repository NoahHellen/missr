# missr <img src="man/figures/logo.png" align="right" height="138" /></a>

The goal of missr is to help you classify missing data as MCAR, MAR, or MNAR. It does this by providing:
- Statistical tests for MCAR and MAR:
    - `mcar()`
    - `mar()`
- Process of elimination for MNAR:
    - `mnar()`

## Installation

```{r}
install.packages("missr")
```

## Examples

- Testing for MCAR.
    - Null hypothesis is that data is MCAR; if the p-value is not significant, there is evidence the data is MCAR.

```{r}
mcar(data)
```

- Testing for MAR.
    - Each null hypothesis is that data is not MAR; if each p-value is significant, there is evidence the data is MAR.

```{r}
mar(data)
```

- Testing for MNAR.
    - No new tests, simply a process of elimination.

```{r}
mnar(data)
```

## License

missr has an MIT license, as found in the LICENSE file.
