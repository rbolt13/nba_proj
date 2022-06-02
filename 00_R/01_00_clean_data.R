#' Clean Data 
#' 
#' @descritpion this file cleans the raw stats data and the 
#' raw colors data. 
#' 
#' @param raw_data_colors.rds is the raw color data which is
#' gathered in 00_R/00_01_scrape_colors_raw_data.R
#' 
#' @param raw_data_stats.rds is the raw stats data which is
#' gathered in 00_R/00_00_scrape_stats_data.R
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

# load data 
colors <- base::readRDS(location_of_colors_raw)
ttl_stat <- base::readRDS(location_of_stats_raw)

# clean stat data -----------------------------------
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

# select top 25% of players in this area
subset_data <- subset_data %>%
  dplyr::filter(stat >= base::unname(stats::quantile(subset_data$stat)))

# clean colors data ---------------------------------
# subset to df 17 
colors_table <- colors[[17]]

# rename column 2 to "hex"
base::names(colors_table)[2] <- "hex"

# subset just the hex 
hex_codes <- colors_table$hex

# color pallete 
col_pal <- colorRampPalette(hex_codes)(length(subset_data))

# save data ------------------------------------------
# Put all data into one list 
clean_data <- list(subset_data,
                   col_pal)

# location of raw data 
location_of_clean_data <- here::here("02_clean_data",
                                     "clean_data.rds")

# save data
base::saveRDS(clean_data, location_of_clean_data)
