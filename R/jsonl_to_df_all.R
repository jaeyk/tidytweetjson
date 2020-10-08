#' Parse multiple Tweet JSON files into a dataframe
#'
#' @param dir_path A directory path where a user saved Tweet JSON files. This input should be a string vector.
#'
#' @return A dataframe with nine columns: "id", "document.id", "country_code", "location", "created_at", "full_text", "retweet_count", "favorite_count", "user.followers_count", "user.friends_count"
#'
#' @importFrom dplyr full_join
#' @importFrom magrittr "%>%"
#' @importFrom purrr map
#' @importFrom purrr reduce
#' @importFrom future plan
#' @importFrom furrr future_map_dfr
#' @export


jsonl_to_df_all <- function(dir_path){

# Create a list of the splitted JSON files

      filename <- list.files(dir_path,
                pattern = '^x',
                full.names = TRUE)

      df <- filename %>%

      # Apply jsonl_to_df function to items on the list
      future_map_dfr(~jsonl_to_df(.))

# Output
return(df)

}
