#!/bin/bash
set -o errexit   # abort on nonzero exitstatus
set -o pipefail  # don't hide errors within pipes

if [ -z "${USERID}" ]; then
  echo "No user id supplied. Using default id '9001'"
  USERID=9001
fi

if [ -z "${WORK_DIR}" ]; then
  WORK_DIR=/workdir
  echo "No WORK_DIR defined. Defaulting to '${WORK_DIR}'"
fi

if [ -z "${BUILD_DIR}" ]; then
  BUILD_DIR=build-torizon
  echo "No BUILD_DIR defined. Defaulting to '${BUILD_DIR}'"
fi

if [ -z "${DISTRIBUTION}" ]; then
  DISTRIBUTION=torizon
  echo "No DISTRIBUTION defined. Defaulting to '${DISTRIBUTION}'"
fi

if [ -z "${BRANCH}" ]; then
  BRANCH=master
  echo "No BRANCH defined. Defaulting to '${BRANCH}'"
fi

if [ -z "${MACHINE}" ]; then
  MACHINE=verdin-imx8mm
  echo "No MACHINE defined. Defaulting to '${MACHINE}'"
fi

if [ -z "${MANIFEST_REPO}" ]; then
  MANIFEST_REPO=https://github.com/ci4rail/toradex-torizon-manifest
  echo "No MANIFEST_REPO defined. Defaulting to '${MANIFEST_REPO}'"
fi

useradd --shell /bin/bash -u ${USERID} -o -c "" -m user

# Configure Git if not configured
if [ ! $(git config --global --get user.email) ]; then
    git config --global user.email "user@example.com"
    git config --global user.name "user"
    git config --global color.ui false
fi

exec gosu user "$@"