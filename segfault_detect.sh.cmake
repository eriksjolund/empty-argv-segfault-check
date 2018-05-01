#!/bin/bash
set -u

resultfile=`mktemp --suffix .txt /tmp/result.XXXXX`

for i in `cat $1` ; do 
  # Just test ELF binaries.
  if grep -q ELF <(/usr/bin/file $i); then
       /usr/bin/timeout -k 2s -s KILL 1s @CMAKE_INSTALL_PREFIX@/bin/empty-argv-segfault-check $i
    if [ $? -eq 139 ]; then
	echo $i >> $resultfile
    fi
  fi
done
