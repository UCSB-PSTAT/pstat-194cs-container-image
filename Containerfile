FROM ucsb/rstudio-base:latest

LABEL maintainer="LSIT Systems <lsitops@ucsb.edu>"

USER root

ENV TZ America/Los_Angeles
RUN apt update && \
    apt install -y texlive-full lmodern libbz2-dev nano && \
    apt clean && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN conda install \
    keras \
    r-ape \
    r::r-cherryblossom \
    r-dt \
    r-fivethirtyeight \
    r-ggraph \
    r-igraph \
    r::r-igraphdata \
    r-kableextra \
    r-keras \
    r-learnr \
    r::r-lock5data \
    r-mosaic \
    r-mosaiccore \
    r-mosaicdata \
    r-network \
    r::r-openintro \
    r-palmerpenguins \
    r-statnet \
    r-tensorflow \
    r-tidygraph \
    tensorflow-cpu && \
    /usr/local/bin/fix-permissions "${CONDA_DIR}" || true



RUN R -e 'devtools::install_github("hadley/emo")' && \
    R -e "install.packages(c('tutorial.helpers'), repos = 'https://cloud.r-project.org/', Ncpus = parallel::detectCores())"

USER $NB_USER

