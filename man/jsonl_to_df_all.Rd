% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/jsonl_to_df_all.R
\name{jsonl_to_df_all}
\alias{jsonl_to_df_all}
\title{Parse multiple Tweet JSON files into a dataframe}
\usage{
jsonl_to_df_all(dir_path, simplify = FALSE)
}
\arguments{
\item{dir_path}{A directory path where a user saved Tweet JSON files. This input should be a string vector.}
}
\value{
A dataframe with nine columns: "id", "document.id", "country_code", "location", "created_at", "full_text", "retweet_count", "favorite_count", "user.followers_count", "user.friends_count"
}
\description{
Parse multiple Tweet JSON files into a dataframe
}
