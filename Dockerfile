FROM rocker/verse

RUN mkdir /home/analysis
RUN mkdir /home/analysis/R
RUN mkdir /home/analysis/notebooks
RUN mkdir /home/analysis/data

################
#install linux deps
################

RUN apt-get update -y && \
	apt-get install -y \ 
		curl

################
#install R packages
################

RUN R -e "install.packages('remotes'); \
install.packages('conflicted'); \
install.packages('countrycode'); \
install.packages('csvy'); \
install.packages('fs'); \
install.packages('ggbump'); \
install.packages('ggrepel'); \
install.packages('here'); \
install.packages('jsonlite'); \
install.packages('scales'); \
install.packages('yaml'); \
remotes::install_github('rensa/ggflags'); \
remotes::install_github('nset-ornl/wbstats');"

COPY R/*.R /home/analysis/R/
COPY notebooks/*.Rmd /home/analysis/notebooks/
COPY data/*.rds /home/analysis/data/
