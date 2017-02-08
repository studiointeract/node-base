FROM node:latest

MAINTAINER Tim Brandin "tim.brandin@studiointeract.se"

RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get install --no-install-recommends -y -q curl python build-essential git ca-certificates

ENV PHANTOM_JS_VERSION 1.9.7-linux-x86_64

RUN apt-get install -y curl bzip2 libfreetype6 libfontconfig
RUN curl -sSL https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOM_JS_VERSION.tar.bz2 | tar xjC /
RUN ln -s phantomjs-$PHANTOM_JS_VERSION /phantomjs

RUN curl https://install.meteor.com/ | sh
