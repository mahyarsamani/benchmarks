#!/bin/bash

export LD_LIBRARY_PATH=${PWD}/../roi/papi/install/lib:$LD_LIBRARY_PATH

benchmarks=(bt.A.x cg.A.x dc.A.x ep.A.x ft.A.x is.A.x lu.A.x mg.A.x sp.A.x ua.A.x
            bt.B.x cg.B.x dc.B.x ep.B.x ft.B.x is.B.x lu.B.x mg.B.x sp.B.x ua.B.x
            bt.D.x cg.D.x ep.D.x ft.D.x is.C.x lu.D.x mg.D.x sp.D.x ua.D.x
            )

for bm in ${benchmarks[@]}; do
    echo $bm
    export PAPI_EVENTS="PAPI_L1_DCR,PAPI_L1_DCW,PAPI_L1_DCM,PAPI_L1_DCA,PAPI_TLB_DM"
    export PAPI_OUTPUT_DIRECTORY=${PWD}/../data/eight-core/npb/$bm/backend0_data
    echo "backend0"
    numactl --physcpubind=0,1,2,3,4,5,6,7 --membind=0 -- ./bin/$bm
    export PAPI_EVENTS="PAPI_L2_TCR,PAPI_L2_TCW,PAPI_L2_TCM,PAPI_L2_TCA,PAPI_L3_DCM,PAPI_L3_TCA"
    export PAPI_OUTPUT_DIRECTORY=${PWD}/../data/eight-core/npb/$bm/backend1_data
    echo "backend1"
    numactl --physcpubind=0,1,2,3,4,5,6,7 --membind=0 -- ./bin/$bm
    export PAPI_EVENTS="PAPI_L1_ICM,PAPI_L1_ICH,PAPI_L1_ICA,PAPI_TLB_IM"
    export PAPI_OUTPUT_DIRECTORY=${PWD}/../data/eight-core/npb/$bm/frontend_data
    echo "frontend"
    numactl --physcpubind=0,1,2,3,4,5,6,7 --membind=0 -- ./bin/$bm
    export PAPI_EVENTS="PAPI_TOT_INS,PAPI_INT_INS,PAPI_FP_INS,PAPI_LD_INS"
    export PAPI_OUTPUT_DIRECTORY=${PWD}/../data/eight-core/npb/$bm/inst0_data
    echo "inst0"
    numactl --physcpubind=0,1,2,3,4,5,6,7 --membind=0 -- ./bin/$bm
    export PAPI_EVENTS="PAPI_SR_INS,PAPI_BR_INS,PAPI_VEC_INS"
    export PAPI_OUTPUT_DIRECTORY=${PWD}/../data/eight-core/npb/$bm/inst1_data
    echo "inst1"
    numactl --physcpubind=0,1,2,3,4,5,6,7 --membind=0 -- ./bin/$bm
    export PAPI_EVENTS="PAPI_STL_ICY,PAPI_STL_CCY,PAPI_BR_MSP,PAPI_BR_PRC,PAPI_RES_STL,PAPI_TOT_CYC,PAPI_LST_INS"
    export PAPI_OUTPUT_DIRECTORY=${PWD}/../data/eight-core/npb/$bm/pipe0_data
    echo "pipe0"
    numactl --physcpubind=0,1,2,3,4,5,6,7 --membind=0 -- ./bin/$bm
    export PAPI_EVENTS="PAPI_SYC_INS,PAPI_FP_OPS,PAPI_REF_CYC"
    export PAPI_OUTPUT_DIRECTORY=${PWD}/../data/eight-core/npb/$bm/pipe1_data
    echo "pipe1"
    numactl --physcpubind=0,1,2,3,4,5,6,7 --membind=0 -- ./bin/$bm
done
