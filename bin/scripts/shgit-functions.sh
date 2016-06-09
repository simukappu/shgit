#!/bin/bash

################################################################################
# Functions for shgit scripts                                                  #
#                                                                              #
# @auther: Shota Yamazaki                                                      #
################################################################################

function check_hub_instration() {
  if type hub >/dev/null 2>&1; then
    :
  else
    output_error "This command needs hub instration. Install hub first. See [https://github.com/github/hub]."
    decho ""
    usage
  fi
}

function check_git_repository() {
  if [ "`git rev-parse --is-inside-work-tree 2>/dev/null`" != "true" ]; then
    output_error "Current directory is not a git repository. Go to a git directry and run again."
    decho ""
    usage
  fi
}

function load_properties() {
  source ${_SHGIT_HOME}/scripts/shgit-load-properties.sh ${_SHGIT_HOME}/../config/shgit.properties
}

function decho(){
  echo "$1" 1>&2
}

function output_info() {
  decho "[INFO] $1"
}

function output_error() {
  decho "[ERROR] $1"
}
