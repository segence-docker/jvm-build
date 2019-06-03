Segence JVM build container
===========================

A Docker container to build JVM-based and Python projects.

It comes with:
- JDK 8
- Python 3
- Git
- Docker and Docker Compose
- The [make](https://www.gnu.org/software/make/) utility
- The [AWS CLI](https://docs.aws.amazon.com/cli/index.html#lang/en_us) utility

It can be used as a base build image in CI tools.

There is also a Jenkinc CI compatible image available (with the tag having a `-jenkins` suffix) where the UID of the user `daemon` is set to `1000` to be compatible with the relevant [Jenkins Docker configuration](https://github.com/jenkinsci/docker/blob/master/Dockerfile#L7).
