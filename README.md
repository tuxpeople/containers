<!---
NOTE: AUTO-GENERATED FILE
to edit this file, instead edit its template at: ./github/scripts/templates/README.md.j2
-->
<div align="center">


## Containers

_An opinionated collection of container images_

</div>

<div align="center">

![GitHub Repo stars](https://img.shields.io/github/stars/tuxpeople/containers?style=for-the-badge)
![GitHub forks](https://img.shields.io/github/forks/tuxpeople/containers?style=for-the-badge)
![GitHub Workflow Status (with event)](https://img.shields.io/github/actions/workflow/status/tuxpeople/containers/release-scheduled.yaml?style=for-the-badge&label=Scheduled%20Release)

</div>

Welcome to our container images, if looking for a container start by [browsing the GitHub Packages page for this repo's packages](https://github.com/tuxpeople?tab=packages&repo_name=containers).

## Mission statement

The goal of this project is to support [semantically versioned](https://semver.org/), [rootless](https://rootlesscontaine.rs/), and [multiple architecture](https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/) containers for various applications.

We also try to adhere to a [KISS principle](https://en.wikipedia.org/wiki/KISS_principle), logging to stdout, [one process per container](https://testdriven.io/tips/59de3279-4a2d-4556-9cd0-b444249ed31e/), no [s6-overlay](https://github.com/just-containers/s6-overlay) and all images are built on top of [Alpine](https://hub.docker.com/_/alpine) or [Ubuntu](https://hub.docker.com/_/ubuntu).

## Tag immutability

The containers built here do not use immutable tags, as least not in the more common way you have seen from [linuxserver.io](https://fleet.linuxserver.io/) or [Bitnami](https://bitnami.com/stacks/containers).

We do take a similar approach but instead of appending a `-ls69` or `-r420` prefix to the tag we instead insist on pinning to the sha256 digest of the image, while this is not as pretty it is just as functional in making the images immutable.

| Container                                          | Immutable |
|----------------------------------------------------|-----------|
| `registry.eighty-three.me/tuxpeople/sonarr:rolling`                   | ❌         |
| `registry.eighty-three.me/tuxpeople/sonarr:3.0.8.1507`                | ❌         |
| `registry.eighty-three.me/tuxpeople/sonarr:rolling@sha256:8053...`    | ✅         |
| `registry.eighty-three.me/tuxpeople/sonarr:3.0.8.1507@sha256:8053...` | ✅         |

_If pinning an image to the sha256 digest, tools like [Renovate](https://github.com/renovatebot/renovate) support updating the container on a digest or application version change._

## Passing arguments to a application

Some applications do not support defining configuration via environment variables and instead only allow certain config to be set in the command line arguments for the app. To circumvent this, for applications that have an `entrypoint.sh` read below.

1. First read the Kubernetes docs on [defining command and arguments for a Container](https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/).
2. Look up the documentation for the application and find a argument you would like to set.
3. Set the argument in the `args` section, be sure to include `entrypoint.sh` as the first arg and any application specific arguments thereafter.

    ```yaml
    args:
      - /entrypoint.sh
      - --port
      - "8080"
    ```

## Configuration volume

For applications that need to have persistent configuration data the config volume is hardcoded to `/config` inside the container. This is not able to be changed in most cases.

## Available Images

Each Image will be built with a `rolling` tag, along with tags specific to it's version. Available Images Below

Container | Channel | Image | Latest Tags
--- | --- | --- | ---
[alertmanager-discord](https://github.com/tuxpeople/containers/pkgs/container/alertmanager-discord) | main | registry.eighty-three.me/tuxpeople/alertmanager-discord |![git-89ef841](https://img.shields.io/badge/git--89ef841-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[ansible](https://github.com/tuxpeople/containers/pkgs/container/ansible) | main | registry.eighty-three.me/tuxpeople/ansible |![11](https://img.shields.io/badge/11-blue?style=flat-square) ![11.8](https://img.shields.io/badge/11.8-blue?style=flat-square) ![11.8.0](https://img.shields.io/badge/11.8.0-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[bedrockifier](https://github.com/tuxpeople/containers/pkgs/container/bedrockifier) | main | registry.eighty-three.me/tuxpeople/bedrockifier |![latest](https://img.shields.io/badge/latest-green?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[buildah_rootless](https://github.com/tuxpeople/containers/pkgs/container/buildah_rootless) | main | registry.eighty-three.me/tuxpeople/buildah_rootless |![1](https://img.shields.io/badge/1-blue?style=flat-square) ![1.40](https://img.shields.io/badge/1.40-blue?style=flat-square) ![1.40.1](https://img.shields.io/badge/1.40.1-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[busycurl]() | main | registry.eighty-three.me/tuxpeople/busycurl |
[droopy](https://github.com/tuxpeople/containers/pkgs/container/droopy) | main | registry.eighty-three.me/tuxpeople/droopy |![git-7a9c7bc](https://img.shields.io/badge/git--7a9c7bc-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[feeder](https://github.com/tuxpeople/containers/pkgs/container/feeder) | main | registry.eighty-three.me/tuxpeople/feeder |![0](https://img.shields.io/badge/0-blue?style=flat-square) ![0.0](https://img.shields.io/badge/0.0-blue?style=flat-square) ![0.0.1](https://img.shields.io/badge/0.0.1-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[grafana-reporter](https://github.com/tuxpeople/containers/pkgs/container/grafana-reporter) | main | registry.eighty-three.me/tuxpeople/grafana-reporter |![2](https://img.shields.io/badge/2-blue?style=flat-square) ![2.3](https://img.shields.io/badge/2.3-blue?style=flat-square) ![2.3.1](https://img.shields.io/badge/2.3.1-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[image-syncer](https://github.com/tuxpeople/containers/pkgs/container/image-syncer) | main | registry.eighty-three.me/tuxpeople/image-syncer |![1](https://img.shields.io/badge/1-blue?style=flat-square) ![1.5](https://img.shields.io/badge/1.5-blue?style=flat-square) ![1.5.5](https://img.shields.io/badge/1.5.5-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[imgpkg](https://github.com/tuxpeople/containers/pkgs/container/imgpkg) | main | registry.eighty-three.me/tuxpeople/imgpkg |![0](https://img.shields.io/badge/0-blue?style=flat-square) ![0.46](https://img.shields.io/badge/0.46-blue?style=flat-square) ![0.46.1](https://img.shields.io/badge/0.46.1-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[kubernetes-main](https://github.com/tuxpeople/containers/pkgs/container/kubernetes-main) | main | registry.eighty-three.me/tuxpeople/kubernetes-main |![1](https://img.shields.io/badge/1-blue?style=flat-square) ![1.33](https://img.shields.io/badge/1.33-blue?style=flat-square) ![1.33.3](https://img.shields.io/badge/1.33.3-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[openvpn](https://github.com/tuxpeople/containers/pkgs/container/openvpn) | main | registry.eighty-three.me/tuxpeople/openvpn |![latest](https://img.shields.io/badge/latest-green?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[rtfctl](https://github.com/tuxpeople/containers/pkgs/container/rtfctl) | main | registry.eighty-three.me/tuxpeople/rtfctl |![1](https://img.shields.io/badge/1-blue?style=flat-square) ![1.0](https://img.shields.io/badge/1.0-blue?style=flat-square) ![1.0.92](https://img.shields.io/badge/1.0.92-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[s3-backup-restore](https://github.com/tuxpeople/containers/pkgs/container/s3-backup-restore) | main | registry.eighty-three.me/tuxpeople/s3-backup-restore |![git-62c88f9](https://img.shields.io/badge/git--62c88f9-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[tautulli-exporter](https://github.com/tuxpeople/containers/pkgs/container/tautulli-exporter) | main | registry.eighty-three.me/tuxpeople/tautulli-exporter |![0](https://img.shields.io/badge/0-blue?style=flat-square) ![0.1](https://img.shields.io/badge/0.1-blue?style=flat-square) ![0.1.0](https://img.shields.io/badge/0.1.0-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[tcp-proxy](https://github.com/tuxpeople/containers/pkgs/container/tcp-proxy) | main | registry.eighty-three.me/tuxpeople/tcp-proxy |![1](https://img.shields.io/badge/1-blue?style=flat-square) ![1.1](https://img.shields.io/badge/1.1-blue?style=flat-square) ![1.1.1](https://img.shields.io/badge/1.1.1-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[tinysyslog](https://github.com/tuxpeople/containers/pkgs/container/tinysyslog) | main | registry.eighty-three.me/tuxpeople/tinysyslog |![2](https://img.shields.io/badge/2-blue?style=flat-square) ![2.0](https://img.shields.io/badge/2.0-blue?style=flat-square) ![2.0.0](https://img.shields.io/badge/2.0.0-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[tooler](https://github.com/tuxpeople/containers/pkgs/container/tooler) | main | registry.eighty-three.me/tuxpeople/tooler |![git-e0fc44f](https://img.shields.io/badge/git--e0fc44f-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[vmware_exporter](https://github.com/tuxpeople/containers/pkgs/container/vmware_exporter) | main | registry.eighty-three.me/tuxpeople/vmware_exporter |![0](https://img.shields.io/badge/0-blue?style=flat-square) ![0.18](https://img.shields.io/badge/0.18-blue?style=flat-square) ![0.18.4](https://img.shields.io/badge/0.18.4-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)


## Contributing

1. Install [Docker](https://docs.docker.com/get-docker/), [Taskfile](https://taskfile.dev/) & [Cuelang](https://cuelang.org/)
2. Get familiar with the structure of the repository
3. Find a similar application in the apps directory
4. Copy & Paste an application and update the directory name
5. Update `metadata.json`, `Dockerfile`, `ci/latest.sh`, `ci/goss.yaml` and make it suit the application build
6. Include any additional files if required
7. Use Taskfile to build and test your image

    ```ruby
    task APP=sonarr CHANNEL=main test
    ```

### Automated tags

Here's an example of how tags are created in the GitHub workflows, be careful with `metadata.json` as it does affect the outcome of how the tags will be created when the application is built.

| Application | Channel   | Stable  | Base    | Generated Tag               |
|-------------|-----------|---------|---------|-----------------------------|
| `ubuntu`    | `focal`   | `true`  | `true`  | `ubuntu:focal-rolling`      |
| `ubuntu`    | `focal`   | `true`  | `true`  | `ubuntu:focal-19880312`     |
| `alpine`    | `3.16`    | `true`  | `true`  | `alpine:rolling`            |
| `alpine`    | `3.16`    | `true`  | `true`  | `alpine:3.16.0`             |
| `sonarr`    | `develop` | `false` | `false` | `sonarr-develop:3.0.8.1538` |
| `sonarr`    | `develop` | `false` | `false` | `sonarr-develop:rolling`    |
| `sonarr`    | `main`    | `true`  | `false` | `sonarr:3.0.8.1507`         |
| `sonarr`    | `main`    | `true`  | `false` | `sonarr:rolling`            |

## Deprecations

Containers here can be **deprecated** at any point, this could be for any reason described below.

1. The upstream application is **no longer actively developed**
2. The upstream application has an **official upstream container** that follows closely to the mission statement described here
3. The upstream application has been **replaced with a better alternative**
4. The **maintenance burden** of keeping the container here **is too bothersome**

**Note**: Deprecated containers will remained published to this repo for 6 months after which they will be pruned.
## Credits

A lot of inspiration and ideas are thanks to the hard work of [hotio.dev](https://hotio.dev/) and [linuxserver.io](https://www.linuxserver.io/) contributors.
