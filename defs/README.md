# defs/README.md

## TL;DR

```bash
git clone https://github.com/Characterisation-Virtual-Laboratory/CharacterisationVL-Software.git cvl-software
cd cvl-software
make
make xdg
```

## Makefile

Variables

| Name | Description | Default value |
| ---- | ----------- | ------------- |
| APPTAINER_CACHEDIR | Cache location for SIF container images and OCI/docker layers generated from remote sources | /scratch/apptainer/cache |
| APPTAINER_TMPDIR | The location for temporary directories | `/scratch/tmp.$(md5sum /etc/machine-id |cut -d' ' -f1)` *Ensure unique path on shared scratch* |
| BASEDIR | Mount point or base of CVL directory structure location | /vol/cvl |
| BINDIR | Location of the generated executables | `${BASEDIR}/bin` |

## Annotations (Labels) in container image

* ref. https://github.com/opencontainers/image-spec/blob/main/annotations.md

| Key | Value details | Variable substitution |
| --- | ------------- | --------------------- |
| au.imagingtools.cvl.xdg.icon | URL of a desktop icon |
| au.imagingtools.cvl.xdg.generic-name | Desktop menu containing the application |
| au.imagingtools.cvl.xdg.Exec | Application execute command optional | *${SIF_PATH}* replaced with absolute path to image |
| au.imagingtools.cvl.xdg.Terminal | Open application in a terminal |
| org.opencontainers.image.created | *Updated via the automated build process* |
| org.opencontainers.image.authors | |
| org.opencontainers.image.url | |
| org.opencontainers.image.documentation | |
| org.opencontainers.image.source | |
| org.opencontainers.image.version | |
| org.opencontainers.image.revision | *Updated via the automated build process* |
| org.opencontainers.image.vendor | |
| org.opencontainers.image.licenses | |
| org.opencontainers.image.title | |
| org.opencontainers.image.description | |


