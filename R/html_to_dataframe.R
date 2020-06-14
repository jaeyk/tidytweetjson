#' Parse an Ethnic NewsWatch search result (saved in HTML format) into a dataframe 
#'
#' @param file_path A file path which indicates an HTML file that contains the search results from the Ethnic NewsWatch database. This input should be a string vector.
#' 
#' @return A dataframe with four columns ("text", "source", "author", "date")
#' @importFrom tidyr separate
#' @importFrom magrittr "%>%"
#' @importFrom stringr str_replace_all
#' @importFrom stringr str_trim
#' @importFrom xml2 read_html
#' @importFrom purrr pmap
#' @importFrom purrr reduce
#' @importFrom rvest html_nodes
#' @importFrom rvest html_text
#' @importFrom textclean replace_html
#' @export

html_to_dataframe <- function(file_path){
  
# Import data 
html_data <- read_html(file_path) 

# Select text 
doc_text <- html_data %>% 
    html_nodes("text") %>% 
    replace_html() %>%
    str_replace_all("[\r\n]", "") %>%
    str_replace_all("\\", "")

# Select mixed (source + date)
doc_mixed <- html_data %>% 
    html_nodes("[class='abstract_Text col-xs-12 col-sm-10 col-md-10 col-lg-10']") %>% 
    html_text() %>% 
    replace_html() %>%
    str_replace_all(".*\n</span><span class=\"titleAuthorETC\"><strong>", "") %>%
    str_replace_all(":.*", "") %>%
    str_replace_all("</strong>.*</strong>", "") %>%
    str_replace_all("\\]", ":")

# Combine the two objects together as a dataframe
df <- data.frame(text = doc_text, 
                 mixed = doc_mixed)

# Separate mixed 
df <- df %>% 
    separate(mixed, c("source_mixed", "date"), ":")

# Clean up

## Date
df$date <- str_replace_all(df$date, "\n\n\n", "") %>% str_trim()

## Mixed
df$source_mixed <- df$source_mixed %>%
    str_replace_all(";.*", "") 

# Separate author and source

df <- df %>% 
    separate(source_mixed, 
             into = c("author", "source"), 
             sep = ".\n")

if(sum(is.na(df$source)) >= 1){
    message("NAs were found in source column. The problem will be fixed automatically.")
  }

# Replace the NAs in 'source' column with the misplaced values in 'author' column

if(sum(is.na(df$source)) >= 1){

    df$source <- ifelse(is.na(df$source), df$author, df$source)

    df$author <- ifelse(df$author %in% unique(df$source), NA, df$author)

    message("Problem fixed.")

} else {

    message("Everything was successful.")

}

# Output
df 

}