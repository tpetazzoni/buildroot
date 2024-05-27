#!/bin/sh

BOARD_DIR="$(dirname "$0")"

AMLOGIC_DIR=${BINARIES_DIR}/amlogic-boot-fip

(cd "${AMLOGIC_DIR}" && \
	./build-fip.sh lepotato \
	"${BINARIES_DIR}"/u-boot.bin \
	"${BINARIES_DIR}")

support/scripts/genimage.sh -c "${BOARD_DIR}/genimage.cfg"
