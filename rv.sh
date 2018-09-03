#!/bin/sh

apt install -y automake autoconf libtool make autopoint

autoreconf -fiv
env CC=rvpc CXX=rvpc++ LD=rvpld ./configure
make -j`nproc`

env RVP_ANALYSIS_ARGS="--output=json" RVP_REPORT_FILE="$PWD/my_errors.json" make check

report_path="$PWD/report"
touch $RVP_REPORT_FILE && rv-html-report $RVP_REPORT_FILE -o $report_path

rv-upload-report $report_path
