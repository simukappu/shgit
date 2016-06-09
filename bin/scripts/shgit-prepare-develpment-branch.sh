#!/bin/bash

################################################################################
# Script to prepare new development branch                                     #
#                                                                              #
# @auther: Shota Yamazaki                                                      #
################################################################################

source ${_SHGIT_HOME}/scripts/shgit-functions.sh

function usage() {
cat <<_EOT_
Usage:
  shgit $COMMAND [-mcf] [-b base_working_branch] [-r remote_repository] [-u upstream_repository] new_branch_name

Description:
  Prepare new development branch

Options:
  -m  Merge: Update your local and remote repositories to upstream repository
  -c  Delete merged branches
  -f  Force delete branches without confirmation
  -b  Base working branch name (default is '${_BASE_WORKING_BRANCH}')
  -r  Target remote repository name (default is '$_ORIGIN')
  -u  Target upstream repository name to merge (default is 'upstream')

_EOT_
exit 1
}

COMMAND=$1
shift

BASE_WORKING_BRANCH="${_BASE_WORKING_BRANCH}"
REMOTE_REPO="$_ORIGIN"
UPSTREAM_REPO="$_UPSTREAM"
CLEAN_OPT="-m"
while getopts mcfb:r:u:h OPT
do
  case $OPT in
    m)
      ARG_U="on"
      ;;
    c)
      ARG_C="on"
      ;;
    f)
      CLEAN_OPT="-fm"
      ;;
    b)
      BASE_WORKING_BRANCH=${OPTARG}
      ;;
    r)
      REMOTE_REPO=${OPTARG}
      ;;
    u)
      UPSTREAM_REPO=${OPTARG}
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

if [ $# -ne 1 ]; then
  output_error "Input a new branch name"
  decho ""
  usage
fi
NEW_BRANCH_NAME=$1

if [ "`git rev-parse --is-inside-work-tree`" != "true" ]; then
  echo "Directory is not a git repository: $1" 1>&2
  usage
fi

git checkout ${BASE_WORKING_BRANCH}
echo ""

if [ "$ARG_U" = "on" ]; then
  echo "Update branches"
  shgit update -b ${BASE_WORKING_BRANCH} -r ${REMOTE_REPO} -u ${UPSTREAM_REPO}
fi

if [ "$ARG_C" = "on" ]; then
  echo "Clean local branches"
  shgit delete-local ${CLEAN_OPT} -b ${BASE_WORKING_BRANCH}
  echo ""
  echo "Clean remote branches"
  shgit delete-remote -p ${CLEAN_OPT} -b ${BASE_WORKING_BRANCH} -r ${REMOTE_REPO}
  echo ""
fi

git checkout -b ${NEW_BRANCH_NAME}
