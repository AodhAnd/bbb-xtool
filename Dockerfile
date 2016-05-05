FROM ubuntu:trusty
MAINTAINER Julien Bréhin <julbrehin@protonmail.com>

WORKDIR /build/

RUN apt-get update\
  && apt-get install -y \
      automake      \
      make          \
      libstdc++6    \
      libstdc++6-armhf-cross \
      g++-arm-linux-gnueabihf\
      runit         \
    ;

ENTRYPOINT ["bash","/bbbxc/entrypoint.sh"]

COPY entrypoint.sh run-container.sh /bbbxc/