FROM ubuntu:trusty
MAINTAINER Julien Bréhin <julbrehin@protonmail.com>

WORKDIR /bbbxc

RUN apt-get update\
  && apt-get install -y \
      automake      \
      make          \
      libstdc++6    \
      libstdc++6-armhf-cross \
      g++-arm-linux-gnueabihf\
    ;

ENTRYPOINT ["bash","/bbbxc/entrypoint.sh"]

COPY entrypoint.sh /bbbxc