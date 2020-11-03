FROM rocker/verse
LABEL maintainer='Joao Martins'

# for rocker 
ENV USER rstudio

COPY ./README.md /home/$USER/
COPY ./DESCRIPTION /home/$USER/
COPY ./LICENSE /home/$USER/
COPY ./data /home/$USER/data
COPY ./R /home/$USER/R
COPY ./notebooks /home/$USER/notebooks
COPY ./docs /home/$USER/docs

# RUN apt-get update -y && \
# 	apt-get install -y \ 
# 	curl

RUN wget https://github.com/zambujo/ercstats/raw/main/DESCRIPTION && \
R -e "install.packages('remotes'); \
remotes::install_deps()"
