FROM node:latest

MAINTAINER Tim Brandin "tim.brandin@studiointeract.se"

RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get install --no-install-recommends -y -q curl python build-essential git ca-certificates

ENV PHANTOM_JS_VERSION 1.9.7-linux-x86_64

RUN apt-get install -y curl bzip2 libfreetype6 libfontconfig
RUN curl -sSL https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOM_JS_VERSION.tar.bz2 | tar xjC /
RUN ln -s phantomjs-$PHANTOM_JS_VERSION /phantomjs

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen &&     echo 'LANG="en_US.UTF-8"'>/etc/default/locale &&     dpkg-reconfigure --frontend=noninteractive locales &&     update-locale LANG=en_US.UTF-8
RUN export LANG=en_US.UTF-8

RUN curl -sL https://install.meteor.com | sed s/--progress-bar/-sL/g | /bin/sh
RUN export METEOR_ALLOW_SUPERUSER=true

# Fixes issues with builds not going through on Bitbucket Pipeline due to
# issues reaching unicode.org.
RUN apt-get install unicode-data

RUN adduser --disabled-password --gecos '' meteor_user
RUN adduser meteor_user sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir -p /opt/atlassian/pipelines/agent/data
RUN chmod 777 /opt/atlassian/pipelines/agent/data

USER meteor_user
