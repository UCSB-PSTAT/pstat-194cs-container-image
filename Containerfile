FROM ucsb/rstudio-base:latest

LABEL maintainer="LSIT Systems <lsitops@ucsb.edu>"

USER root

ENV TZ America/Los_Angeles
RUN apt update && \
    apt install -y texlive-full lmodern libbz2-dev nano && \
    apt clean && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN pip install tensorflow-cpu

RUN conda install \
    keras \
    r-car \
    r-cardata \
    r-ape \
    r-dbi \
    r-dbplyr \
    r-dt \
    r-fivethirtyeight \
    r-gargle \
    r-ggally \
    r-ggraph \
    r-igraph \
    r-kableextra \
    r-keras \
    r-knitr \
    r-leaflet \
    r-learnr \
    r-mass \
    r-mosaic \
    r-mosaiccore \
    r-mosaicdata \
    r-network \
    r-rcolorbrewer \
    r-rmarkdown \
    r-rsqlite \
    r-skimr \
    r-statnet \
    r-tensorflow \
    r-tidygraph \
    r-tidyverse && \
    /usr/local/bin/fix-permissions "${CONDA_DIR}" || true



RUN R -e 'devtools::install_github("hadley/emo")' && \
    R -e "install.packages(c('cherryblossom', 'igraphdata', 'Lock5Data', 'openintro', 'palmerpenguins', 'tutorial.helpers'), repos = 'https://cloud.r-project.org/', Ncpus = parallel::detectCores())"

USER $NB_USER

