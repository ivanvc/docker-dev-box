#!/bin/bash

if [ -d /mhnd/init ]; then
  for script in /mhnd/init/*; do
    if [ -x $script ]; then
      $script
    fi
  done
fi

if [ -d /mhnd/initonce ]; then
  for script in /mhnd/initonce/*; do
    if [ -x $script ]; then
      if [ ! -e "$script".done ]; then
        $script > "$script".done 2>&1
      fi
    fi
  done
fi

exit 0
