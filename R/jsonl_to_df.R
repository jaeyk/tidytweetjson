#' Parse a Tweet JSON file into a dataframe
#'
#' @param file_path A file path which indicates a Tweet JSON file. This input should be a string vector.
#'
#' @return A dataframe with eight columns: "document.id", "ccode", "created_at", "full_text", "retweet_count", "favorite_count", "user.followers_count", "user.friends_count"
#' 
#' @importFrom tidyjson read_json
#' @importFrom magrittr "%>%"
#' @importFrom tidyjson enter_object
#' @importFrom tidyjson append_values_string
#' @importFrom tidyjson as_tibble
#' @importFrom dplyr rename
#' @importFrom tidyjson spread_values
#' @importFrom tidyjson jstring
#' @importFrom tidyjson jnumber
#' @importFrom dplyr full_join
#' @export

jsonl_to_df <- function(file_path){

  # Save file name 
  
  file_name <- strsplit(x = file_path, 
                       split = "[/]") 
  
  file_name <- file_name[[1]][length(file_name[[1]])]

  # Import a JSON file
    
	# test: listed <- read_json(file.choose(), format = c("jsonl"))

	listed <- read_json(file_path, format = c("jsonl"))

	# IDs of the Tweets with country codes

	with_ccodes <- listed %>%
	       enter_object("place") %>%
	       enter_object("country_code") %>%
	       append_values_string() %>%
	       as_tibble %>%
	       rename(country_code = "string")

	# Extract other key elements from the JSON file
	df <- listed %>%
	spread_values(
	       created_at = jstring("created_at"),
	       full_text = jstring("full_text"),
	       retweet_count = jnumber("retweet_count"),
	       favorite_count = jnumber("favorite_count"),
	       user.followers_count = jnumber("user.followers_count"),
	       user.friends_count = jnumber("user.friends_count")) %>%
	       as_tibble

	message(paste("Parsing", file_name, "done."))

  # full join
	outcome <- full_join(with_ccodes, df)

	# output
	outcome
}
