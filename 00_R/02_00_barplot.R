#' Barplot 
#' 
#' @description this file uses 02_clean_data/clean_data.rds
#' to create circular barplots. 
#' 
#' @param clean_data.rds includes: 
#' 1. subset data with "player" and "data" as column headers. 
#' 2. color pallette 
#' 3. labels which inclues: team name, subtitle, caption. 
#' 4. ring labales: ring scales 
#' and can be found: 00_R/01_00_clean_data.R. 
#' 
#' @return a .png barchat in the figs folder. 

# location of this file
here::i_am("00_R/02_00_barplot.R")

# libaraies
library(NBAcharts)
library(plyr)
# location of data 
location_of_clean_data <- here::here("02_clean_data",
                                     "clean_data.rds")
# load data 
clean_data <- base::readRDS(location_of_clean_data)[[1]]
colors <- base::readRDS(location_of_clean_data)[[2]]
labels <- base::readRDS(location_of_clean_data)[[3]]
ring_labels <- base::readRDS(location_of_clean_data)[[4]]

# circ_col_chart
circ_col_chart(player_data = clean_data,
               ring_scale = ring_labels[[1]],
               ring_inner = ring_labels[[2]],
               ring_middle = ring_labels[[3]],
               ring_outer = ring_labels[[4]],
               ringlab_inner = ring_labels[[5]],
               ringlab_middle = ring_labels[[6]],
               ringlab_outer = ring_labels[[7]],
               col_pal = colors,
               chart_title = labels[[1]],
               chart_subtitle = labels[[2]],
               chart_source = labels[[3]],
               cc_chart_filename = c("../03_figs/barchart.png"))