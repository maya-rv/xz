#!/bin/sh

apt install -y automake autoconf libtool make autopoint

autoreconf -fiv
env CC=kcc LD=kcc CFLAGS="-std=gnu11 -fissue-report=./xz_errors_kcc.json" ./configure --enable-shared=no
make -j`nproc`

timeout 10m make check

report_path="$PWD/report"
touch ./xz_errors_kcc.json && rv-html-report ./xz_errors_kcc.json -o $report_path

rv-upload-report $report_path
