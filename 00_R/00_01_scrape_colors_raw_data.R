#' Scrape Color Data
#' 
#' @description this file uses the R package rvest to 
#' scrape html colors from Team Color Codes, and saved 
#' to the raw_data folder. 
#' link: https://teamcolorcodes.com/
#' 
#' @retrun a .rds file with the raw data for colors. 

# location of this file 
here::i_am("R/00_01_scrape_colors_raw_data.R")

# libraries 
library(magrittr)
library(rvest)

# get enviroment variable to determine which team to look at 
which_team <- Sys.getenv("which_team")

# if / else if 
if(which_team == "blazers"){
  col_slug <- "portland-trailblazers"
}else if(which_team == "nets"){
  col_slug <- "brooklyn-nets"
}else{
  col_slug <- "portland-trailblazers"
}

# url 
url <- paste0("https://teamcolorcodes.com/",col_slug ,"-color-codes/")

# read color codes hex table 
cols_tb <- url %>%
  read_html %>%
  html_elements("div p") %>% 
  html_table()

# location of colors raw data
location_of_raw_data_colors <- here::here("raw_data",
                                          "raw_data_colors.rds")

# save data
base::saveRDS(raw_data, location_of_raw_data_colors)


