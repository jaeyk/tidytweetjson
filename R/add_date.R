#' Parse created_at variable into a date variable 
#'
#' @param df A parsed Tweet JSON file (data.frame) which includes created_at variable 
#'
#' @return date column is added to the data.frame
#' 
#' @importFrom stringr word 
#' @importFrom magrittr "%>%"
#' @importFrom dplyr mutate
#' @export

add_date <- function(df){
    
    # Parse create_at variable 
    
    df$date <- as.POSIXct(df[["created_at"]], 
                            tz = "UTC",
                            format = "%a %b %d %H:%M:%S %z %Y") %>% #
               word(1) # Only year month date 
    
    # Output 
    
    df 
}