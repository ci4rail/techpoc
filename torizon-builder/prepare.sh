#!/bin/bash

mkdir -p ${WORK_DIR}/${DISTRIBUTION}
cd ${WORK_DIR}/${DISTRIBUTION}

# Initialize if repo not yet initialized
repo status 2> /dev/null
if [ "$?" = "1" ]
then
    repo init -u ${MANIFEST_REPO} -b $BRANCH
    repo sync
fi # Do not sync automatically if repo is setup already

# Initialize build environment
MACHINE=$MACHINE source setup-environment

# Accept Freescale/NXP EULA
if ! grep -q ACCEPT_FSL_EULA ${WORK_DIR}/${DISTRIBUTION}/${BUILD_DIR}/conf/local.conf 
then
    echo 'ACCEPT_FSL_EULA="1"' >> ${WORK_DIR}/${DISTRIBUTION}/${BUILD_DIR}/conf/local.conf
fi

# Create image_list.json for Toradex Easy Installer
if [ ! -f ${WORK_DIR}/${DISTRIBUTION}/${BUILD_DIR}/image_list.json ]
then
    cp /etc/image_list.json ${WORK_DIR}/${DISTRIBUTION}/${BUILD_DIR}/image_list.json
fi
