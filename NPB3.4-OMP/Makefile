SHELL=/bin/sh
CLASS=W
VERSION=
SFILE=config/suite.def

ROI_DIR=$(PWD)/../roi
ROI_BIN=
ROI_OBJ=
ROI_INC=-I$(ROI_DIR)/include
ROI_LIB=


ifeq ($(PLATFORM), papi)
	ROI_BIN+=$(ROI_DIR)/lib/roi.papi
	ROI_INC+=-I$(ROI_DIR)/papi/install/include
	ROI_LIB+=-L$(ROI_DIR)/papi/install/lib
	ROI_OBJ+=-lpapi
	ROI_OBJ+=-lpthread
else ifeq ($(PLATFORM), gem5)
	ROI_BIN+=$(ROI_DIR)/lib/roi.gem5
	ROI_INC+=-I$(ROI_DIR)/gem5/include
	ROI_LIB+=-L$(ROI_DIR)/gem5/lib
	ROI_OBJ+=-lm5
else
	ROI_BIN+=$(ROI_DIR)/lib/roi.native
endif

default: header
	@ sys/print_instructions

BT: bt
bt: header
	cd BT; $(MAKE) CLASS=$(CLASS) VERSION=$(VERSION) ROI_BIN="$(ROI_BIN)" ROI_INC="$(ROI_INC)" ROI_LIB="$(ROI_LIB)" ROI_OBJ="$(ROI_OBJ)"

SP: sp
sp: header
	cd SP; $(MAKE) CLASS=$(CLASS) ROI_BIN="$(ROI_BIN)" ROI_INC="$(ROI_INC)" ROI_LIB="$(ROI_LIB)" ROI_OBJ="$(ROI_OBJ)"

LU: lu
lu: header
	cd LU; $(MAKE) CLASS=$(CLASS) VERSION=$(VERSION) ROI_BIN="$(ROI_BIN)" ROI_INC="$(ROI_INC)" ROI_LIB="$(ROI_LIB)" ROI_OBJ="$(ROI_OBJ)"

MG: mg
mg: header
	cd MG; $(MAKE) CLASS=$(CLASS) ROI_BIN="$(ROI_BIN)" ROI_INC="$(ROI_INC)" ROI_LIB="$(ROI_LIB)" ROI_OBJ="$(ROI_OBJ)"

FT: ft
ft: header
	cd FT; $(MAKE) CLASS=$(CLASS) ROI_BIN="$(ROI_BIN)" ROI_INC="$(ROI_INC)" ROI_LIB="$(ROI_LIB)" ROI_OBJ="$(ROI_OBJ)"

IS: is
is: header
	cd IS; $(MAKE) CLASS=$(CLASS) ROI_BIN="$(ROI_BIN)" ROI_INC="$(ROI_INC)" ROI_LIB="$(ROI_LIB)" ROI_OBJ="$(ROI_OBJ)"

CG: cg
cg: header
	cd CG; $(MAKE) CLASS=$(CLASS) ROI_BIN="$(ROI_BIN)" ROI_INC="$(ROI_INC)" ROI_LIB="$(ROI_LIB)" ROI_OBJ="$(ROI_OBJ)"

EP: ep
ep: header
	cd EP; $(MAKE) CLASS=$(CLASS) ROI_BIN="$(ROI_BIN)" ROI_INC="$(ROI_INC)" ROI_LIB="$(ROI_LIB)" ROI_OBJ="$(ROI_OBJ)"

UA: ua
ua: header
	cd UA; $(MAKE) CLASS=$(CLASS) ROI_BIN="$(ROI_BIN)" ROI_INC="$(ROI_INC)" ROI_LIB="$(ROI_LIB)" ROI_OBJ="$(ROI_OBJ)"

DC: dc
dc: header
	cd DC; $(MAKE) CLASS=$(CLASS) ROI_BIN="$(ROI_BIN)" ROI_INC="$(ROI_INC)" ROI_LIB="$(ROI_LIB)" ROI_OBJ="$(ROI_OBJ)"

# Awk script courtesy cmg@cray.com, modified by Haoqiang Jin
suite:
	@ awk -f sys/suite.awk SMAKE=$(MAKE) $(SFILE) | $(SHELL)


# It would be nice to make clean in each subdirectory (the targets
# are defined) but on a really clean system this will won't work
# because those makefiles need config/make.def
clean:
	- rm -f core *~ */core */*~
	- rm -f */*.o */*.obj */*.exe */*.mod */npbparams.h */blk_par.h
	- rm -f sys/setparams sys/makesuite sys/setparams.h
	- rm -rf */rii_files

veryclean: clean
	- rm -f config/make.def config/suite.def
	- rm -f bin/sp.* bin/lu.* bin/mg.* bin/ft.* bin/bt.* bin/is.*
	- rm -f bin/ep.* bin/cg.* bin/ua.* bin/dc.* bin/ADC.*

header:
	@ sys/print_header



