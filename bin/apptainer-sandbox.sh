#!/usr/bin/env bash
#
IMG="/scratch/debian.img"

[[ $EUID -eq 0 ]] || { >&2 echo Run as root user; exit 127; }

[[ -d $IMG ]] || apptainer build --sandbox $IMG docker://debian:bullseye-slim
exec apptainer shell -w $IMG
