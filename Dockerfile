FROM ubuntu:16.04

MAINTAINER Pierrick Roger (pierrick.roger@gmail.com)

ENV TOOL_VERSION=1.1.4
ENV CONTAINER_VERSION=1.1

LABEL version="${CONTAINER_VERSION}"
LABEL tool_version="${TOOL_VERSION}"

# Setup package repos
RUN echo "deb http://cran.univ-paris1.fr/bin/linux/ubuntu xenial/" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# Update, install dependencies, clone repos and clean
RUN apt-get update && \
    apt-get install -y --no-install-recommends apt-utils \
                                               wget \
                                               r-base git make g++ \
                                               libxml2-dev \
                                               libcurl4-openssl-dev \
                                               libnetcdf-dev \
                                               gfortran \
                                               liblapack-dev \
                                               libblas-dev && \
	R -e "install.packages(c('getopt'), repos = 'http://cran.rstudio.com', dependencies = TRUE)" && \
    R -e "source('http://bioconductor.org/biocLite.R') ; biocLite('Risa')" && \
    git clone -b release/${TOOL_VERSION} https://github.com/workflow4metabolomics/mtbls-dwnld /files/mtbls-dwnld && \
    apt-get purge -y git make g++ gfortran && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/*

# Make tool accessible through PATH
ENV PATH=$PATH:/files/mtbls-dwnld

# Make test script accessible through PATH
ENV PATH=$PATH:/files/mtbls-dwnld/test

# Define Entry point script
ENTRYPOINT ["/files/mtbls-dwnld/mtbls-dwnld"]
