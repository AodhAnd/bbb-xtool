FROM ubuntu:trusty
MAINTAINER Julien Bréhin <julbrehin@protonmail.com>

RUN apt-get update\
  && apt-get install -y \
      automake      \
      make          \
      libstdc++6    \
      libstdc++6-armhf-cross \
      g++-arm-linux-gnueabihf\
    ;