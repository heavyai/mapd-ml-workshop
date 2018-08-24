FROM ubuntu:16.04
LABEL maintainer "Wamsi Viswanath [https://www.linkedin.com/in/wamsiv]"

ENV MAPD_ML=mapd-ml-cpu

#  Dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    build-essential \
    libopenblas-dev \
    bzip2 && \
    apt-get remove --purge -y && \
    rm -rf /var/lib/apt/lists/*

# Miniconda
WORKDIR /opt/conda

RUN wget --no-check-certificate https://repo.continuum.io/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh -O /opt/conda/miniconda3.sh
RUN bash /opt/conda/miniconda3.sh -b -p /opt/conda/Miniconda3
ENV PATH=$PATH:/opt/conda/Miniconda3/bin

# Create WorkDir
COPY . /mapd-ml-cpu
WORKDIR /mapd-ml-cpu

# Environment
RUN conda update conda && conda env create -n $MAPD_ML -f /mapd-ml-cpu/env/py36_test.yml

EXPOSE 8888

CMD bash ./utils/launch_notebooks.sh
