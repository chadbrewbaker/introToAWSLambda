#!/bin/bash
echo Build started on `date`
yum install clang
clang -v
ldd /usr/bin/clang
