SHELL=/bin/sh
BENCHMARK=mg
BENCHMARKU=MG

include ../config/make.def

OBJS = mg.o mg_data.o ${COMMON}/print_results.o  \
       ${COMMON}/${RAND}.o ${COMMON}/timers.o ${COMMON}/wtime.o

include ../sys/make.common
F_LIB += $(ROI_LIB)
F_LIB += $(ROI_OBJ)
F_INC += $(ROI_INC)

${PROGRAM}: config ${OBJS}
	${FLINK} ${FLINKFLAGS} -o ${PROGRAM} ${OBJS} ${ROI_BIN} ${F_LIB}

.f90.o:
	${FCOMPILE} $<

mg.o:		mg.f90 mg_data.o
mg_data.o:      mg_data.f90 npbparams.h

clean:
	- rm -f *.o *~ *.mod
	- rm -f npbparams.h core
	- if [ -d rii_files ]; then rm -r rii_files; fi
