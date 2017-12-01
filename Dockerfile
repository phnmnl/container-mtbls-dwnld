FROM ubuntu:14.04

MAINTAINER Pierrick Roger <pk.roger@icloud.com>

ENV TOOL_VERSION=3.0.1
ENV CONTAINER_VERSION=1.2

LABEL version="${CONTAINER_VERSION}"
LABEL tool_version="${TOOL_VERSION}"

# Update, install dependencies, clone repos and clean
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y software-properties-common git wget unzip && \
    git clone --depth 1 --single-branch -b release/${TOOL_VERSION} https://github.com/workflow4metabolomics/mtbls-dwnld /files/mtbls-dwnld && \
    apt-get purge -y git software-properties-common && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/* && \
    wget http://download.asperasoft.com/download/sw/ascp-client/3.5.4/ascp-install-3.5.4.102989-linux-64.sh && \
    bash ascp-install-3.5.4.102989-linux-64.sh

# Make tool accessible through PATH
ENV PATH=$PATH:/files/mtbls-dwnld

# Make test script accessible through PATH
ENV PATH=$PATH:/files/mtbls-dwnld/test

# Define Entry point script
ENTRYPOINT ["/files/mtbls-dwnld/mtbls-dwnld"]
