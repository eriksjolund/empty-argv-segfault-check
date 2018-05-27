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

## FAQ

### Why does some executables segfault when started with an empty argument list?

When argc is 0, argv[0] is NULL. Probably, the most common cause of the segfault is the dereferencing of argv[0].
A lot of programs falsely assume that argv[0] contains the program name without verifying that argc is not equal to 0.

```C++
main(int argc, char *argv[]) {
  if (argc != 2) {
    fprintf(stderr, "Usage: %s filepath\n", argv[0]);
    exit(1);
  }
```

Discussion: https://github.com/eriksjolund/empty-argv-segfault-check/issues/2

### Can vulnerabilities be found with empty-argv-segfault-check?

Probably not, as the program will just end directly when the null pointer is derefenced.
The interesting case regarding security is finding segfaulting executables that have the setuid bit set.
Such executables run under a different User ID than the one of the user who launched it.

At least empty-argv-segfault-check could be used to find setuid executables that are not
of the highest code quality. They may contain other bugs.

Discussion: https://github.com/eriksjolund/empty-argv-segfault-check/issues/3

### Are there normal circumstances where argv[0] isn't the name of the program being run?

This question has an answer at Stackoverflow: [When can argv[0] have null?](https://stackoverflow.com/questions/2794150/when-can-argv0-have-null/2794171#2794171)


