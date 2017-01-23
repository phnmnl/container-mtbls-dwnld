FROM ubuntu:16.04

MAINTAINER Pierrick Roger (pierrick.roger@gmail.com)

ENV TOOL_VERSION=1.1.1
ENV CONTAINER_VERSION=1.1

LABEL version="${CONTAINER_VERSION}"
LABEL tool_version="${TOOL_VERSION}"

# Setup package repos
RUN echo "deb http://cran.univ-paris1.fr/bin/linux/ubuntu xenial/" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# Update and upgrade system
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y --no-install-recommends wget
RUN apt-get install -y --no-install-recommends r-base git make g++
RUN apt-get install -y --no-install-recommends libxml2-dev
RUN apt-get install -y --no-install-recommends libcurl4-openssl-dev
RUN apt-get install -y --no-install-recommends libnetcdf-dev
RUN apt-get install -y --no-install-recommends gfortran
RUN apt-get install -y --no-install-recommends liblapack-dev
RUN apt-get install -y --no-install-recommends libblas-dev
RUN echo 'options("repos"="http://cran.rstudio.com")' >> /etc/R/Rprofile.site
RUN R -e "install.packages(c('getopt'), dependencies = TRUE)"
RUN R -e "source('http://bioconductor.org/biocLite.R') ; biocLite('Risa')"

# Clone tool repos
RUN git clone -b release/${TOOL_VERSION} https://github.com/workflow4metabolomics/mtbls-dwnld /files/mtbls-dwnld

# Clean
RUN apt-get purge -y git
RUN apt-get clean
RUN apt-get autoremove -y
RUN rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/*

# Make tool accessible through PATH
ENV PATH=$PATH:/files/mtbls-dwnld

# Make test script accessible through PATH
ENV PATH=$PATH:/files/mtbls-dwnld/test

# Define Entry point script
ENTRYPOINT ["/files/mtbls-dwnld/mtbls-dwnld"]
