# scrape stats raw data 
raw_data/stats: 00_R/00_00_scrape_stats_raw_data.R
	Rscript 00_R/00_00_scrape_stats_raw_data.R
  
# scrape colors raw data
raw_data/colors: 00_R/00_01_scrape_colors_raw_data.R
	Rscript 00_R/00_01_scrape_colors_raw_data.R
	
# labels raw raw_data
raw_data/labels: 00_R/00_02_labels_raw_data.R
	Rscript 00_R/00_02_labels_raw_data.R
	
# clean raw raw_data
clean_data/raw_data: 00_R/01_00_clean_data.R 00_R/00_00_scrape_stats_raw_data.R 00_R/00_01_scrape_colors_raw_data.R 01_raw_data/raw_data_colors.rds 01_raw_data/raw_data_stats.rds
	Rscript 00_R/01_00_clean_data.R
	
# save barchart to figs folder
figs/barchart.png: 00_R/02_00_barplot.R 02_clean_data/clean_data.rds
	Rscript 00_R/01_00_clean_data.R