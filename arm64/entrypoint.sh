#!/bin/sh

# Required when using a custom ca-certificates location
export SSL_CERT_FILE=/data/c8y.crt

# Helper function
is_sourced() {
   if [ -n "$ZSH_VERSION" ]; then 
       case $ZSH_EVAL_CONTEXT in *:file:*) return 0;; esac
   else  # Add additional POSIX-compatible shell names here, if needed
       case ${0##*/} in dash|-dash|bash|-bash|ksh|-ksh|sh|-sh) return 0;; esac
   fi
   return 1  # NOT sourced
}

#
# Wrapper functions to automatically set the custom --config-dir location
#
tedge() {
    /data/bin/tedge --config-dir=/data/etc/tedge "$@"
}

tedge_agent() {
    /data/bin/tedge-agent --config-dir=/data/etc/tedge "$@"
}

tedge_mapper_c8y() {
    /data/bin/tedge-mapper --config-dir=/data/etc/tedge c8y "$@"
}

clear_state() {
    rm -rf /data/etc/tedge/.agent
    rm -rf /data/etc/tedge/.tedge-mapper-c8y
}


main() {
    mkdir -p "/data/etc/tedge"
    tedge init --user root --group root

    if [ -z "$(tedge config get device.id 2>/dev/null)" ]; then
        tedge cert create --device-id tedge_container_ftw ||:
    fi
    tedge config set c8y.url iot.latest.stage.c8y.io

    # This only half works, whereas setting SSL_CERT_FILE always works
    # e.g. tedge-mapper c8y does not respect some calls to the custom ca-certificates location when using c8y.root_cert_path
    # tedge config set c8y.root_cert_path /data/c8y.crt

    tedge config set mqtt.bridge.built_in true
    if ! tedge connect c8y; then
        echo "Connect failed, have you uploaded the ceriticate yet?"
        echo "Try executing:"
        echo
        echo "  tedge cert upload c8y --user <user>"
        echo 
    fi
}

#
# Run inititalization only if the script is not being sourced, e.g. "source entrypoint.sh"
#
if ! is_sourced; then
    echo "Initializing thin-edge.io..." >&2
    main
fi
