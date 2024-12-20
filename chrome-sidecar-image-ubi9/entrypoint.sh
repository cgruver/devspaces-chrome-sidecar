#!/usr/bin/env bash

if [ ! -d "${HOME}" ]
then
  mkdir -p "${HOME}"
fi

if ! whoami &> /dev/null
then
  if [ -w /etc/passwd ]
  then
    echo "${USER_NAME:-user}:x:$(id -u):0:${USER_NAME:-user} user:${HOME}:/bin/bash" >> /etc/passwd
  fi
  if [ -w /etc/group ]
  then
    echo "${USER_NAME:-user}:x:$(id -u):" >> /etc/group
  fi
fi

tail -f /dev/null