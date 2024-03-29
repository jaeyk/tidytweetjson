#' Parse a Tweet JSON file into a dataframe
#'
#' @param file_path A file path which indicates a Tweet JSON file. This input should be a string vector.
#' @simplify Extracting only tweet IDs, texts, and time stamps. This argument should be either `FALSE` or `TRUE`. The default value is `FALSE`. 
#'
#' @return A dataframe with nine columns (if simplify = FALSE): "id", "country_code", "location", "created_at", "full_text", "retweet_count", "favorite_count", "user.followers_count", "user.friends_count." A dataframe with three columns (if simplify = TRUE): "id", "created_at", "full_text" 
#' 
#' @importFrom tidyjson read_json
#' @importFrom magrittr "%>%"
#' @importFrom tidyjson enter_object
#' @importFrom tidyjson append_values_string
#' @importFrom tidyjson as_tibble
#' @importFrom dplyr rename
#' @importFrom dplyr select
#' @importFrom tidyjson spread_values
#' @importFrom tidyjson jstring
#' @importFrom tidyjson jnumber
#' @importFrom dplyr full_join
#' @export

jsonl_to_df <- function(file_path, simplify = FALSE){

  # Save file name 
  
  file_name <- strsplit(x = file_path, 
                       split = "[/]") 
  
  file_name <- file_name[[1]][length(file_name[[1]])]

  # Import a JSON file
    
	# test: 
	# listed <- read_json(file.choose(), format = c("jsonl"))

	listed <- read_json(file_path, format = c("jsonl"))

	if (simplify == FALSE) {
	  
	# IDs of the Tweets with country codes

	ccodes <- listed %>%
	       enter_object("place") %>%
	       enter_object("country_code") %>%
	       append_values_string() %>%
	       as_tibble %>%
	       rename("country_code" = "string")

	# IDs of the Tweets with location 
	
	locations <- listed %>%
	       enter_object("user") %>%
	       enter_object("location") %>%
	       append_values_string() %>%
	       as_tibble %>%
	       rename(location = "string")
	
	# Extract other key elements from the JSON file
	df <- listed %>%
	spread_values(
	       id = jnumber("id"),
	       created_at = jstring("created_at"),
	       full_text = jstring("full_text"),
	       retweet_count = jnumber("retweet_count"),
	       favorite_count = jnumber("favorite_count"),
	       user.followers_count = jnumber("user.followers_count"),
	       user.friends_count = jnumber("user.friends_count")) %>%
	       as_tibble

	message(paste("Parsing", file_name, "done."))

  # full join
	outcome <- full_join(ccodes, df) %>% full_join(locations)
	
	# output
	outcome %>% select(-c("document.id"))
	
	return(outcome)
	
	}
	
	if (simplify == TRUE) {
	  
	  # Extract other key elements from the JSON file
	  df <- listed %>%
	    spread_values(
	      id = jnumber("id"),
	      created_at = jstring("created_at"),
	      full_text = jstring("full_text")) %>%
	    as_tibble
	  
	  message(paste("Parsing", file_name, "done."))
	  
	  df <- df %>% select(-c("document.id"))
	  
	  return(df)
	}

}
