#!/bin/bash
set -o errexit   # abort on nonzero exitstatus
set -o pipefail  # don't hide errors within pipes

useradd --shell /bin/bash -u ${USERID} -o -c "" -m user

# If started by concourse, WORK_DIR has been created as root. Allow our user to create subdirs
chown -R user:user ${WORK_DIR}


# Configure Git if not configured
if [ ! $(git config --global --get user.email) ]; then
    git config --global user.email "user@example.com"
    git config --global user.name "user"
    git config --global color.ui false
fi

exec gosu user "$@"