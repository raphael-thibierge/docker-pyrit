# docker-pyrit 

Pyrit with **CUDA** as docker container using [`nvidia-docker`](https://github.com/NVIDIA/nvidia-docker)

Uses `pyrit` as default entrypoint with GPU cores only.

Requirements:
- `nvidia-smi`
- `nvidia-docker`
- `CUDA` >= 9 

Available CUDA versions:
- `11.4.1`
- `11.4.0`
- `11.3.1`
- `11.3.0`
- `11.2.2`
- `11.2.1`
- `11.2.0`
- `11.1.1`
- `11.0.3`
- `10.2`
- `10.1`
- `10.0`
- `9.2`


## Get started

Check your `CUDA` version
```bash
nvidia-smi | grep CUDA | sed 's/.*Version: //' | sed 's/ .*//'
```

Match your version with available ones
```bash 
VERSION=11.4.1
```

Build image
```bash
docker build --build-arg CUDA_VERSION=$VERSION -t pyrit-cuda .
```

Run (as `pyrit` is the entrypoint, you can specify a command and parameters)
```bash
docker run --rm --gpus all pyrit-cuda
```
