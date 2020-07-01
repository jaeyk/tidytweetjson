# tidytweetjson

An R Package for Turning Tweet JSON Files into a Tidyverse-ready Dataframe

Author: [Jae Yeon Kim](https://jaeyk.github.io/)

File an [issue](https://github.com/jaeyk/tidytweetjson/issues) if you have problems, questions or suggestions.

## Summary [TBD]

## Installation

```r

## Install the current development version from GitHub

devtools::install_github("jaeyk/tidytweetjson",
                         dependencies = TRUE)
```

## Responsible use [TBD]
`tidytweetjson` should be used in strict accordance with Twitter [Terms of Service](https://twitter.com/en/tos).

### How to download and split a big Tweet JSON file [TBD]

## Usage [TBD]

Now, you have a list of ... files. Collecting the data has been tedious. By contrast, turning these files into a tidyverse-ready dataframe is incredibly easy and lightning fast with the help of `tidytweetjson`. The parsed text data has eight columns: Its rows are tweets.

### 1. `jsonl_to_df()`: Turn a Tweet JSON file into a dataframe

As a test, select one of the JSON files and inspect whether the result is desirable.

```r

# Load library
library(tidytweetjson)

# You need to choose an HTML search result
filepath <- file.choose()

# Assign the parsed result to the `df` object
df <- jsonl_to_df(filepath)
```

### 2. `jsonl_to_df_all()`: Turn all Tweet JSON files, saved in a directory, into a dataframe

Combining the `pmap()` and `reduce()` functions improves the performance significantly.

Again, the `df_all` object should have eight columns: I tested the running time performance using the `tictoc` package. The `jsonl_to_df_all()` function takes ...

```r

# Load library
library(tidytweetjson)

# You need to designate a directory path.
dirpath <- tcltk::tk_choose.dir()

# Assign the parsed result to the `df_all` object
df_all <- jsonl_to_df_all(dirpath)

```

## How to cite

If you would like to cite, please do something like the following:

```
Jae Yeon Kim. (2020). tidytweetjson [Computer Software]. Retrieved from https://github.com/jaeyk/tidyethnicnews
```
