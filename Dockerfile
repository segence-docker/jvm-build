FROM openjdk:8u191-jdk-alpine

ARG HOME_DIR=/home/daemon

# Installing base utilities and applications
RUN apk add --no-cache make git openssl ca-certificates shadow openssh jq docker libffi-dev openssl-dev gcc libc-dev

# Installing Python 3
RUN apk add --no-cache python3 python3-dev && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

# Install AWS CLI and Docker Compose
RUN pip3 install awscli docker-compose --upgrade

# Setting user home directory
RUN mkdir ${HOME_DIR}

# Creating SSH directory
RUN mkdir ${HOME_DIR}/.ssh

# Configuring ownership on home directory
RUN chown -R daemon:daemon ${HOME_DIR}
RUN chmod -R 0751 ${HOME_DIR}
RUN usermod --home ${HOME_DIR} daemon

USER daemon
