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


## Local build and deploy

### Prerequisites

-   dobi (<https://github.com/dnephin/dobi>) (use 0.13.0)
-   docker (<https://docs.docker.com/install/>)

### Usage

To build and deploy the toradex image, simply call the appropriate dobi resources.

```bash
./dobi.sh prepare-build-torizon-core-docker
./dobi.sh deploy
```

*Note: the seperated prepare and build/deploy steps are used to let the user decide which sources should be build, e.g. if the user has modifications those should be build. Another prepare step will resync will upstream repos.*

## CI/CD build and deploy

### Prerequisites

-   Concourse CI, MinIO and Harbor e.g. via local-dev-environment (<https://github.com/ci4rail/local-dev-environment>)
-   docker (<https://docs.docker.com/install/>)

### Usage

To build and deploy the toradex image, you must set the pipeline to the concourse CI server.

First download `fly` from your concoruse server. The following example uses a local concourse server that is reachable at https://localhost:9000.

```bash
sudo wget http://localhost:9090/api/v1/cli?arch=amd64&platform=linux -O /usr/local/bin/fly
sudo chmod +x /usr/local/bin/
```

Then login to your concourse instance.

```bash
fly --target local login --concourse-url http://localhost:9090 -u <user> -p <password>
```

You can copy `ci/config.yaml` and `ci/credentials.template.yaml` and adapt it to your needs. 

```bash
cp ci/config.yaml ci/config.local.yaml
cp ci/credentials.template.yaml ci/credentials.yaml
```

*Note: `ci/config.yaml` is the production configuration. So if you want to test something out, use `ci/config.local.yaml`*

*Note: `ci/credentials.yaml` is ignored by git. in this file you can store access credentials and keys that won't be checked in.*

After you set your config and credentials files you are ready to deploy the pipeline to concourse.

```bash
fly -t local set-pipeline -c pipeline.yaml -p techpoc -l ci/config.local.yaml -l ci/credentials.yaml
```

Once the pipeline is set you can unpause it either via the web interface or via fly.

```bash
fly -t local unpause-pipeline -p techpoc
```

For further help on fly usage please refer to the [fly documentation](https://concourse-ci.org/fly.html).
