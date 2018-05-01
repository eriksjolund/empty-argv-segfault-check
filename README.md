# empty-argv-segfault-check
Test if an executable segfaults when started with an empty argv


## Installation

```
ubuntu@laptop:~$ mkdir /tmp/build
ubuntu@laptop:~$ mkdir /tmp/install
ubuntu@laptop:~$ cd /tmp/build
ubuntu@laptop:/tmp/build$ cmake -DCMAKE_INSTALL_PREFIX=/tmp/install ~/empty-argv-segfault-check/ && make && make install
-- The CXX compiler identification is GNU 7.2.0
-- Check for working CXX compiler: /usr/bin/c++
-- Check for working CXX compiler: /usr/bin/c++ -- works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Configuring done
-- Generating done
-- Build files have been written to: /tmp/build
Scanning dependencies of target empty-argv-segfault-check
[ 50%] Building CXX object CMakeFiles/empty-argv-segfault-check.dir/main.cc.o
[100%] Linking CXX executable empty-argv-segfault-check
[100%] Built target empty-argv-segfault-check
[100%] Built target empty-argv-segfault-check
Install the project...
-- Install configuration: ""
-- Installing: /tmp/install/bin/empty-argv-segfault-check
-- Installing: /tmp/install/bin/segfault_detect.sh
-- Installing: /tmp/install/bin/find-executables.sh
ubuntu@laptop:/tmp/build$ 
```

## Usage

### Find all executables

```
ubuntu@laptop:/tmp$ /tmp/install/bin/find-executables.sh > /tmp/all.txt
[sudo] password for ubuntu: 
ubuntu@laptop:/tmp$ 
```

### Find all setuid executables

```
ubuntu@laptop:/tmp$ /tmp/install/bin/find-executables.sh setuid > /tmp/all-setuid.txt
[sudo] password for ubuntu: 
ubuntu@laptop:/tmp$ 
```

### Starting executables with an empty argv and see if they segfaults

Note, starting executables might have side effects. If you want to start
all the executables found on the system you better do this
on a separate test user account or even better on a virtual machine.

```
test@laptop:/tmp$ /tmp/install/bin/segfault_detect.sh /tmp/all.txt 
```

The result is written to a temporary file in /tmp/

```
test@laptop:/tmp$ ls -ltr /tmp/result.*
/tmp/result.3otWy.txt
```
To list the executables that segfaulted:

```
test@laptop:/tmp$ cat /tmp/result.3otWy.txt
/usr/bin/prog1
/usr/bin/prog2
/usr/bin/prog3
```
