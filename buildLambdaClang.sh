#!/bin/bash
echo Build started on `date`
ls /usr/bin > usrbindir
ls /lib > libdir
ls /lib64 > lib64dir
ls /usr/lib > usrlibdir
yum install -y clang

ls /usr/bin > usrbindir2
ls /lib > libdir2
ls /lib64 > lib64dir2
ls /usr/lib > usrlibdir2
diff usrbindir usrbindr2
diff libdir libdir2
diff lib64dir lib64dir2
diff usrlibdir usrlibdir2


#clang -v

#ldd /usr/bin/clang
