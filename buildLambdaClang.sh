#!/bin/bash
echo Build started on `date`
ls /usr/bin | sort > usrbindir
ls /lib | sort > libdir
ls /lib64 | sort> lib64dir
ls /usr/lib | sort > usrlibdir
yum install -y clang

ls /usr/bin | sort > usrbindir2
ls /lib | sort  > libdir2
ls /lib64 | sort > lib64dir2
ls /usr/lib | sort > usrlibdir2
touch 
diff usrbindir usrbindir2 > usrbin.dif
diff libdir libdir2 > lib.dif
diff lib64dir lib64dir2 > lib64.dif
diff usrlibdir usrlibdir2 > usrlib.dif

mkdir clangOnLambda
mv *.dif ./clangOnLambda/

tar -c clangOnLambda > clangOnLambda.tar
zip clangOnLambda.zip clangOnLambda.tar

#clang -v

#ldd /usr/bin/clang
