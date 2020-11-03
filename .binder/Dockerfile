FROM rocker/binder:4.0.2
LABEL maintainer='Joao Martins'

USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}

USER ${NB_USER}

RUN wget https://github.com/zambujo/ercstats/raw/main/DESCRIPTION && R -e "options(repos = list(CRAN = 'http://mran.revolutionanalytics.com/snapshot/2020-03-16/')); devtools::install_deps()"

USER root

RUN rm DESCRIPTION.1

USER ${NB_USER}

RUN exit 0