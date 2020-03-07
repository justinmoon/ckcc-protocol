# Linux Build Instructions

## Build the docker image

```
$ docker build --no-cache -t ckcc-builder -f contrib/build.Dockerfile .
```

## Build linux binary

```
$ docker run -it --name ckcc-builder -v $PWD:/opt/ckcc --rm  --workdir /opt/ckcc ckcc-builder /bin/bash -c "contrib/build_bin.sh && contrib/build_dist.sh"
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
