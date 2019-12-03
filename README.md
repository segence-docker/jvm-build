Segence JVM build container
===========================

# Overview

A Docker container to build JVM-based and Python projects.

It comes with:
- JDK 8
- Python 3
- Git
- Docker and Docker Compose
- The [make](https://www.gnu.org/software/make/) utility
- The [AWS CLI](https://docs.aws.amazon.com/cli/index.html#lang/en_us) utility
- The [Pipenv](https://pipenv.kennethreitz.org) utility

It can be used as a base build image in CI tools.

There is also a Jenkinc CI compatible image available (with the tag having a `-jenkins` suffix) where the UID of the user `daemon` is set to `1000` to be compatible with the relevant [Jenkins Docker configuration](https://github.com/jenkinsci/docker/blob/master/Dockerfile#L7).

# Using with HTTP Git credentials

In order to use a Git repository with a HTTP URL launch the Docker container with the following environment variables:
- `GIT_ASKPASS` pointing to the `git_askpass.sh` script that is already on the `PATH`
- `GIT_USERNAME`, that is set to the Git repository username
- `GIT_PASSWORD`, that is set to the Git repository password

Example: `docker run --env GIT_ASKPASS=git_askpass.sh --env GIT_USERNAME=... --env GIT_PASSWORD=... segence/jvm-build sh`
