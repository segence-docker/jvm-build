FROM openjdk:8u181-jdk-slim

ARG DIST=debian
ARG AWS_CLI_VERSION=1.16.61
ARG DOCKER_COMPOSE_VERSION=1.23.1

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    gnupg2

RUN curl -fsSL https://download.docker.com/linux/${DIST}/gpg | apt-key add -

RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/${DIST} \
    $(lsb_release -cs) \
    stable"

RUN apt-get update && apt-get install -y \
    make \
    net-tools \
    docker-ce \
    python-pip \
&& rm -rf /var/lib/apt/lists/*

RUN curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

RUN pip --no-cache-dir install awscli==${AWS_CLI_VERSION}
