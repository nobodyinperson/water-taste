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
PLOTFILES = $(addsuffix .png, $(addprefix $(PLOTDIR)/, $(PLOTNAMES)))

.PHONY: all
all: $(PLOTFILES)

# make one single plot
$(PLOTFILES): $(PLOTDIR)/%.png : $(PLOTSCRIPTSDIR)/% $(DATAFILE)
	@echo "### $(notdir $<) output: ###"
	cd $(dir $@) && $(realpath $<) $(realpath $(DATAFILE)) $(abspath $@)
	@echo "### $(notdir $<) output end ###"

.PHONY: clean
clean:
	rm -f $(PLOTDIR)/*.png
