#!/bin/sh

apt install -y automake autoconf libtool make autopoint

autoreconf -fiv
env CC=rvpc CXX=rvpc++ LD=rvpld ./configure
make -j`nproc`

export RVP_ANALYSIS_ARGS="--output=json"
export RVP_REPORT_FILE="$PWD/my_errors.json"
timeout 3m make check

report_path="$PWD/report"
touch $RVP_REPORT_FILE && rv-html-report $RVP_REPORT_FILE -o $report_path

rv-upload-report $report_path
