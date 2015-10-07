#!/bin/bash

################################################################################
# Script to delete remote branches with confirmation                           #
#                                                                              #
# @auther: Shota Yamazaki                                                      #
################################################################################

function usage() {
cat <<_EOT_
Usage:
  shgit $COMMAND [-fpm] [-b base_working_branch] [-r remote_repository]

Description:
  Script to delete remote branches with confirmation

Options:
  -f  Force delete without confirmation
  -p  Use 'git fetch [remote_repository] --prune' before getting remote branches
  -m  Delete merged branches only
  -b  Base working branch name (default is 'development')
  -r  Target remote repository name (default is 'origin')

_EOT_
exit 1
}

COMMAND=$1
shift

BASE_WORKING_BRANCH="development"
REMOTE_REPO="origin"
MERGED_OPT=""
while getopts fpmb:r:h OPT
do
  case $OPT in
    f)
      ARG_F="on"
      ;;
    p)
      ARG_P="on"
      ;;
    m)
      MERGED_OPT="--merged"
      ;;
    b)
      BASE_WORKING_BRANCH=${OPTARG}
      ;;
    r)
      REMOTE_REPO=${OPTARG}
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

if [ "`git rev-parse --is-inside-work-tree`" != "true" ]; then
  echo "Directory is not a git repository: $1" 1>&2
  usage
fi

if [ "$ARG_P" = "on" ]; then
  echo "Calling 'git fetch ${REMOTE_REPO} --prune'"
  git fetch ${REMOTE_REPO} --prune
fi

CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`
if [ "${CURRENT_BRANCH}" != "${BASE_WORKING_BRANCH}" ]; then
  git checkout ${BASE_WORKING_BRANCH} >/dev/null 2>&1
fi
REMOTE_BRANCHES=`git branch --remote ${MERGED_OPT} | grep ${REMOTE_REPO}/ | grep -v ${REMOTE_REPO}/HEAD | grep -v ${REMOTE_REPO}/master | grep -v ${REMOTE_REPO}/${BASE_WORKING_BRANCH}`
if [ "${CURRENT_BRANCH}" != "${BASE_WORKING_BRANCH}" ]; then
  git checkout ${CURRENT_BRANCH} >/dev/null 2>&1
fi

for REMOTE_BRANCH in $REMOTE_BRANCHES
do
  BRANCH_NAME=${REMOTE_BRANCH:(( ${#REMOTE_REPO} + 1 ))}
  if [ "$ARG_F" = "on" ]; then
    git push ${REMOTE_REPO} :${BRANCH_NAME}
  else
    while true; do  
      read -p "Delete ${REMOTE_BRANCH} ? [y/N]: " YN
      case $YN in
        [yY])
          git push ${REMOTE_REPO} :${BRANCH_NAME}
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
