# Script (strongly) inspired by Stepthen Thirlwall (aka. sdt) with MIT License
# Taken from https://github.com/sdt/docker-raspberry-pi-cross-compiler

#!/bin/bash

# This is the entrypoint script for the dockerfile. Executed in the
# container at runtime.

if [[ $# == 0 ]]; then
    # Presumably the image has been run directly, so help the user get started.
    echo "The image should be launched through run-container.sh!"
    echo "Please run: docker run bbb-xtool > run-container.sh && chmod +x run-container.sh"
    echo "Then retry by running ./run-container.sh..."
    cat /bbbxc/run-container.sh
    exit 0
fi

# If we are running docker natively, we want to create a user in the container
# with the same UID and GID as the user on the host machine, so that any files
# created are owned by that user. Without this they are all owned by root.
# If we are running from boot2docker, this is not necessary (i.e. from Windows 
# or MacOSX it is not possible).
# The run-container.sh script sets the BUILDER_UID and BUILDER_GID vars.
if [[ -n $BUILDER_UID ]] && [[ -n $BUILDER_GID ]]; then

    BUILDER_USER=bbbxc-user
    BUILDER_GROUP=bbbxc-group

    groupadd -o -g $BUILDER_GID $BUILDER_GROUP 2> /dev/null
    useradd -o -g $BUILDER_GID -u $BUILDER_UID $BUILDER_USER 2> /dev/null

    # Run the command as the specified user/group.
    echo "Executing the desired command ($@)..."
    # exec chpst -u :$BUILDER_UID:$BUILDER_GID "$@"
    echo "Success !"
else
    # Just run the command as root.
    echo "It seems like you are still root :/"
    echo "Here are your groups: "
    groups 
fi