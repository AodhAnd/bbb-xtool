# run-container.sh -- Docker image runner
# This shell script verifies that the right docker image has been 
# correctly built. It then asks for the code source location
# on the host machine, if it hasn't been specified as an argument.
# It finally runs the container with the specified command, if any.
# 
# You might want to add this script to your $PATH for easier use.
# 
# Copyright (C) 2016 Julien Bréhin julbrehin(at)protonmail(dot)com
# Except from a few lines which were (strongly) inspired by Stephen Thirlwall 
# (sdt)[https://github.com/sdt].
#
# This software may be modified and distributed under the terms
# of the MIT license. See the LICENSE file for details.

#!/bin/bash

#------------------- Set environment variables ------------------#
CONTAINER=bbb-xtool
TAG=latest
COMMAND=make

# Source code folder on the host machine
SRC_FOLDER=''
# Source code folder destination on the guest
DEST_FOLDER='/build/'

if [[ -z $DOCKER_HOST ]]; then
  USER_IDS="-e BUILDER_UID=$( id -u ) -e BUILDER_GID=$( id -g )"
fi

# #---------------------------- Helpers ----------------------------#
# err() {
#     echo -e >&2 ERROR: $@\\n
# }

# die() {
#     err $@
#     exit 1
# }

# has() {
#     # eg. has command update
#     local kind=$1
#     local name=$2

#     type -t $kind:$name | grep -q function
# }

# #------------------------ Command handlers -----------------------#
# command:update-image() {
#     docker pull $CONTAINER
# }

# command:update-script() {
#     if cmp -s <( docker run $CONTAINER ) $0; then
#         echo $0 is up to date
#     else
#         echo -n Updating $0 '... '
#         docker run $CONTAINER > $0 && echo ok
#     fi
# }

# command:update() {
#     command:update-image
#     command:update-script
# }

# help:update-image() {
#     echo Pulls the latest $CONTAINER .
# }

# help:update-image() {
#     echo Update $0 from $CONTAINER .
# }

# help:update() {
#     echo Pull the latest $CONTAINER, and then update $0 from that.
# }

# command:help() {
#     if [[ $# != 0 ]]; then
#         if ! has command $1; then
#             err \"$1\" is not an bbbxc command
#             command:help
#         elif ! has help $1; then
#             err No help found for \"$1\"
#         else
#             help:$1
#         fi
#     else
#         cat >&2 <<ENDHELP
# Usage: $0 command [args]

# By default, runs the given command in an bbbxc container.
# Built-in commands:
#     update-image
#     update-script
#     update
# For command help use: $0 help <command>
# ENDHELP
#     fi
# }

# #------------------ Command-line processing ---------------------#
# if [[ $# == 0 ]]; then
#     command:help
#     exit
# fi

# case $1 in
#     --)
#       # Everything after this is the command-line to be executed
#       shift
#       ;;

#     --help)
#       # Help is called -> Superman helps
#       command:help
#       exit
#       ;;
#     *)
#       # If this is a builtin command, execute it, otherwise fall through
#       if has command $1; then
#           command:$1 "${@:2}" # array slice skipping first element
#           exit $?
#       fi
#       ;;
# esac

# #------------- Verify that the image is existant ----------------#
# if [[ "$(docker images -q ${CONTAINER}:${TAG} 2> /dev/null)" == "" ]]; then
#   echo $CONTAINER doesn\'t seem to be part of your docker images or is not up-to-date
#   command:help
#   exit
# else
#   echo Running ${CONTAINER}
# fi



# #--------------------- Option processing ------------------------#
# while [[ $# != 0 ]]; do
#     case $1 in

#         --)
#             break
#             ;;

#         --args)
#             ARG_ARGS="$2"
#             shift 2
#             ;;

#         # --config)
#         #     ARG_CONFIG="$2"
#         #     shift 2
#         #     ;;

#         # --image)
#         #     ARG_IMAGE="$2"
#         #     shift 2
#         #     ;;

#         -*)
#             err Unknown option \"$1\"
#             command:help
#             exit
#             ;;

#         *)
#             break
#             ;;

#     esac
# done
# # Set the docker run extra args (if any)
# FINAL_ARGS=${ARG_ARGS-${RPXC_ARGS}}


#---------------- Ask for the source code path ------------------#



#------------------- Run the image at last ----------------------#
# The :z appendix deals with SELinux trouble when sharing a folder 
# between host and guest
docker run -i \
  -v $SRC_FOLDER:$DEST_FOLDER:z \
  $USER_IDS \
  $CONTAINER \
  make
