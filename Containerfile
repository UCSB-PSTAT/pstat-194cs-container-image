FROM ucsb/rstudio-base:latest

LABEL maintainer="LSIT Systems <lsitops@ucsb.edu>"

USER root

ENV TZ America/Los_Angeles
RUN apt update && \
    apt install -y texlive-full lmodern libbz2-dev nano && \
    apt clean && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN mamba install \
    keras \
    r-cherryblossom \
    r-fivethirtyeight \
    r-kableextra \
    r-keras \
    r-learnr \
    r-Lock5Data \
    r-mosaic \
    r-mosaiccore \
    r-mosaicdata \
    r-network \
    r-openintro \
    r-palmerpenguins \
    r-tensorflow \
    tensorflow-cpu && \
    /usr/local/bin/fix-permissions "${CONDA_DIR}" || true



RUN R -e 'devtools::install_github("hadley/emo")' && \
    R -e "install.packages(c('tutorial.helpers'), repos = 'https://cloud.r-project.org/', Ncpus = parallel::detectCores())"

USER $NB_USER

