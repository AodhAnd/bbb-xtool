#!/bin/bash

: ${BBBXC_IMAGE:=bbb-xtool}

docker build -t $BBBXC_IMAGE .