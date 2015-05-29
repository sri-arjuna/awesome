#!/usr/bin/env bash
MODE=${1:-down}
DEVICE=Master
INTERVALL=2
[ $MODE = down ] && waychar="-" || waychar="+"
amixer -c 1 set ${DEVICE} ${INTERVALL}dB${waychar}
