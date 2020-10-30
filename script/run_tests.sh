#!/bin/sh
fs_cli -x status | grep -q ^UP || exit 1