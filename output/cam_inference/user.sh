#!/bin/bash
USER_ID=${LOCAL_USER_ID:-9001}
echo 'Starting with username : $USER and UID : -9001 host -> 1000'
useradd -s /bin/bash -u $USER_ID -o -c '' -m $USER
export HOME=/home/$USER
su $USER bash -c 'bash'
