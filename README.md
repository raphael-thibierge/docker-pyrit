# docker-pyrit 


Pyrit with **CUDA 11.4** as docker container using [`nvidia-docker`](https://github.com/NVIDIA/nvidia-docker)


Published docker image : [rthibierge/pyrit-cuda](https://hub.docker.com/repository/docker/rthibierge/pyrit-cuda)


Uses `pyrit` as default entrypoint with GPU cores only.


```bash
docker run --rm --gpus all rthibierge/pyrit-cuda list_cores
```
