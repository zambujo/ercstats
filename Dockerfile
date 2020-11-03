FROM rocker/verse
LABEL maintainer='Joao Martins'

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

# create an R user 
ENV USER rstudio

COPY ./README.md /home/$USER/
COPY ./LICENSE /home/$USER/
COPY ./data /home/$USER/data
COPY ./R /home/$USER/R
COPY ./notebooks /home/$USER/notebooks
COPY ./docs /home/$USER/docs
