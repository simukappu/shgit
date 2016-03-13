#!/bin/bash

################################################################################
# Script to load shgit.properties file                                         #
#                                                                              #
# @auther: Shota Yamazaki                                                      #
################################################################################

PROPFILE=$1

KEY="origin.repository"
DEFAULT="origin"
if [ -r "$PROPFILE" ]; then
  VALUE=`cat "$PROPFILE" | tr -d '\r' | grep -v "#" | grep $KEY | cut -d= -f 2`
  if [ -z "$VALUE" ]; then
    echo "$KEY can not be found in $PROPFILE"
    echo "$KEY is set to '$DEFAULT'"
    VALUE=DEFAULT
  fi
else
  echo $PROPFILE can not be found
  echo "$KEY is set to '$DEFAULT'"
  VALUE=DEFAULT
fi
export _ORIGIN=$VALUE

KEY="upstream.repository"
DEFAULT="upstream"
if [ -r "$PROPFILE" ]; then
  VALUE=`cat "$PROPFILE" | tr -d '\r' | grep -v "#" | grep $KEY | cut -d= -f 2`
  if [ -z "$VALUE" ]; then
    echo "$KEY can not be found in $PROPFILE"
    echo "$KEY is set to '$DEFAULT'"
    VALUE=DEFAULT
  fi
else
  echo $PROPFILE can not be found
  echo "$KEY is set to '$DEFAULT'"
  VALUE=DEFAULT
fi
export _UPSTREAM=$VALUE

KEY="development.branch"
DEFAULT="developent"
if [ -r "$PROPFILE" ]; then
  VALUE=`cat "$PROPFILE" | tr -d '\r' | grep -v "#" | grep $KEY | cut -d= -f 2`
  if [ -z "$VALUE" ]; then
    echo "$KEY can not be found in $PROPFILE"
    echo "$KEY is set to '$DEFAULT'"
    VALUE=DEFAULT
  fi
else
  echo $PROPFILE can not be found
  echo "$KEY is set to '$DEFAULT'"
  VALUE=DEFAULT
fi
export _DEVELOPMENT=$VALUE
