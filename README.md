# tidyethnicnews

[Ethnic NewsWatch database](https://about.proquest.com/products-services/ethnic_newswatch.html), provided by ProQuest, has complied more than 2.5 million articles published in the US ethnic newspapers and magazines. This rich information helps researchers to investigate the growing and varying political voice of minority groups in the US. This R package provides functions to turn unstructured Ethnic NewsWatch search results into tidyverse-ready dataframes.


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

### 1. Turn an HTML file in a dataframe

```r

# Load library
library(tidyethnicnews)

# You need to choose an HTML search result
filepath <- file.choose()

# Assign the parsed result to the `df` object
df <- html_to_dataframe(filepath)
```

The `df` object should have four columns: `text`, `author`, `source`, `date`. I measured the running time of parsing one HTML file, which contains 100 newspaper articles, using `tictoc` library.

### 2. Turn all HTML files saved in a directory in a dataframe

```r

# Load library
library(tidyethnicnews)

# You need to designate a directory path.
dirpath <- tcltk::tk_choose.dir()

# Assign the parsed result to the `df_all` object
df_all <- html_to_dataframe_all(dirpath)

```

Again, the `df_all` object should have four columns: `text`, `author`, `source`, `date`. I tested the running time performance using `tictoc` library. `html_to_dataframe_all()` function took **66.454** seconds, about **one** minute, to turn **5,684** articles into a dataframe. (On average, **0.01** seconds per article.)

### Data quality check

## TO DO
