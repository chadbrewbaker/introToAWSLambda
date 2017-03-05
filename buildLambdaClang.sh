#!/bin/bash
echo Build started on `date`
yum install -y clang
clang -v
ldd /usr/bin/clang
