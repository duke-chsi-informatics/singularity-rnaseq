```
IMAGE_NUM=0004
IMAGE_NAME=singularity-rnaseq_${IMAGE_NUM}.sif
IMAGE_PATH=$HOME/container_images/${IMAGE_NAME}

singularity build --force --fakeroot $IMAGE_PATH \
  ~/project_repos/singularity-rnaseq/Singularity

singularity push -U $IMAGE_PATH library://granek/duke-chsi-informatics/singularity-rnaseq:latest
singularity push -U $IMAGE_PATH library://granek/duke-chsi-informatics/singularity-rnaseq:${IMAGE_NUM}
```
