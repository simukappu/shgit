#!/bin/bash

################################################################################
# Script to delete local branches with confirmation                            #
#                                                                              #
# @auther: Shota Yamazaki                                                      #
################################################################################

source ${_SHGIT_HOME}/scripts/shgit-functions.sh

function usage() {
cat <<_EOT_
Usage:
  shgit $COMMAND [-fm] [-b base_working_branch]

Description:
  Delete remote branches with confirmation

Options:
  -f  Force delete without confirmation
  -m  Delete merged branches only
  -b  Base working branch name (default is '${_BASE_WORKING_BRANCH}')

_EOT_
exit 1
}

COMMAND=$1
shift

BASE_WORKING_BRANCH="${_BASE_WORKING_BRANCH}"
MERGED_OPT=""
while getopts fmb:h OPT
do
  case $OPT in
    f)
      ARG_F="on"
      ;;
    m)
      MERGED_OPT="--merged"
      ;;
    b)
      BASE_WORKING_BRANCH=${OPTARG}
      ;;
    h)
      usage
      ;;
    *)
      usage
      ;;
  esac
done
shift $((OPTIND - 1))

check_git_repository

CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`
if [ "${CURRENT_BRANCH}" != "${BASE_WORKING_BRANCH}" ]; then
  git checkout ${BASE_WORKING_BRANCH} >/dev/null 2>&1
fi
LOCAL_BRANCHES=`git branch ${MERGED_OPT} | grep -v master | grep -v ${BASE_WORKING_BRANCH}`
if [ "${CURRENT_BRANCH}" != "${BASE_WORKING_BRANCH}" ]; then
  git checkout ${CURRENT_BRANCH} >/dev/null 2>&1
fi

for LOCAL_BRANCH in $LOCAL_BRANCHES
do
  if [ "$ARG_F" = "on" ]; then
    git branch -d ${LOCAL_BRANCH}
  else
    while true; do
      read -p "Delete ${LOCAL_BRANCH} ? [y/N]: " YN
      case $YN in
        [yY])
          git branch -d ${LOCAL_BRANCH}
          break
          ;;
        [nN])
          break
          ;;
        "")
          break
          ;;
        *)
          ;;
      esac
    done
  fi
done
