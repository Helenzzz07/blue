
<!-- README.md is generated from README.Rmd. Please edit that file -->

# blue

<!-- badges: start -->

[![R-CMD-check](https://github.com/Helenzzz07/blue/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Helenzzz07/blue/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/Helenzzz07/blue/graph/badge.svg)](https://app.codecov.io/gh/Helenzzz07/blue)
<!-- badges: end -->

The blue package provides a simple R interface for exploring track and
field results from the Paris 2024 Olympic Games. It is distinct from
other packages because it includes 2024 athlete-level data and supports
flexible filtering and plotting.

## Installation

You can install the development version of blue from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Helenzzz07/blue")
```

## Example

This is a basic example that shows how to look up and visualize top 10
athlete’s performance:

``` r
library(blue)
library(dplyr)


# Find the results URL for a specific athlete
find_athlete("Álvaro MARTÍN")
#> [1] "https://worldathletics.org/results/olympic-games/2024/the-xxxiii-olympic-games-7087/men/20-kilometres-race-walk/final/result#resultheader"

# Plot the top 10 athletes's performance in final round
plot_event_top10 ("20 Kilometres Race Walk")
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

``` r
# Warning: Athlete not found.
plot_event_top10("Fake Athlete")
#> Warning in plot_event_top10("Fake Athlete"): No valid data found for event:
#> Fake Athlete
#> NULL
```
