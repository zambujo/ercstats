FROM rocker/binder:4.0.2
LABEL maintainer='Joao Martins'

USER root
COPY . ${HOME}
RUN chown -R ${NB_USER}:${NB_USER} ${HOME}
USER ${NB_USER}

RUN apt-get update -y && \
	apt-get install -y \ 
	curl

RUN wget https://github.com/zambujo/ercstats/raw/main/DESCRIPTION && \
R -e "install.packages('remotes'); \
remotes::install_deps()"

# ENV USER rstudio
RUN rm DESCRIPTION; exit 0
