FROM rocker/tidyverse

# install R packages 
RUN Rscript -e "install.packages('devtools')"
Run Rscript -e "devtools::install_github('rbolt13/NBAcharts')"
Run Rscript -e "install.packages('here')"
Run Rscript -e "install.packages('rvest')"

# proj directory in container 
RUN mkdir /nba_proj

# copy contents of local folder to project folder in container 
COPY ./ /nba_proj/

# make R scripts executable 
RUN chmod +x /nba_proj/00_R/*.R

# set an enviroment variable 
ENV which_team="blazers"
ENV which_stat="PTS"

# make nba_proj the working directory 
WORKDIR /nba_proj 

# make container entery point bash
CMD make report

# says hello to 
CMD echo "Hello from your container!"