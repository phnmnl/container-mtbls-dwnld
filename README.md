<!-- Guidance: see https://github.com/phnmnl/phenomenal-h2020/wiki/The-Guideline-for-Container-GitHub-Respository-README.md-Creation -->

![Logo](w4m.png)

# W4M Metabolights Downloader
Version: 3.1.0

## Short description

<!-- 
This should only be 20 to 40 words, hopefully a single sentence.
-->

Metabolights downloader

## Description

The module downloads a Metabolights study and output data in the W4M 3 files format:

 - Sample metadata.
 - Variable metadata.
 - Sample x variable matrix.

## Key features

- Data import.

## Functionality

- Other Tools.

## Approaches

- Metabolomics / Targeted
- Metabolomics / Untargeted

## Instrument Data Types

- MS
- NMR

## Screenshots

## Tool Authors

- Pierrick Roger (CEA).

## Container Contributors

- Pierrick Roger (CEA).

## Website

- http://workflow4metabolomics.org

## Git Repository

- https://github.com/phnmnl/container-mtbls-dwnld.git

## Installation 

For local individual installation:

```bash
docker pull container-registry.phenomenal-h2020.eu/phnmnl/mtbls-dwnld
```

## Usage Instructions

For direct docker usage:
```bash
docker run container-registry.phenomenal-h2020.eu/phnmnl/mtbls-dwnld -h
```
### Networking considerations

The networking needs to allow UDP connections with source port 33001 to the container for the fast Aspera download. This is the case for most commercial cloud providers, including Amazon AWS and Google GCP, but some local installations might have additional firewall rules in place. See also https://test-connect.asperasoft.com/ for more information. If these connections are not allowed, the fallback to the wget download via is still possible.	    

## Publications

<!-- Guidance:
Use AMA style publications as a list (you can export AMA from PubMed, on the Formats: Citation link when looking at the entry).
-->

 - González-beltrán A, Neumann S, Maguire E, Sansone SA, Rocca-serra P. The Risa R/Bioconductor package: integrative data analysis from experimental metadata and back again. BMC Bioinformatics. 2014;15 Suppl 1:S11.
 - Giacomoni F, Le corguillé G, Monsoor M, et al. Workflow4Metabolomics: a collaborative research infrastructure for computational metabolomics. Bioinformatics. 2015;31(9):1493-5.
