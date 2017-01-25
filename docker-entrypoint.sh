#!/bin/bash

set -ex

# Add curator as command if needed
if [ "${1:0:1}" = '-' ]; then
  echo "Setting command to ${ELASTICSEARCH_CURATOR_CLI}"
  set -- ${ELASTICSEARCH_CURATOR_CLI} "$@"
fi

if [ "${ELASTICSEARCH_CURATOR_CLI}" = 'curator_cli' ]; then
  bash -c "while true; do curator_cli --host $ELASTICSEARCH_HOST $ELASTICSEARCH_CURATOR_ARGS delete_indices --filter_list "'\[\{\"filtertype\":\"age\",\"source\":\"creation_date\",\"direction\":\"older\",\"unit\":\"days\",\"unit_count\":\"$OLDER_THAN_IN_DAYS\"\}\]'"; set -e; sleep $(( 60*60*INTERVAL_IN_HOURS )); set +e; done"
elif [ "${ELASTICSEARCH_CURATOR_CLI}" = 'curator' ]; then
  bash -c "while true; do curator --host $ELASTICSEARCH_HOST delete indices --older-than $OLDER_THAN_IN_DAYS --time-unit=days --timestring '%Y.%m.%d'; set -e; sleep $(( 60*60*INTERVAL_IN_HOURS )); set +e; done"
fi

# As argument is not related to curator,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"
