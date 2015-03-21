#!/bin/bash

if [ -d /nitrous/init ]; then
  for script in /nitrous/init/*; do
    if [ -x $script ]; then
      $script
    fi
  done
fi

if [ -d /nitrous/initonce ]; then
  for script in /nitrous/initonce/*; do
    if [ -x $script ]; then
      if [ ! -e "$script".done ]; then
        $script
        touch "$script".done
      fi
    fi
  done
fi

exit 0
