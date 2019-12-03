FROM openjdk:8u212-jdk-alpine

ARG HOME_DIR=/home/daemon

# Installing base utilities and applications
RUN apk add --no-cache bash make git git-lfs zip openssl ca-certificates shadow openssh \
                       jq docker libffi-dev openssl-dev gcc libc-dev protobuf gcompat snappy g++ snappy-dev

# Installing Python 3
RUN apk add --no-cache python3 python3-dev && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

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
