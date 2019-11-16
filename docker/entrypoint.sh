#!/bin/bash

${MINIO_BIN} ${MINIO_MODE} --config-dir=${MINIO_CONFIG_DIR} $@ ${MINIO_DATA_DIR}
