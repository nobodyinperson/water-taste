#!/usr/bin/env make -f

PLOTDIR = plots
PLOTSCRIPTSDIR = scripts
DATADIR = data
DATAFILENAME = water.csv
DATAFILE = $(addprefix $(DATADIR)/, $(DATAFILENAME))

# executable plotscripts
PLOTSCRIPTS = $(shell find $(PLOTSCRIPTSDIR) -type f -executable)
# only the names
PLOTNAMES = $(basename $(notdir $(PLOTSCRIPTS)))

# the corresponding plot names
PLOTFILENAMES = $(addsuffix .png, $(addprefix $(PLOTDIR)/, $(PLOTNAMES)))

.PHONY: all
all:
	@echo $(PLOTFILENAMES)

%.png: % $(DATAFILE)
	echo $<
