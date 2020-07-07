# tidytweetjson

An R Package for Turning Tweet JSON Files into a Tidyverse-ready Dataframe

Author: [Jae Yeon Kim](https://jaeyk.github.io/)

File an [issue](https://github.com/jaeyk/tidytweetjson/issues) if you have problems, questions or suggestions.

## Summary

Twitter data is an important resource for social science research. (As of July 1, 2020, if you queried "Twitter" in Google Scholar, it returned more than seven million search results.) However, parsing a great deal of Twitter JSON data is not an easy task for researchers with little programming experience. This package provides functions to clean and wrangle Tweet JSON files simply and quickly.

**1. Tidying a Tweet JSON file**

Most social science researchers have only worked with clearly structured data (e.g., spreadsheets). If one downloads Tweets from [the Twitter API](https://developer.twitter.com/en), these Tweets were stored in a semi-structured file format called JSON (JaveScript Object Notation). In simple terms, it has some structure but does not resemble a spreadsheet. With `tidytweetjson`, one does not need to understand a JSON file structure. **The package helps you to get a tidy data from a Tweet JSON file simply and quickly.**

**2. Tidying multiple Tweet JSON files**

The other challenge is that, often, the number of tweets you want to analyze is large (several GBs or TBs). One way you can work around this problem is to split the JSON file, parse each JSON file into a dataframe, and join them. With `tidytweetjson`, one does not need to write a for loop to perform this task. **The package helps you to parse and join multiple JSON files into a tidyverse-ready dataframe with just one command.**

## Installation

```r

## Install the current development version from GitHub

devtools::install_github("jaeyk/tidytweetjson",
                         dependencies = TRUE)
```

## Responsible use
`tidytweetjson` should be used in strict accordance with Twitter's [developer terms](https://developer.twitter.com/en/developer-terms/more-on-restricted-use-cases).

## How to download and split a big Tweet JSON file

### Downalod a Tweet JSON file

1. [Sign up](https://developer.twitter.com/en/apply-for-access) a Twitter developer account.
2. Either search for Tweets or turn a Tweet ID dataset into into Tweets (called *[hydrating](https://medium.com/on-archivy/on-forgetting-e01a2b95272#.lrkof12q5)*) using the Twitter API. I highly recommend using [twarc](https://github.com/DocNow/twarc), a command line tool, and Python library to archive Twitter JSON data. Twarc is fast, reliable, and easy to use. If you are using Twarc for the first time, refer to [this tutorial](https://github.com/alblaine/twarc-tutorial). You just need to type one or two commands in the command line to download the Twitter data you want. The followings are examples.

```bash
# search
$ twarc search covid19 > search.jsonl

# hydrate
$ twarc hydrate covid19.tsv [hypothetical data] > search.jsonl
```

- It is really important to **save these tweets into a `jsonl` format;** `jsonl` extension refers to JSON **Lines** files. This structure is useful for splitting JSON data into smaller chunks, if it is too large.

### Split a Tweet JSON file

- If the downloaded Tweet JSON file is too large to be loaded and parsed in an R session, you may want to split it (divide-and-conquer strategy).

1. Save the large JSON file in a directory (ideally, it is the only file in the directory).
2. Open a terminal (commnad-line interface window), and split the large JSON file using the following command. After that, you will see several files appeared in the directory. Each of these files should have 1,000 Tweets or fewer. All of these file names **should start with "x", as in "xaa".**

```bash
#Divide the JSON file by 1000 lines (Tweets)

# Linux and Windows (in Bash)
$ split -1000 search.jsonl

# macOS
$ gsplit -1000 search.jsonl

```

- If you are a macOS user, you need to install `coreutils` by typing `brew info coreutils` in a terminal window. You should use `gsplit` instead of `split`.

- If you are a Windows user and you have not installed Bash yet, please install it (here is a [guide](https://itsfoss.com/install-bash-on-windows/)). Bash allows you to use Linux commands in Windows.


## Usage

Now, you have a Tweet JSON file or a list of them. Collecting the Tweet JSON file could have has been tedious, especially if you have never done this before. By contrast, turning these files into a tidyverse-ready dataframe is incredibly easy and lightning fast with the help of `tidytweetjson`.

The parsed JSON data has a tidy structure. It has nine columns: (user) `id`, `country_code` (country code), (user) `location`, `created_at` (time stamp), `full_text` (tweets), `retweet_count`, `favorite_count`, `user.followers_count`, and `user.friends_count`. Its rows are tweets.

### 1. `jsonl_to_df()`: Turn a Tweet JSON file into a dataframe

As a test, select one of the JSON files and inspect whether the result is desirable. According to the performance test done by the `microbenchmark` package, the `jsonl_to_df()` function takes average **5 seconds** to turn **1000 Tweets** into a tidy dataframe.

```r

# Load library
library(tidytweetjson)

# You need to choose a Tweet JSON file
filepath <- file.choose()

# Assign the parsed result to the `df` object
df <- jsonl_to_df(filepath)
```

### 2. `jsonl_to_df_all()`: Turn all Tweet JSON files, saved in a directory, into a dataframe

Again, the `df_all` object should have nine columns. If your JSON file is heavy (>10GB), I recommend running [`future::plan("multiprocess")`](https://cran.r-project.org/web/packages/future/vignettes/future-1-overview.html) before using this function to speed up the process. I tested the running time performance using the tictoc package. The `jsonl_to_df_all()` function takes 17,148 seconds, or **4.76 hours**, to turn **5,050,042** tweets into a data frame.

```r

# Load library
library(tidytweetjson)

# You need to designate a directory path where you saved the list of JSON files.
dirpath <- tcltk::tk_choose.dir()

# Assign the parsed result to the `df_all` object
df_all <- jsonl_to_df_all(dirpath)

```

### 3. `add_date()`: Add a date variable that parses Tweet timestamps into date format

`create_at` variable (Tweet timestamps) is not immediately usable for data modeling and visualization in R. The `add_date()` function parses `create_at` variable into a new variable called `date` that is in the Year-Month-Day date format.

```r
# Add date variable to the data.frame
df <- add_date(df)

# Head 5 rows of the target and parsed columns
df[1:5,] %>% select(created_at, date)

created_at                      date
Mon Jan 27 18:40:17 +0000 2020	2020-01-27
Tue Jan 28 20:52:03 +0000 2020	2020-01-28
Fri Jan 31 19:33:48 +0000 2020	2020-01-31
Wed Jan 29 17:02:34 +0000 2020	2020-01-29
Fri Jan 31 14:21:47 +0000 2020	2020-01-31
```

## How to cite

If you would like to cite, please do something like the following:

```
Jae Yeon Kim. (2020). tidytweetjson. R package version 0.1.2. Retrieved from https://github.com/jaeyk/tidyethnicnews
```
