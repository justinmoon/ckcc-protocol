# Linux & Windows Build Instructions

## Build the docker image

```
$ docker build --no-cache -t ckcc-builder -f contrib/build.Dockerfile .
```

## Build linux binary

```
$ docker run -it --name ckcc-builder -v $PWD:/opt/ckcc --rm  --workdir /opt/ckcc ckcc-builder /bin/bash -c "contrib/build_bin.sh && contrib/build_dist.sh && contrib/build_wine.sh"
```

Test it out with a coldcard unlocked and plugged in:

```
$ ./dist/ckcc chain
XTN
```

## Inspect the docker image

Sometimes useful for debugging

```
$ docker run -it  -v $PWD:/opt/ckcc   --workdir /opt/ckcc ckcc-builder /bin/bash
```

# MacOS Build Instructions

## Get deterministic Python build

```
 cat contrib/reproducible-python.diff | PYTHON_CONFIGURE_OPTS="--enable-framework" BUILD_DATE="Jan  1 2019" BUILD_TIME="00:00:00" pyenv install -kp 3.6.8
```

## Install Pyenv

```
brew update
brew install pyenv
```

Add the following to your shell config file to start pyenv in new terminals:

```
eval "$(pyenv init -)"
```

Either source your shell config file or open a new terminal window

## Set pyenv to 3.6.8

```
pyenv shell 3.6.8
```

## Install Poetry

```
pip install poetry
```

## Install libusb dependency

```
brew install libusb
```

## Build the binaries

```
./contrib/build_bin.sh
```
