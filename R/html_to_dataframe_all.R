#' Parse multiple ProQuest's archive search result (saved in HTML format) into a dataframe simultaneously
#'
#' @param filepath A file path where a user saved HTML files containing the search results from the ProQuest's news archive. This input should be a string vector. 
#' @return A dataframe with four columns ("text", "source", "author", "date")
#'
#' @export
#' 

html_to_dataframe_all <- function(filepath){
  
# Load all HTML files in the designated file path 
filename <- list.files(path = filepath, pattern = '*.html', full.names = TRUE)

df <- list(filename) %>%
  # Apply html_to_dataframe function to items on the list 
  pmap(~html_to_dataframe(.)) %>%
  # Full join the list of dataframes 
  reduce(full_join, by = c("text", "source", "author","date"))

# Output
df 

}
