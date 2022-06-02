#' Scrape Total Stats Data
#' 
#' @description this file uses the R package rvest to 
#' scrape total stats data from Basketball Reference and 
#' then saves that data into a list in the raw data folder. 
#' Link: https://www.basketball-reference.com/ 
#' 
#' Note: the total stats are put into a list, assuming other
#' stats may be pulled in the future from this file. 
#' 
#' @param which_team which is a global variable set in
#' the dockerfile that tells which team to pull stats for. 
#' Default will be the Portland Trail Blazers
#' 
#' @return RDSfile of stats data.

# location of this file 
here::i_am("R/00_00_scrape_stats_raw_data.R")

# libraries 
library(magrittr)
library(rvest)

# get enviroment variable to determine which team to look at 
which_team <- Sys.getenv("which_team")

# if / else if 
if(which_team == "blazers"){
  slug <- "POR"
}else if(which_team == "nets"){
  slug <- "BRK"
}else{
  slug <- "POR"
}

# url
url <- paste0("https://www.basketball-reference.com/teams/",
              slug,"/2022.html")

# Read total stats
ttl_stat <- url %>%
  read_html %>%
  html_node("#totals") %>% 
  html_table()

# Put all data into one list 
raw_data <- list(ttl_stat)

# location of raw data 
location_of_raw_data <- here::here("raw_data",
                                   "raw_data_stats.rds")

# save data
base::saveRDS(raw_data, location_of_raw_data)