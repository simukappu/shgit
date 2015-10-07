#!/bin/bash

################################################################################
# Script to update local and remote self repository as upstream repository     #
#                                                                              #
# @auther: Shota Yamazaki                                                      #
################################################################################

function usage() {
cat <<_EOT_
Usage:
  shgit $COMMAND [-b base_working_branch] [-r remote_repository] [-u upstream_repository]

Description:
  Script to update local and remote self repository as upstream repository

Options:
  -b  Base working branch name (default is 'development')
  -r  Target remote repository name (default is 'origin')
  -u  Target upstream repository name to merge (default is 'upstream')

_EOT_
exit 1
}

COMMAND=$1
shift

BASE_WORKING_BRANCH="development"
REMOTE_REPO="origin"
UPSTREAM_REPO="upstream"
while getopts b:r:u:h OPT
do
  case $OPT in
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

if [ "`git rev-parse --is-inside-work-tree`" != "true" ]; then
  echo "Directory is not a git repository: $1" 1>&2
  usage
fi

CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`
echo "Current branch is ${CURRENT_BRANCH}"
echo ""

# Update base working branch
if [ "${CURRENT_BRANCH}" != "${BASE_WORKING_BRANCH}" ]; then
  git checkout ${BASE_WORKING_BRANCH}
  echo ""
fi
echo "Calling 'git pull ${UPSTREAM_REPO} ${BASE_WORKING_BRANCH}'"
git pull ${UPSTREAM_REPO} ${BASE_WORKING_BRANCH}
echo ""
echo "Calling 'git push ${REMOTE_REPO} ${BASE_WORKING_BRANCH}'"
git push ${REMOTE_REPO} ${BASE_WORKING_BRANCH}
echo ""
if [ "${CURRENT_BRANCH}" != "${BASE_WORKING_BRANCH}" ]; then
  git checkout ${CURRENT_BRANCH}
  echo ""
fi

# Update master branch
if [ "${CURRENT_BRANCH}" != "master" ]; then
  git checkout master
  echo ""
fi
echo "Calling 'git pull ${UPSTREAM_REPO} master'"
git pull ${UPSTREAM_REPO} master
echo ""
echo "Calling 'git push ${REMOTE_REPO} master'"
git push ${REMOTE_REPO} master
echo ""
if [ "${CURRENT_BRANCH}" != "master" ]; then
  git checkout ${CURRENT_BRANCH}
  echo ""
fi
