FROM continuumio/miniconda3

RUN apt-get -qq update --yes \
 && apt-get -qq install --yes --no-install-recommends \
        postgresql-client \
        build-essential \
        libpq-dev \
        libgdal-dev \
        ca-certificates locales \
 && rm -rf /var/lib/apt/lists/*

#Set locale
RUN sed -i -e "s/# pt_BR.*/pt_BR.UTF-8 UTF-8/" /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=pt_BR.UTF-8

# Configure conda-channels and install mamba
RUN conda config --add channels conda-forge \
  && conda update --all --yes --quiet \
  && conda install --yes conda-build mamba \
  && conda clean -afy