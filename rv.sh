#!/bin/sh

autoreconf -fiv
env CC=rvpc CXX=rvpc++ LD=rvpld ./configure
make -j`nproc`

env RVP_ANALYSIS_ARGS="--output=json" RVP_REPORT_FILE="`pwd`/my_errors.json" make check
