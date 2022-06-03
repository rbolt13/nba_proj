#' Scrape Color Data
#' 
#' @description this file uses the R package rvest to 
#' scrape html colors from Team Color Codes, and saved 
#' to the raw_data folder. 
#' link: https://teamcolorcodes.com/
#' 
#' @retrun a .rds file with the raw data for colors. 

# location of this file 
here::i_am("00_R/00_01_scrape_colors_raw_data.R")

# libraries 
library(magrittr)
library(rvest)

# get enviroment variable to determine which team to look at 
which_team <- Sys.getenv("which_team")

# if / else if for color slug 
if(which_team == "blazers"){
  col_slug <- "portland-trailblazers"
}else if(which_team == "nets"){
  col_slug <- "brooklyn-nets"
}else if(which_team == "hornets"){
  col_slug <- "charlotte-hornets"
}else if(which_team == "suns"){
  col_slug <- "phoenix-suns"
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

# if / else if to subset data
if(which_team == "blazers"){
  cols_tb <- cols_tb[[17]]
}else if(which_team == "nets"){
  cols_tb <- cols_tb[[17]]
}else if(which_team == "hornets"){
  cols_tb <- cols_tb[[25]]
}else if(which_team == "suns"){
  cols_tb <- cols_tb[[48]]
}else{
  cols_tb <- cols_tb[[17]]
}

# location of colors raw data
location_of_raw_data_colors <- here::here("01_raw_data",
                                          "raw_data_colors.rds")

# save data
base::saveRDS(cols_tb, location_of_raw_data_colors)


