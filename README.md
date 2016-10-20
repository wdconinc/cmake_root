(https://root.cern.ch/)[ROOT], is an object oriented framework for large scale data analysis developed at CERN. It is popular in nuclear and particle phyiscs.

# Synopsis

```
cmake_root.sh <version>
```

# Description

This script downloads and builds ROOT from the source distribution. It installs the resulting binaries in `/usr/local/root/<version>`. Multiple version can be installed next to each other, and the desired version can be loaded by sourcing the file `bin/thisroot.sh`.

# Examples

```
./cmake_root.sh 6.06.08
```
