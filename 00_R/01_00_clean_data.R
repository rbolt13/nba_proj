#' Clean Data 
#' 
#' @descritpion this file cleans the raw stats data,  the raw
#' colors data, and raw label data.  
#' 
#' @param raw_data_colors.rds is the raw color data which is
#' gathered in 00_R/00_01_scrape_colors_raw_data.R
#' 
#' @param raw_data_stats.rds is the raw stats data which is
#' gathered in 00_R/00_00_scrape_stats_data.R
#' 
#' @param raw_data_labels.rds is the raw label data is is 
#' gather in 00_R/00_02_labels_raw_data.R
#' 
#' @return a .rds file with all the clean data in one list. 

# location of this file 
here::i_am("00_R/01_00_clean_data.R")

# get envierment variable to determine what stat to look at 
which_stat <- Sys.getenv("which_stat")

# libraries 
library(magrittr)
library(dplyr)

# location of data 
location_of_stats_raw <- here::here("01_raw_data",
                                    "raw_data_stats.rds")
location_of_colors_raw <- here::here("01_raw_data",
                                     "raw_data_colors.rds")
location_of_labels_raw <- here::here("01_raw_data",
                                     "raw_data_labels.rds")

# load data 
colors <- base::readRDS(location_of_colors_raw)
ttl_stat <- base::readRDS(location_of_stats_raw)
labels <- base::readRDS(location_of_labels_raw)

# clean stat data -----------------------------------
# subset dataframe 
ttl_stat <- ttl_stat[[1]]

# rename column 2 to "Name"
base::names(ttl_stat)[2] <- "Name"

# Replace NA valuse with 0 (for stats)
ttl_stat[base::is.na(ttl_stat)] <- 0

# subset clean stat data ----------------------------
# subset Name and which_stat
subset_data <- ttl_stat %>%
  dplyr::select(Name, which_stat) %>%
  dplyr::rename(Name = Name,
                stat = which_stat) 

# remove last row
subset_data <- head(subset_data, -1)

# select top 25% of players in this area
subset_data <- subset_data %>%
  dplyr::filter(stat >= base::unname(stats::quantile(subset_data$stat))[4])

# clean colors data ---------------------------------
# subset to df 17 
colors_table <- colors[[17]]

# rename column 2 to "hex"
base::names(colors_table)[2] <- "hex"

# subset just the hex 
hex_codes <- colors_table$hex

# color palette 
col_pal <- colorRampPalette(hex_codes)(length(subset_data$Name))

# ring labels ----------------------------------------
# get max stat 
max_stat <- base::max(subset_data$stat)
# if else statement for ring sizes 
if(max_stat > 50){
  ring_scale <- plyr::round_any(max_stat/3, 10)
  ring_inner <- ring_scale + 10
  ring_middle <- 2*ring_scale + 10 
  ring_outer <- 3*ring_scale + 10
  ringlab_inner <- base::as.character(ring_scale)
  ringlab_middle <- base::as.character(2*ring_scale)
  ringlab_outer <- base::as.character(3*ring_scale)
}else if(max_stat <= 50 && max_stat > 10){
  ring_scale <- plyr::round_any(max_stat/3, 1)
  ring_inner <- ring_scale + 5
  ring_middle <- 2*ring_scale + 5 
  ring_outer <- 3*ring_scale + 5
  ringlab_inner <- base::as.character(ring_scale)
  ringlab_middle <- base::as.character(2*ring_scale)
  ringlab_outer <- base::as.character(3*ring_scale)
}else if(max_stat <= 10 && max_stat > 1){
  ring_scale <- plyr::round_any(max_stat/3, .1)
  ring_inner <- ring_scale + 2
  ring_middle <- 2*ring_scale + 2 
  ring_outer <- 3*ring_scale + 2
  ringlab_inner <- base::as.character(ring_scale)
  ringlab_middle <- base::as.character(2*ring_scale)
  ringlab_outer <- base::as.character(3*ring_scale)
}else if(max_stat <= 1){
  ring_scale <- plyr::round_any(max_stat/3, .05)
  ring_inner <- ring_scale + .05
  ring_middle <- 2*ring_scale + .05 
  ring_outer <- 3*ring_scale + .05
  ringlab_inner <- base::as.character(ring_scale)
  ringlab_middle <- base::as.character(2*ring_scale)
  ringlab_outer <- base::as.character(3*ring_scale)
}

ring_labels <- list(ring_scale, 
                    ring_inner,
                    ring_middle,
                    ring_outer,
                    ringlab_inner,
                    ringlab_middle,
                    ringlab_outer)

# rename columns for NBAcharts package ----------------
base::names(subset_data)[1] <- "player"
base::names(subset_data)[2] <- "data"

# save data ------------------------------------------
# Put all data into one list 
clean_data <- list(subset_data,
                   col_pal,
                   labels,
                   ring_labels)

# location of raw data 
location_of_clean_data <- here::here("02_clean_data",
                                     "clean_data.rds")

# save data
base::saveRDS(clean_data, location_of_clean_data)
