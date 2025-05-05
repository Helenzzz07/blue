
<!-- README.md is generated from README.Rmd. Please edit that file -->

# blue

<!-- badges: start -->
<!-- badges: end -->

The blue package provides a simple R interface to track Paris 2024
Olympic Games (Track and Field results.  
It is distinct from other packages because it includes 2024 data and
supports specific athlete-level filtering

## Installation

You can install the development version of blue from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Helenzzz07/blue")
#> Using GitHub PAT from the git credential store.
#> Downloading GitHub repo Helenzzz07/blue@HEAD
#> 
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#> * checking for file ‘/private/var/folders/ms/xjzzdk6j1_5c0_mrplhcsqs0l7p7zx/T/RtmpfDujKk/remotes17247206f914d/Helenzzz07-blue-4f4c355/DESCRIPTION’ ... OK
#> * preparing ‘blue’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> * building ‘blue_0.0.0.9000.tar.gz’
#> Warning: invalid uid value replaced by that for user 'nobody'
#> Warning: invalid gid value replaced by that for user 'nobody'
#> Installing package into '/private/var/folders/ms/xjzzdk6j1_5c0_mrplhcsqs0l7p7zx/T/Rtmp2iRaVS/temp_libpath15a01520057d6'
#> (as 'lib' is unspecified)
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(blue)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.

## Example

This is a basic example that shows how to look up and visualize an
athlete’s performance:

``` r
library(blue)
# Find the results URL for a specific athlete
#find_athlete("Álvaro MARTÍN")

# Plot the athlete's performance
#plot_athlete_performance("Álvaro MARTÍN")
```

``` r
#plot_athlete_performance("Fake Athlete")
#> Warning: Athlete not found.
```
