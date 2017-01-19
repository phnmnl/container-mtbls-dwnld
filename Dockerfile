FROM ubuntu:16.04

MAINTAINER Pierrick Roger (pierrick.roger@gmail.com)

ENV TOOL_VERSION=1.0.0
ENV CONTAINER_VERSION=1.0

LABEL version="${CONTAINER_VERSION}"
LABEL tool_version="${TOOL_VERSION}"

# Update system
RUN apt-get update
RUN apt-get install -y --no-install-recommends r-base git

# Clone tool repos
RUN git clone -b release/${TOOL_VERSION} https://github.com/workflow4metabolomics/mtbls-dwnld /files/mtbls-dwnld

# Install requirements
RUN echo 'options("repos"="http://cran.rstudio.com")' >> /etc/R/Rprofile.site
RUN R -e "install.packages(c('getopt'), dependencies = TRUE)"
RUN R -e "source('http://bioconductor.org/biocLite.R') ; biocLite('Risa')"

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
