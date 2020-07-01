#' Parse multiple Tweet JSON files into a dataframe
#'
#' @param dir_path A directory path where a user saved Tweet JSON files. This input should be a string vector.
#'
#' @return A dataframe with eight columns: "document.id", "ccode", "created_at", "full_text", "retweet_count", "favorite_count", "user.followers_count", "user.friends_count"
#' 
#' @importFrom dplyr full_join
#' @importFrom magrittr "%>%"
#' @importFrom purrr pmap
#' @importFrom purrr reduce
#' @export


jsonl_to_df_all <- function(dir_path){

# Create a list of the smaller JSON files

filename <- list.files(dir_path,
                pattern = '^x',
                full.names = TRUE)

df <- list(filename) %>%

      # Apply twitter_jsonl2_df function to items on the list
      pmap(~jsonl_to_df(.)) %>%

      # Full join the list of dataframes
      reduce(full_join,
             by = c("document.id",
                    "country_code",
                    "created_at",
                    "full_text",
                    "retweet_count",
                    "favorite_count",
                    "user.followers_count",
                    "user.friends_count"))

# Output
df

}
