#!/bin/bash
echo Build started on `date`
yum install -v -y clang
clang -v
#ldd /usr/bin/clang
