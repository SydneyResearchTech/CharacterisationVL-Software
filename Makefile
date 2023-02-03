MACHINEID := $(shell sha1sum /etc/machine-id |cut -d' ' -f1)
APPTAINER_CACHEDIR ?= /scratch/tmp.$(MACHINEID)/apptainer/cache
APPTAINER_TMPDIR ?= /scratch/tmp.$(MACHINEID)/tmp
SHELL := /bin/bash
IMAGE_REVISION ?= $(shell git rev-parse --short HEAD)
DEFDIR := defs
BASEDIR ?= /vol/cvl
BINDIR ?= $(BASEDIR)/bin

DEFS := $(wildcard $(DEFDIR)/*.def)
SIFS := $(subst $(DEFDIR),$(BINDIR),$(DEFS:%.def=%.sif))
DEPDIRS := $(APPTAINER_CACHEDIR) $(APPTAINER_TMPDIR)

.PHONY : build xdg

build: $(SIFS)

$(SIFS): $(BINDIR)/%.sif: $(DEFDIR)/%.def | $(DEPDIRS)
	$(eval IMAGE_CREATED := $(shell date --rfc-3339=seconds --utc))
	$(eval DEFTEMP := $(shell mktemp))
	sed \
		-e 's/\(org.opencontainers.image.created \).*$$/\1$(IMAGE_CREATED)/' \
		-e 's/\(org.opencontainers.image.revision \).*$$/\1$(IMAGE_REVISION)/' \
		$< >$(DEFTEMP)
	-APPTAINER_CACHEDIR=$(APPTAINER_CACHEDIR) APPTAINER_TMPDIR=$(APPTAINER_TMPDIR) \
		apptainer build -F $@ $(DEFTEMP)
	rm -f $(DEFTEMP)

$(DEPDIRS) :
	mkdir -p $@

xdg:
	bin/xdg-desktop-menu -b $(BASEDIR)
