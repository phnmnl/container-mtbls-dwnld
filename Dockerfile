# Make sure this Docker file follow the PhenoMeNal Docker file guide at https://github.com/phnmnl/phenomenal-h2020/wiki/Dockerfile-Guide.
# Don't forget to update resource (CPU and memory) usage specifications in PhenoMeNal Galaxy container (see https://github.com/phnmnl/phenomenal-h2020/wiki/Setting-up-Galaxy-wrappers-on-PhenoMeNal-Galaxy-Container#tool-cpu-and-memory-usage-requests-and-limits) if necessary.

FROM debian:stretch-slim

MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

ENV TOOL_NAME=mtbls-dwnld
ENV TOOL_VERSION=4.0.3
ENV CONTAINER_VERSION=2.0
ENV CONTAINER_GITHUB=https://github.com/phnmnl/container-mtbls-dwnld

LABEL version="${CONTAINER_VERSION}"
LABEL software.version="${TOOL_VERSION}"
LABEL software="${TOOL_NAME}"
LABEL base.image="ubuntu:16.04"
LABEL description="A downloader of Metabolights studies."
LABEL website="${CONTAINER_GITHUB}"
LABEL documentation="${CONTAINER_GITHUB}"
LABEL license="${CONTAINER_GITHUB}"
LABEL tags="Metabolomics"

# Update, install dependencies, clone repos and clean
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y software-properties-common git wget unzip python3 python3-setuptools python3-pip && \
    pip3 install wheel && \
    pip3 install isatools && \
    git clone --depth 1 --recursive --single-branch -b v${TOOL_VERSION} https://github.com/workflow4metabolomics/mtbls-dwnld /files/mtbls-dwnld && \
    apt-get purge -y git software-properties-common python3-pip python-setuptools && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/* && \
    wget https://download.asperasoft.com/download/sw/cli/3.7.7/aspera-cli-3.7.7.608.927cce8-linux-64-release.sh && \
    bash aspera-cli-3.7.7.608.927cce8-linux-64-release.sh

# Make tool accessible through PATH
ENV PATH=$PATH:/files/mtbls-dwnld:/root/.aspera/cli/bin

# Make test script accessible through PATH
RUN echo "#!/bin/bash" >/files/test-mtbls-dwnld
RUN echo "testthat.sh /files/mtbls-dwnld/test/test-mtbls-dwnld.sh" >>/files/test-mtbls-dwnld
RUN chmod u+x /files/test-mtbls-dwnld
ENV PATH=$PATH:/files:/files/mtbls-dwnld/bash-testthat

# Define Entry point script
ENTRYPOINT ["/files/mtbls-dwnld/mtbls-dwnld"]
