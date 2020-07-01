# tidytweetjson

An R Package for Turning Tweet JSON files into a tidyverse-ready dataframe 

Author: [Jae Yeon Kim](https://jaeyk.github.io/)

File an [issue](https://github.com/jaeyk/tidytweetjson/issues) if you have problems, questions or suggestions.

## Summary


## Installation

```r

## Install the current development version from GitHub

devtools::install_github("jaeyk/tidytweetjson",
                         dependencies = TRUE)
```

## Responsible use
`tidytweetjson` should be used in strict accordance with Twitter's [Terms of Use](https://about.proquest.com/about/terms-and-conditions.html). ProQuest does not allow web scraping. Instead, I recommend manually downloading search results from the database. Below, I provide a step-by-step guide. This method still works as of June 13, 2020. However, please note that ProQuest's download policy could change at any time.

### How to download and split a big Tweet JSON file 


## Usage

Now, you have a list of ... files. Collecting the data has been tedious. By contrast, turning these files into a tidyverse-ready dataframe is incredibly easy and lightning fast with the help of `tidytweetjson`. The parsed text data has eight columns: Its rows are tweets. 

### 1. `html_to_dateframe()`: Turn an HTML file into a dataframe

As a test, select one of the JSON files and inspect whether the result is desirable.

```r

# Load library
library(tidyethnicnews)

# You need to choose an HTML search result
filepath <- file.choose()

# Assign the parsed result to the `df` object
df <- html_to_dataframe(filepath)
```

The `df` object should have four columns: `text`, `author`, `source`, `date`. According to the performance test done by the `microbenchmark` package, the `html_to_dataframe()` function takes average **0.0005** seconds to turn **100** newspaper articles into a tidy dataframe.

This function helps you clean and wrangle your text data without needing to know anything about parsing HTML and manipulating string patterns (regular expressions).

**Notes on the Error Messages**

If an article is missing an `author` field, a value in the `source` field is moved to the `author` field and `NA` is recorded in the `source` field during the wrangling process. When this issue occurs, you will receive an error message saying:

> "NAs were found in source column. The problem will be fixed automatically."`

As stated in the message, the problem will be fixed automatically and there's nothing you need to worry about. If you are not assured, then please take a look at the source code.

### 2. `html_to_dataframe_all()`: Turn all HTML files, saved in a directory, into a dataframe

The next step is scale-up. The `html_to_dataframe_all()` function allows you to turn all the HTML files saved in a particular directory into a d dataframe using a single command. My very first attempt was writing a for-loop function, and the computation was slow. I fixed this problem by using the `purrr` package. Combining the `pmap()` and `reduce()` functions improves the performance significantly.

Again, the `df_all` object should have four columns: `text`, `author`, `source`, `date`. I tested the running time performance using the `tictoc` package. The `html_to_dataframe_all()` function takes **28** seconds to turn **5,684** articles into a dataframe. (On average, **0.005** seconds per article.)

```r

# Load library
library(tidyethnicnews)

# You need to designate a directory path.
dirpath <- tcltk::tk_choose.dir()

# Assign the parsed result to the `df_all` object
df_all <- html_to_dataframe_all(dirpath)

```

## How to cite

If you would like to cite, please do something like the following:

```
Jae Yeon Kim. (2020). tidytweetjson [Computer Software]. Retrieved from https://github.com/jaeyk/tidyethnicnews
```
