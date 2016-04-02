FROM ubuntu:trusty
MAINTAINER Julien Bréhin <julbrehin@protonmail.com>

ENV X-TOOLCHAIN = g++-arm-linux-gnueabihf

RUN apt-get update\
  && apt-get install -y \
      automake      \
      bison         \
      libstdc++6    \
      libstdc++6-armhf-cross \
      g++-arm-linux-gnueabihf  \
    ;