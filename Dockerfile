# Make sure this Docker file follow the PhenoMeNal Docker file guide at https://github.com/phnmnl/phenomenal-h2020/wiki/Dockerfile-Guide.
# Don't forget to update resource (CPU and memory) usage specifications in PhenoMeNal Galaxy container (see https://github.com/phnmnl/phenomenal-h2020/wiki/Setting-up-Galaxy-wrappers-on-PhenoMeNal-Galaxy-Container#tool-cpu-and-memory-usage-requests-and-limits) if necessary.

FROM ubuntu:16.04

MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

ENV TOOL_NAME=mtbls-dwnld
ENV TOOL_VERSION=3.1.1
ENV CONTAINER_VERSION=1.3
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
    apt-get install --no-install-recommends -y software-properties-common git wget unzip && \
    git clone --depth 1 --single-branch -b v${TOOL_VERSION} https://github.com/workflow4metabolomics/mtbls-dwnld /files/mtbls-dwnld && \
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
