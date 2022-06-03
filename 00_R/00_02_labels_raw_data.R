#' Graph Labels 
#' 
#' @description this file contains the "raw data" of graph 
#' labels which are used in 00_R/02_00_barplot.R. 
#' 
#' @return a .rds file in the raw_data folder that contains graph
#' labels. 
#' 

# location of this file
here::i_am("00_R/00_02_labels_raw_data.R")

# libraries 

# get enviroment variable to determine which team to look at 
which_team <- Sys.getenv("which_team")
which_stat <- Sys.getenv("which_stat")

# if / else if for team name (title)
if(which_team == "blazers"){
  team_name <- "Portland Trail Blazers"
}else if(which_team == "nets"){
  team_name <- "Brooklyn Nets"
}

# description 
description <- paste0("This visualization shows the to 25% of ", which_stat, " for the 2021/2022 ", team_name)

# todays date 
date_today <- base::Sys.Date()

# caption 
caption <- paste0("\n\n Data Visualisation by Randi Bolt\n https://www.rbolt.me/\nSource: Basketball Reference \nLink: https://www.basketball-reference.com/\nDate:",date_today)

# put all variables in one list 
labels_raw_data <- list(team_name,
                        description,
                        caption)

# location of raw data 
location_of_labels_raw_data <- here::here("01_raw_data",
                                          "raw_data_labels.rds")

# save data
base::saveRDS(labels_raw_data, location_of_labels_raw_data)



