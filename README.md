OS Catalyst
===========

Introduction
------------
OS Catalyst is meant to bootstrap a new OS install of OSx or Linux quickly so it is ready to use.

---

Installation
------------

### Curl Package

```bash
cd; curl -#L https://github.com/oengusmacinog/os-catalyst/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,LICENSE}
```

### Installing OS-Catalyst
Start out by either cloning or downloading the os-catalyst repository to a location where you'd like to run it from on your local machine.

`cd` into the `os-catalyst` root directory within your terminal, and run `install this` to add the executable to your path:

```
sudo ./os-catalyst install this
```

#### Configuration

```
sudo os-cat install base
os-cat config base
```