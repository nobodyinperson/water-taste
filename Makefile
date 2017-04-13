#!/usr/bin/env make -f

PLOTDIR = plots
PLOTSCRIPTSDIR = scripts
DATADIR = data
DATAFILENAME = water.csv
DATAFILE = $(addprefix $(DATADIR)/, $(DATAFILENAME))

PLOTSCRIPTS_FIND_CMD = find $(PLOTSCRIPTSDIR) -maxdepth 1 -type f -executable
# executable plotscripts
PLOTSCRIPTS = $(shell $(PLOTSCRIPTS_FIND_CMD)) # only the names
PLOTNAMES = $(basename $(notdir $(PLOTSCRIPTS)))

# the corresponding plot names
PLOTFILES = $(addsuffix .png, $(addprefix $(PLOTDIR)/, $(PLOTNAMES)))

# function create_plot(PLOTFILE)
# creates rule to create PLOTFILE with a corresponding plotscript in
# $(PLOTSCRIPTSDIR) with matching basename
define create_plot_rule
$1: $(shell $(PLOTSCRIPTS_FIND_CMD) -name '$(basename $(notdir $1))*') $(DATAFILE)
	$$(realpath $$<) $$(realpath $$(DATAFILE)) $$(abspath $$@)
endef

.PHONY: all
all: $(PLOTFILES)

# create rules for all PLOTFILES
$(foreach _, $(PLOTFILES), $(eval $(call create_plot_rule,$_)))

# sanity tests
test: all
	for file in $(PLOTFILES);do \
		if ! test -e $$file;then exit 1;fi;\
	done

.PHONY: clean
clean:
	rm -f $(PLOTDIR)/*.png
