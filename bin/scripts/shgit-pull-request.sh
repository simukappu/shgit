#!/bin/bash

################################################################################
# Script to send pull-request from origin to upstream                          #
#                                                                              #
# @auther: Shota Yamazaki                                                      #
################################################################################

source ${_SHGIT_HOME}/scripts/shgit-functions.sh

function usage() {
cat <<_EOT_
Usage:
  shgit $COMMAND [-p] [-o origin_branch] [-b target_branch] [-i issue]

Description:
  Send pull-request from origin repository to target repository

Options:
  -p  Push origin before send pull-request
  -o  Original branch name of pull-request (default is current branch)
  -b  Target branch name of pull-request (default is '${_BASE_WORKING_BRANCH}')
  -i  Issue number associated with a pull-requestBase working branch name

_EOT_
exit 1
}

COMMAND=$1
shift

TARGET_BRANCH="${_BASE_WORKING_BRANCH}"
ISSUE_OPT=""
while getopts po:b:i:h OPT
do
  case $OPT in
    p)
      PUSH_F="true"
      ;;
    o)
      ORIGINAL_BRANCH=${OPTARG}
      ;;
    b)
      TARGET_BRANCH=${OPTARG}
      ;;
    i)
      ISSUE_OPT="-i ${OPTARG}"
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
check_hub_instration

CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`
if [ -z "${ORIGINAL_BRANCH}" ]; then
  ORIGINAL_BRANCH="${CURRENT_BRANCH}"
fi
if [ "${CURRENT_BRANCH}" != "${ORIGINAL_BRANCH}" ]; then
  git checkout ${ORIGINAL_BRANCH} >/dev/null 2>&1
fi

if [ "$PUSH_F" = "true" ]; then
  git push --set-upstream $_ORIGIN ${ORIGINAL_BRANCH}
fi
hub pull-request ${ISSUE_OPT} -b ${TARGET_BRANCH}

if [ "${CURRENT_BRANCH}" != "${ORIGINAL_BRANCH}" ]; then
  git checkout ${CURRENT_BRANCH} >/dev/null 2>&1
fi
