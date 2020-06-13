#' Parse an Ethnic NewsWatch search result (saved in HTML format) into a dataframe 
#'
#' @param html_file An HTML file that contains the search results from the ProQuest's news archive 
#' @return A dataframe with four columns ("text", "source", "author", "date")
#'
#' @export

html_to_dataframe <- function(html_file){
  
# Import data 
html_data <- read_html(html_file) 

# Select text 
doc_text <- html_data %>% 
  html_nodes("text") %>% 
  replace_html() %>%
  str_replace_all("[\r\n]", "")

# Select mixed (source + date)
doc_mixed <- html_data %>% html_nodes("[class='abstract_Text col-xs-12 col-sm-10 col-md-10 col-lg-10']") %>% html_text() %>% replace_html() %>%
  str_replace_all(".*\n</span><span class=\"titleAuthorETC\"><strong>", "") %>%
  str_replace_all(":.*", "") %>%
  str_replace_all("</strong>.*</strong>", "") %>%
  str_replace_all("\\]", ":")

# Combine the two objects together as a dataframe
df <- data.frame(text = doc_text, 
                 mixed = doc_mixed)

# Separate mixed 
df <- df %>% separate(mixed, c("source_mixed", "date"), ":")

# Final clean up

## Date
df$date <- str_replace_all(df$date, "\n\n\n", "") %>% str_trim()

# Final clean up
df$source_mixed <- df$source_mixed %>%
  str_replace_all(";.*", "") 

# Separate author and source 
df <- df %>% separate(source_mixed, c("author", "source"), ".\n")

if(sum(is.na(df$source)) >= 1){print("NAs were found in source column. The problem will be fixed automatically.")}

# Replace the NAs in 'source' column with the misplaced values in 'author' column

if(sum(is.na(df$source)) >= 1){

df$source <- ifelse(is.na(df$source), df$author, df$source)

df$author <- ifelse(df$author %in% unique(df$source), NA, df$author)

print("Problem fixed.")

} else {

  print("Everything was successful.")

}

# Output
df 

}