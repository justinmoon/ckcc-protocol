# Linux Build Instructions

## Build the docker image

```
sudo docker build --no-cache -t ckcc-builder -f contrib/build.Dockerfile .
```

## Inspect the docker image

```
sudo docker run -it  -v $PWD:/opt/ckcc   --workdir /opt/ckcc ckcc-builder /bin/bash
```

## Build linux binary

```
sudo docker run -it --name ckcc-builder -v $PWD:/opt/ckcc --rm  --workdir /opt/ckcc ckcc-builder /bin/bash -c "contrib/build_bin.sh && contrib/build_dist.sh"
```
