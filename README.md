# techpoc

This repository contains a poc (proof of concept) for certain technologies.
The goal of this poc is to create a build environment (local and CI/CD) for building a Toradex yocto image to get a foundation to lead a technical discussion about tools and processes.

Defined technologies and processes are:

* Github (https://github.com/ci4rail)
* Github Flow (https://guides.github.com/introduction/flow)
* docker as container runtime (https://docker.com)
* Concourse CI as CI/CD (https://concourse-ci.org)
* dobi for local builds (https://github.com/dnephin/dobi)
* bb-gitversion (https://github.com/elbb/bb-gitversion) as versioning tool
* ansible for infrastructure setup (https://ansible.com)
* sphinx as documentation tool (https://www.sphinx-doc.org)

## Prerequisites

-   dobi (<https://github.com/dnephin/dobi>) (use 0.13.0)
-   docker (<https://docs.docker.com/install/>)

## Local build and deploy

To build and deploy the toradex image, simply call the appropriate dobi resources.

```bash
./dobi.sh prepare-build-torizon-core-docker
./dobi.sh deploy
```

*Note: the seperated prepare and build/deploy steps are used to let the user decide which sources should be build, e.g. if the user has modifications those should be build. Another prepare step will resync will upstream repos.*