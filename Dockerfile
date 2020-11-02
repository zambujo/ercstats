FROM rocker/verse

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
remotes::install_github('r-lib/conflicted'); \
remotes::install_github('vincentarelbundock/countrycode'); \
remotes::install_github('leeper/csvy'); \
remotes::install_github('r-lib/fs'); \
remotes::install_github('davidsjoberg/ggbump'); \
remotes::install_github('rensa/ggflags'); \
remotes::install_github('slowkow/ggrepel'); \
remotes::install_github('r-lib/here'); \
remotes::install_github('jeroen/jsonlite'); \
remotes::install_github('r-lib/scales'); \
remotes::install_github('nset-ornl/wbstats'); \
remotes::install_github('viking/r-yaml');"
