FROM openjdk:11.0.8-slim-buster

ARG HOME_DIR=/home/daemon

# Installing base utilities and applications
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        make git git-lfs zip openssl ca-certificates apt-transport-https curl gnupg2 software-properties-common \
        net-tools openssh-client jq libc6-dev python3 python3-dev python3-setuptools python3-pip libsnappy1v5 libsnappy-dev \
    ; \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        docker-ce docker-ce-cli containerd.io \
    ; \
    rm -rf /var/lib/apt/lists/*

# Install Python packages: Pipenv, AWS CLI, Docker Compose
RUN pip3 install pipenv awscli docker-compose --upgrade

# Setting user home directory
RUN mkdir ${HOME_DIR}

# Creating SSH directory
RUN mkdir ${HOME_DIR}/.ssh

# Configuring ownership on home directory
RUN chown -R daemon:daemon ${HOME_DIR}
RUN chmod -R 0751 ${HOME_DIR}
RUN usermod --home ${HOME_DIR} daemon

# Adding custom scripts
COPY scripts/git_askpass.sh /usr/local/bin

USER daemon
