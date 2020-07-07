#' Identity US locations based on location variable
#'
#' @param df A parsed Tweet JSON file (data.frame) which includes location variable
#'
#' @return US_location column is added to the data.frame
#'
#' @import stringr
#' @importFrom magrittr "%>%"
#' @import dplyr
#' @import maps
#' @export
#'

add_US_location <- function(df){

    # US cities and states dictionary

    us_cities <- maps::us.cities[,1] %>% str_replace_all(" [[:alpha:]]*$", "") %>% unique() %>% tolower()

    us_states <- c("Alabama",
             "Alaska", "Arizona", "Kansas",
             "Utah", "Colorado", "Connecticut",
             "Delaware", "Florida", "Georgia",
             "Hawaii", "Idaho", "Illinois",
             "Indiana", "Iowa", "Arkansas",
             "Kentucky", "Louisiana", "Maine",
             "Maryland", "Massachusetts", "Michigan",
             "Minnesota", "Mississippi", "Missouri",
             "Montana", "Nebraska", "Nevada",
             "New Hampshire", "New Jersey", "New Mexico",
             "New York", "North Carolina", "North Dakota",
             "Ohio", "Oklahoma", "Oregon",
             "Pennsylvania", "Rhode Island", "South Carolina",
             "South Dakota", "Tennessee", "Texas",
             "California", "Vermont", "Virginia",
             "Washington", "West Virginia", "Wisconsin",
             "Wyoming", "District of Columbia") %>% tolower()

    message(paste("Created a dictionary of the names of the US cities and states"))

    us_country <- c("United States", "USA", "US", "U.S.A.") %>% tolower()

    us_location_list <- c(us_cities, us_states, us_country)

    message(paste("Created a dictionary of the names of the non-US countries"))

    # Other country dictionary

    countryname_dict <- unique(maps::world.cities[,2])

    countryname_dict <- countryname_dict[!countryname_dict %in% c("United States", "USA", "U.S.A.")]

    # Filter

    df[["US"]] <- str_detect(df[["location"]] %>% tolower(), us_location_list %>% paste(collapse = "|")) %>% as.numeric()

    message(paste("Identified locations matched with the names of the US cities and states"))

    df[["non_US"]] <- str_detect(df[["location"]] %>% tolower(), countryname_dict %>% tolower() %>% paste(collapse = "|")) %>% as.numeric()

    message(paste("Excluded locations matched with the names of the non-US countries"))

    # Mutate

    df[["US_location"]] <- ifelse(df[["US"]] == 1 & df[["non_US"]] == 0, 1, 0)

    # Remove

    df <- df %>% select(-c("US", "non_US"))

    # Output

    df
}
