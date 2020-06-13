# tidyethnicnews

An R Package for Turning Ethnic NewsWatch Search Results into Tidyverse-ready Dataframes

Author: [Jae Yeon Kim](https://jaeyk.github.io/)

## Summary

[Ethnic NewsWatch database](https://about.proquest.com/products-services/ethnic_newswatch.html), provided by ProQuest, has complied more than 2.5 million articles published in the US ethnic newspapers and magazines. This data source helps researchers to investigate the political voice of minority groups in the US with rich and extensive text data. This R package provides functions to turn Ethnic NewsWatch search results into tidyverse-ready dataframes.


## Installation

```r

## Install the current development version from GitHub

devtools::install_github("jaeyk/tidyethnicnews",
                         dependencies = TRUE)
```

## Responsible use
`tidyethnicnews` should be used in strict accordance with EthnicNewsWatch's [Terms of Use](https://about.proquest.com/about/terms-and-conditions.html).

### How to download HTML search results from Ethnic NewsWatch

- This method still works as of June 13, 2020. However, please note that ProQuest download policy can change anytime.

## Usage

### 1. `html_to_dateframe()`: Turn an HTML file in a dataframe

```r

# Load library
library(tidyethnicnews)

# You need to choose an HTML search result
filepath <- file.choose()

# Assign the parsed result to the `df` object
df <- html_to_dataframe(filepath)
```

The `df` object should have four columns: `text`, `author`, `source`, `date`. According to the performance test done by `microbenchmark` package, `html_to_dataframe()` function takes average **0.0007** seconds to turn **100** newspaper articles into a tidy dataframe.

### 2. `html_to_dataframe_all()`: Turn all HTML files saved in a directory in a dataframe

```r

# Load library
library(tidyethnicnews)

# You need to designate a directory path.
dirpath <- tcltk::tk_choose.dir()

# Assign the parsed result to the `df_all` object
df_all <- html_to_dataframe_all(dirpath)

```

Again, the `df_all` object should have four columns: `text`, `author`, `source`, `date`. I tested the running time performance using `tictoc` package. `html_to_dataframe_all()` function takes **45.948** seconds, less than **one** minute, to turn **5,684** articles into a dataframe. (On average, **0.008** seconds per article.)

## Applications

If you have published a paper/project using `tidyethnicnews` package, please email me.
