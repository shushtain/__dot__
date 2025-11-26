#!/bin/bash
## Enable your user for Systemd Linger: sudo loginctl enable-linger $USER
## Run: `./sync.sh systemd_setup` to create and enable systemd service.
## Run: `journalctl --user --unit rclone_sync.${RCLONE_REMOTE}` to view the logs.

# RCLONE_SYNC_PATH: The path to COPY FROM (files are not synced TO here):
RCLONE_SYNC_PATH="/home/user/dav-sync"

# RCLONE_REMOTE: The rclone remote name to synchronize with.
# Identical to one of the remote names listed via `rclone listremotes`.
# Make sure to include the final `:` in the remote name, which
#   indicates to sync/delete from the same (sub)directory as defined in the URL.
# (ALL CONTENTS of the remote are continuously DELETED
#  and replaced with the contents from RCLONE_SYNC_PATH)
RCLONE_REMOTE="GDrive:"

# RCLONE_CMD: The sync command and arguments:
## (This example is for one-way sync):
## (Consider using other modes like `bisync` or `move` [see `man rclone` for details]):
RCLONE_CMD="rclone -v sync ${RCLONE_SYNC_PATH} ${RCLONE_REMOTE}"

# WATCH_EVENTS: The file events that inotifywait should watch for:
WATCH_EVENTS="modify,delete,create,move"

# SYNC_DELAY: Wait this many seconds after an event, before synchronizing:
SYNC_DELAY=5

# SYNC_INTERVAL: Wait this many seconds between forced synchronizations:
SYNC_INTERVAL=3600

# NOTIFY_ENABLE: Enable Desktop notifications
NOTIFY_ENABLE=true

# SYNC_SCRIPT: dynamic reference to the current script path
SYNC_SCRIPT=$(realpath $0)

notify() {
    MESSAGE=$1
    if test ${NOTIFY_ENABLE} = "true"; then
        notify-send "rclone ${RCLONE_REMOTE}" "${MESSAGE}"
    fi
}

rclone_sync() {
    set -x
    # Do initial sync immediately:
    notify "Startup"
    ${RCLONE_CMD}
    # Watch for file events and do continuous immediate syncing
    # and regular interval syncing:
    while [[ true ]]; do
        inotifywait --recursive --timeout ${SYNC_INTERVAL} -e ${WATCH_EVENTS} \
            ${RCLONE_SYNC_PATH} 2>/dev/null
        if [ $? -eq 0 ]; then
            # File change detected, sync the files after waiting a few seconds:
            sleep ${SYNC_DELAY} && ${RCLONE_CMD} &&
                notify "Synchronized new file changes"
        elif [ $? -eq 1 ]; then
            # inotify error occured
            notify "inotifywait error exit code 1"
            sleep 10
        elif [ $? -eq 2 ]; then
            # Do the sync now even though no changes were detected:
            ${RCLONE_CMD}
        fi
    done
}

systemd_setup() {
    set -x
    if loginctl show-user ${USER} | grep "Linger=no"; then
        echo "User account does not allow systemd Linger."
        echo "To enable lingering, run as root: loginctl enable-linger $USER"
        echo "Then try running this command again."
        exit 1
    fi
    mkdir -p ${HOME}/.config/systemd/user
    SERVICE_FILE=${HOME}/.config/systemd/user/rclone_sync.${RCLONE_REMOTE}.service
    if test -f ${SERVICE_FILE}; then
        echo "Unit file already exists: ${SERVICE_FILE} - Not overwriting."
    else
        cat <<EOF >${SERVICE_FILE}
[Unit]
Description=rclone_sync ${RCLONE_REMOTE}

[Service]
ExecStart=${SYNC_SCRIPT}

[Install]
WantedBy=default.target
EOF
    fi
    systemctl --user daemon-reload
    systemctl --user enable --now rclone_sync.${RCLONE_REMOTE}
    systemctl --user status rclone_sync.${RCLONE_REMOTE}
    echo "You can watch the logs with this command:"
    echo "   journalctl --user --unit rclone_sync.${RCLONE_REMOTE}"
}

if test $# = 0; then
    rclone_sync
else
    CMD=$1
    shift
    ${CMD} $@
fi
