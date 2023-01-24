ifndef APPTAINER_CACHEDIR
APPTAINER_CACHEDIR := /scratch/apptainer/cache
endif
ifndef APPTAINER_TMPDIR
APPTAINER_TMPDIR := $(shell mktemp -d -p /scratch)
endif
SHELL := /bin/bash
SLICER_VERSION := 5.2.1
SLICER_NAME := Slicer-$(SLICER_VERSION)
ifndef IMAGE_REVISION
IMAGE_REVISION := $(shell git -C /scratch/CharacterisationVL-Software rev-parse --short HEAD)
endif
DEFDIR := defs
BINDIR := /vol/cvl/bin

DEFS := $(wildcard $(DEFDIR)/*.def)
SIFS := $(subst $(DEFDIR),$(BINDIR),$(DEFS:%.def=%.sif))

all: $(SIFS) $(APPTAINER_CACHEDIR)

$(SIFS): $(BINDIR)/%.sif: $(DEFDIR)/%.def
	$(eval IMAGE_CREATED := $(shell date --rfc-3339=seconds --utc))
	$(eval DEFTEMP := $(shell mktemp))
	sed \
		-e 's/\(org.opencontainers.image.created \).*$$/\1$(IMAGE_CREATED)/' \
		-e 's/\(org.opencontainers.image.revision \).*$$/\1$(IMAGE_REVISION)/' \
		$< >$(DEFTEMP)
	APPTAINER_CACHEDIR=$(APPTAINER_CACHEDIR) APPTAINER_TMPDIR=$(APPTAINER_TMPDIR) \
		apptainer build -F $@ $(DEFTEMP)
	rm -f $(DEFTEMP)

$(APPTAINER_CACHEDIR) :
	mkdir -p $(APPTAINER_CACHEDIR)
