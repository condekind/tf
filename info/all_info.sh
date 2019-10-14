BENCH_NAME="smg2000"

SRC_FILES=( "HYPRE_pcg.c" "HYPRE_struct_grid.c" "HYPRE_struct_matrix.c" "HYPRE_struct_pcg.c"
               "HYPRE_struct_smg.c" "HYPRE_struct_stencil.c" "HYPRE_struct_vector.c" "box.c"
               "box_algebra.c" "box_alloc.c" "box_neighbors.c" "coarsen.c" "communication.c"
               "communication_info.c" "computation.c" "cyclic_reduction.c" "general.c" "grow.c"
               "memory.c" "mpistubs.c" "pcg.c" "pcg_struct.c" "point_relax.c" "project.c"
               "random.c" "semi_interp.c" "semi_restrict.c" "smg.c" "smg2000.c" "smg2_setup_rap.c"
               "smg3_setup_rap.c" "smg_axpy.c" "smg_relax.c" "smg_residual.c" "smg_setup.c"
               "smg_setup_interp.c" "smg_setup_rap.c" "smg_setup_restrict.c" "smg_solve.c"
               "struct_axpy.c" "struct_copy.c" "struct_grid.c" "struct_innerprod.c" "struct_io.c"
               "struct_matrix.c" "struct_matrix_mask.c" "struct_matvec.c" "struct_scale.c"
               "struct_stencil.c" "struct_vector.c" "threading.c" "timer.c" "timing.c" )

COMPILE_FLAGS=" -I. -lm -D_POSIX_SOURCE -DHYPRE_TIMING -DHYPRE_SEQUENTIAL"

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS=" -n 100 40 100 -c 0.1 1.0 10.0 "
else
  RUN_OPTIONS=" -n 30 15 30 -c 0.1 1.0 10.0 "
fi
BENCH_NAME="AMGmk"

SRC_FILES=( "csr_matrix.c" "csr_matvec.c" "hypre_error.c" "hypre_memory.c" "laplace.c" "main.c" "relax.c" "vector.c" )
COMPILE_FLAGS=" -lm "
BENCH_NAME="CrystalMK"

SRC_FILES=( "Crystal_Cholesky.c" "Crystal_div.c" "Crystal_pow.c" "SPEdriver.c" "init.c" "main.c" )
COMPILE_FLAGS=" -lm "
BENCH_NAME="IRSmk"

SRC_FILES=( "main.c" "rmatmult3.c" "utility.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" irsmk_input "
BENCH_NAME="fannkuch"

SRC_FILES=( "fannkuch.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="nbody"

SRC_FILES=( "n-body.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="nsieve-bits"

SRC_FILES=( "nsieve-bits.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="partialsums"

SRC_FILES=( "partialsums.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="puzzle"

SRC_FILES=( "puzzle.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="recursive"

SRC_FILES=( "recursive.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="spectral-norm"

SRC_FILES=( "spectral-norm.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="drop3"

SRC_FILES=( "drop3.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" input-file "
BENCH_NAME="five11"

SRC_FILES=( "five11.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" input-file "
BENCH_NAME="uudecode"

SRC_FILES=( "uudecode.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" input-file "
BENCH_NAME="uuencode"

SRC_FILES=( "uuencode.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" input "
BENCH_NAME="almabench"

SRC_FILES=( "almabench.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="huffbench"

SRC_FILES=( "huffbench.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="lpbench"

SRC_FILES=( "lpbench.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="perlbench" ;

# SRC_FILES=($(ls *.c)) ;
# CXXFLAGS=" -lm " ;
RUN_OPTIONS="-I../data/all/input/lib ../data/all/input/diffmail.pl 4 800 10 17 19 300" ;
BENCH_NAME="bzip2" ;

# SRC_FILES=($(ls *.c)) ;
# CXXFLAGS=" -lm " ;
RUN_OPTIONS=" ../data/ref/input/input.source 280 " ;
BENCH_NAME="gcc" ;

# SRC_FILES=($(ls *.c)) ;
# CXXFLAGS=" -lm " ;
RUN_OPTIONS=" ../data/ref/input/expr.i -o expr.s " ;
BENCH_NAME="mcf" ;

# SRC_FILES=($(ls *.c)) ;
# CXXFLAGS=" -lm " ;
RUN_OPTIONS=" ../data/ref/input/inp.in " ;
BENCH_NAME="milc" ;

# SRC_FILES=($(ls *.c)) ;
# CXXFLAGS=" -lm " ;
STDIN=" ../data/ref/input/su3imp.in " ;
BENCH_NAME="namd" ;

# SRC_FILES=($(ls *.c)) ;
# CXXFLAGS=" -lm " ;
COMPILER=clang++
RUN_OPTIONS=" --input ../data/all/input/namd.input --iterations 38 --output namd.out " ;
BENCH_NAME="gobmk" ;

# SRC_FILES=($(ls *.c)) ;
# CXXFLAGS=" -lm " ;
RUN_OPTIONS=" --quiet --mode gtp " ;
STDIN=" ../data/ref/input/13x13.tst " ;
BENCH_NAME="dealii" ;

# SRC_FILES=($(ls *.c)) ;
# CXXFLAGS=" -lm " ;
RUN_OPTIONS=" 23 " ;
BENCH_NAME="soplex" ;

# SRC_FILES=($(ls *.c)) ;
# CXXFLAGS=" -lm " ;
RUN_OPTIONS=" -s1 -e -m45000 ../data/ref/input/pds-50.mps " ;
BENCH_NAME="hmmer" ;

# RUN_OPTIONS=" ../data/ref/input/nph3.hmm ../data/ref/input/swiss41 "

RUN_OPTIONS=" --fixed 0 --mean 500 --num 500000 --sd 350 --seed 0 ../data/ref/input/retro.hmm "
BENCH_NAME="sjeng" ;

# SRC_FILES=($(ls *.c)) ;
# CXXFLAGS=" -lm " ;
RUN_OPTIONS=" ../data/ref/input/ref.txt " ;
BENCH_NAME="libquantum" ;

# SRC_FILES=($(ls *.c)) ;
# CXXFLAGS=" -lm " ;
RUN_OPTIONS=" 1397 8 " ;
BENCH_NAME="h264ref" ;

# SRC_FILES=($(ls *.c)) ;
# CXXFLAGS=" -lm " ;
RUN_OPTIONS=" -d ../data/ref/input/foreman_ref_encoder_baseline.cfg " ;
BENCH_NAME="lbm" ;

# SRC_FILES=($(ls *.c)) ;
# CXXFLAGS=" -lm " ;
RUN_OPTIONS=" 3000 reference.dat 0 0 ../data/ref/input/100_100_130_ldc.of " ;
BENCH_NAME="dry"

SRC_FILES=( "dry.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="fldry"

SRC_FILES=( "fldry.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="miniAMR"
SRC_FILES=( "block.c" "check_sum.c" "comm.c" "driver.c" "glibc_compat_rand.c" "init.c" "main.c" "move.c" "plot.c" "profile.c" "refine.c" "stencil.c" "target.c" "util.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" --nx 8 --ny 8 --nz 8 --num_tsteps 100 "
BENCH_NAME="miniGMG"
SRC_FILES=( "box.c" "mg.c" "miniGMG.c" "operators.ompif.c" "solver.c" "timer.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" 6  2 2 2  1 1 1 "
BENCH_NAME="Pathfinder"
SRC_FILES=( "bitfield.c" "configuration.c" "gettime.c" "graph.c" "graphGen.c" "main.c" "node.c" "parsing.c" "searchAlgorithms.c" "searchDiagram.c" "statistics.c" "systemCallMap.c" "utils.c" "vectorUtils.c" "yaml.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" -x medsmall1.adj_list "
BENCH_NAME="RSBench"
SRC_FILES=( "glibc_compat_rand.c" "init.c" "io.c" "main.c" "material.c" "utils.c" "xs_kernel.c" )
COMPILE_FLAGS=" -lm -std=gnu99 "
RUN_OPTIONS=" -s small -l 100000 -p 1000 -w 1000 "
BENCH_NAME="SimpleMOC"
SRC_FILES=( "comms.c" "glibc_compat_rand.c" "init.c" "io.c" "main.c" "papi.c" "solver.c" "source.c" "test.c" "tracks.c" "utils.c" )
COMPILE_FLAGS=" -lm -std=gnu99 "
RUN_OPTIONS=" -i default.in "
BENCH_NAME="XSBench"
SRC_FILES=( "CalculateXS.c" "GridInit.c" "Main.c" "Materials.c" "XSutils.c" "io.c" )
COMPILE_FLAGS=" -lm -DVERIFICATION "
RUN_OPTIONS=" -s small -g 1250 -l 1000000 "
BENCH_NAME="Fhourstones_31"

SRC_FILES=( "SearchGame.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=""

if [[ $LARGE_PROBLEM_SIZE ]]; then
  STDIN=" inputs_large "
else
  STDIN=" inputs "
fi
BENCH_NAME="Fhourstones"

SRC_FILES=( "c4.c" "play.c" "time.c" "trans.c" )
COMPILE_FLAGS=" -DUNIX -DTRANSIZE=1050011 -DPROBES=8 -DREPORTPLY=8 "
RUN_OPTIONS=""
STDIN=" input "
BENCH_NAME="analyzer"

SRC_FILES=( "analyzer.c" "functs.c" "help.c" "parse_settings.c" "types.c" )
COMPILE_FLAGS='-DVERSION="1.00" -DCOMPDATE="\"today\"" -DCFLAGS=\"\" -DHOSTNAME="\"thishost\"" '

PROJ_SRC_DIR=$(pwd)
if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="$PROJ_SRC_DIR/ref.in"
else
  RUN_OPTIONS="$PROJ_SRC_DIR/test.in"
fi
BENCH_NAME="distray"

SRC_FILES=( "distray.c" )
COMPILE_FLAGS='-DVERSION="1.00" -DCOMPDATE="\"today\"" -DCFLAGS=\"\" -DHOSTNAME="\"thishost\"" '

PROJ_SRC_DIR=$(pwd)
if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="$PROJ_SRC_DIR/ref.in"
else
  RUN_OPTIONS="$PROJ_SRC_DIR/test.in"
fi

HASH_PROGRAM_OUTPUT="1"
BENCH_NAME="fourinarow"

SRC_FILES=( "fourinarow.c" )
COMPILE_FLAGS='-DVERSION="1.00" -DCOMPDATE="\"today\"" -DCFLAGS=\"\" -DHOSTNAME="\"thishost\"" '

PROJ_SRC_DIR=$(pwd)
if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="$PROJ_SRC_DIR/ref.in"
else
  RUN_OPTIONS="$PROJ_SRC_DIR/test.in"
fi
BENCH_NAME="mason"

SRC_FILES=( "mason.c" )
COMPILE_FLAGS='-DVERSION="1.00" -DCOMPDATE="\"today\"" -DCFLAGS=\"\" -DHOSTNAME="\"thishost\"" '

PROJ_SRC_DIR=$(pwd)
if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="$PROJ_SRC_DIR/ref.in"
else
  RUN_OPTIONS="$PROJ_SRC_DIR/test.in"
fi
BENCH_NAME="neural"

SRC_FILES=( "neural.c" )
COMPILE_FLAGS='-DVERSION="1.00" -DCOMPDATE="\"today\"" -DCFLAGS=\"\" -DHOSTNAME="\"thishost\"" '

PROJ_SRC_DIR=$(pwd)
if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="$PROJ_SRC_DIR/ref.in"
else
  RUN_OPTIONS="$PROJ_SRC_DIR/test.in"
fi
BENCH_NAME="pcompress2"

SRC_FILES=( "arithmetic.c" "compress.c" "pcompress2.c" "unarithmetic.c" "uncompress.c" )
COMPILE_FLAGS='-DVERSION="1.00" -DCOMPDATE="\"today\"" -DCFLAGS=\"\" -DHOSTNAME="\"thishost\"" '

PROJ_SRC_DIR=$(pwd)
if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="$PROJ_SRC_DIR/ref.in"
else
  RUN_OPTIONS="$PROJ_SRC_DIR/test.in"
fi
BENCH_NAME="pifft"

SRC_FILES=( "fftsg.c" "pifft.c" )
COMPILE_FLAGS='-DVERSION="1.00" -DCOMPDATE="\"today\"" -DCFLAGS=\"\" -DHOSTNAME="\"thishost\"" '

PROJ_SRC_DIR=$(pwd)
if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="$PROJ_SRC_DIR/ref.in"
else
  RUN_OPTIONS="$PROJ_SRC_DIR/test.in"
fi
BENCH_NAME="Linpack"

SRC_FILES=( "linpack-pc.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="llu"

SRC_FILES=( "llubenchmark.c" )
COMPILE_FLAGS=""

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="-i 6000"
else
  RUN_OPTIONS="-i 6000"
fi
BENCH_NAME="mafft"

SRC_FILES=(Calignm1.c constants.c defs.c Falign.c fft.c fftFunctions.c Galign11.c \
              genalign11.c genGalign11.c Halignmm.c io.c Lalign11.c Lalignmm.c \
              mltaln9.c MSalign11.c MSalignmm.c mtxutl.c pairlocalalign.c \
              partQalignmm.c partSalignmm.c Qalignmm.c Ralignmm.c rna.c SAalignmm.c \
              Salignmm.c suboptalign11.c tddis.c)
COMPILE_FLAGS=" -DLLVM "
RUN_OPTIONS=" -b 62 -g 0.100 -f 2.00 -h 0.100 -L "
STDIN=" pyruvate_decarboxylase.fasta "
BENCH_NAME="cfrac"

SRC_FILES=("cfrac.c" "pops.c" "pconst.c" "pio.c" \
              "pabs.c" "pneg.c" "pcmp.c" "podd.c" "phalf.c" \
              "padd.c" "psub.c" "pmul.c" "pdivmod.c" "psqrt.c" "ppowmod.c" \
              "atop.c" "ptoa.c" "itop.c" "utop.c" "ptou.c" "errorp.c" \
              "pfloat.c" "pidiv.c" "pimod.c" "picmp.c" \
              "primes.c" "pcfrac.c" "pgcd.c")
COMPILE_FLAGS="-lm -DNOMEMOPT"

PROJ_SRC_DIR=$(pwd)
if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="376529507064485971626234556089714053987"
else
  RUN_OPTIONS="41757646344123832613190542166099121"
fi
BENCH_NAME="expresso"

SRC_FILES=( "cofactor.c" "cols.c" "compl.c" "contain.c" "cubestr.c" "cvrin.c" "cvrm.c" "cvrmisc.c" "cvrout.c" "dominate.c" "equiv.c" "espresso.c" "essen.c" "exact.c" "expand.c" "gasp.c" "getopt.c" "gimpel.c" "globals.c" "hack.c" "indep.c" "irred.c" "main.c" "map.c" "matrix.c" "mincov.c" "opo.c" "pair.c" "part.c" "primes.c" "reduce.c" "rows.c" "set.c" "setc.c" "sharp.c" "sminterf.c" "solution.c" "sparse.c" "unate.c" "utility.c" "verify.c" )
COMPILE_FLAGS=" -std=gnu89 -DNOMEMOPT "

PROJ_SRC_DIR=$(pwd)
RUN_OPTIONS="-t $PROJ_SRC_DIR/INPUT/largest.espresso"
BENCH_NAME="gs"

PROJ_SRC_DIR="$(pwd)"

SRC_FILES=("gsmain.c" "gs.c" "gp_unix.c" "utrace.c" \
           "ialloc.c" "idebug.c" "idict.c" "iinit.c" "iname.c" \
           "interp.c" "iscan.c" "iutil.c" "stream.c" \
           "zarith.c" "zarray.c" "zcontrol.c" "zdict.c" "zfile.c" \
           "zgeneric.c" "zmath.c" "zmisc.c" "zpacked.c" "zrelbit.c" \
           "zstack.c" "zstring.c" "ztype.c" "zvmem.c" \
           "zchar.c" "zcolor.c" "zfont.c" "zdevice.c" "zgstate.c" \
           "zht.c" "zmatrix.c" "zpaint.c" "zpath.c" "zpath2.c" \
          "gschar.c" "gscolor.c" "gscoord.c" "gsdevice.c" \
          "gsfile.c" "gsfont.c" "gsimage.c" "gsim2out.c" \
          "gsline.c" "gsmatrix.c" "gsmisc.c" \
          "gspaint.c" "gspath.c" "gspath2.c" "gsstate.c" "gstype1.c" \
          "gxcache.c" "gxcolor.c" "gxdither.c" "gxdraw.c" "gxfill.c" \
          "gxht.c" "gxpath.c" "gxpath2.c" "gxstroke.c" \
          "gdevmem.c" "gdevs.c")

COMPILE_FLAGS=" -lm -DNOMEMOPT \
           -DGS_LIB_DEFAULT=\\\"${PROJ_SRC_DIR}:${PROJ_SRC_DIR}/fonts\\\""

RUN_OPTIONS="-DNODISPLAY $PROJ_SRC_DIR/INPUT/large.ps"



BENCH_NAME="make"

SRC_FILES=('commands.c' 'job.c' 'dir.c' 'file.c' 'load.c' 'misc.c' 'main.c' 'read.c' \
       'remake.c' 'remote.c' 'rule.c' 'implicit.c' 'default.c' 'variable.c' 'expand.c' \
       'function.c' 'vpath.c' 'version.c' 'arscan.c' 'ar.c')
COMPILE_FLAGS="-DHAVE_SIGLIST -DNO_LDAV -DNOMEMOPT -DPOSIX"

PROJ_SRC_DIR=$(pwd)
RUN_OPTIONS="-n -f $PROJ_SRC_DIR/INPUT/GNUmakefile.make USEROPT=BWGC VPATH=$PROJ_SRC_DIR"
BENCH_NAME="01-qbsort"

SRC_FILES=( "benchmark.c" "readlist.c" "sort.c" )
COMPILE_FLAGS=" -lm "

PROJ_SRC_DIR=$(pwd)
RUN_OPTIONS="1000"
STDIN="$PROJ_SRC_DIR/benchmark.in3"
BENCH_NAME="03-testtrie"

SRC_FILES=( "charsequence.c" "main.c" "trie.c" )
COMPILE_FLAGS=" -lm "

PROJ_SRC_DIR=$(pwd)
RUN_OPTIONS="$PROJ_SRC_DIR/testtrie.in2"
BENCH_NAME="04-bisect"

SRC_FILES=( "allocvector.c" "bisect_test.c" "dbisect.c" )
COMPILE_FLAGS=" -lm "

PROJ_SRC_DIR=$(pwd)
STDIN="$PROJ_SRC_DIR/bisect_test.in"
BENCH_NAME="05-eks"

SRC_FILES=( "Divsol.c" "Jacobi.c" "MM.c" "QRfact.c" "Triang.c" "main.c" "print.c" )
COMPILE_FLAGS=" -lm "
BENCH_NAME="08-main"

SRC_FILES=( "convert.c" "main.c" "object.c" "trig.c" )
COMPILE_FLAGS=" -lm "
BENCH_NAME="09-vor"

SRC_FILES=( "ch.c" "intersec.c" "pointlis.c" "splay.c" "splay2.c" "vor.c" )
COMPILE_FLAGS=" -lm "
STDIN="vor.in3"
BENCH_NAME="12-IOtest"

SRC_FILES=( "IOtest.c" "IOtestA.c" "IOtestB.c" "IOtestC.c" )
COMPILE_FLAGS=" -lm "
BENCH_NAME="15-trie"

SRC_FILES=( "trie.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" trie.in1 "
BENCH_NAME="17-bintr"

SRC_FILES=( "bintree.c" "bnchmrk.c" )
COMPILE_FLAGS=" -lm "
STDIN=" bnchmrk.in1 "
BENCH_NAME="chomp"

SRC_FILES=( "chomp.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="exptree"

SRC_FILES=( "exptree.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="misr"

SRC_FILES=( "misr.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="queens"

SRC_FILES=( "queens.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="adpcm-rawcaudio"

SRC_FILES=("rawcaudio.c" "adpcm.c")
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=""
STDIN=" ../data/clinton.pcm "
BENCH_NAME="adpcm-rawdaudio"

SRC_FILES=("rawdaudio.c" "adpcm.c")
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=""
STDIN=" ../data/clinton.adpcm "
BENCH_NAME="g721"

SRC_FILES=("encode.c" "g711.c" "g721.c" "g723_24.c" "g723_40.c" "g72x.c")
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=""
STDIN=" ../data/clinton.pcm "
BENCH_NAME="gsm"

SRC_FILES=("add.c" "code.c" "debug.c" "decode.c" "gsm_create.c" 
  "gsm_decode.c" "gsm_destroy.c" "gsm_encode.c" "gsm_explode.c" 
  "gsm_implode.c" "gsm_option.c" "gsm_print.c" "long_term.c" "lpc.c" 
  "preprocess.c" "rpe.c" "short_term.c" "table.c" "toast.c" 
  "toast_alaw.c" "toast_audio.c" "toast_lin.c" "toast_ulaw.c")
COMPILE_FLAGS=" -DNeedFunctionPrototypes=1 -DSASR "
RUN_OPTIONS=" -c ../data/clinton.pcm "
BENCH_NAME="g721"

SRC_FILES=("jcapimin.c" "jcapistd.c" "jctrans.c" "jcparam.c" "jdatadst.c"
  "jcinit.c" "jcmaster.c" "jcmarker.c" "jcmainct.c" "jcprepct.c" "jccoefct.c"
  "jccolor.c" "jcsample.c" "jchuff.c" "jcphuff.c" "jcdctmgr.c" "jfdctfst.c"
  "jfdctflt.c" "jfdctint.c" "jdapimin.c" "jdapistd.c" "jdtrans.c" "jdatasrc.c"
  "jdmaster.c" "jdinput.c" "jdmarker.c" "jdhuff.c" "jdphuff.c" "jdmainct.c"
  "jdcoefct.c" "jdpostct.c" "jddctmgr.c" "jidctfst.c" "jidctflt.c"
  "jidctint.c" "jidctred.c"  "jdsample.c" "jdcolor.c" "jquant1.c" "jquant2.c"
  "jdmerge.c" "jcomapi.c" "jutils.c" "jerror.c" "jmemmgr.c" "jmemnobs.c"
  "cjpeg.c" "rdppm.c" "rdgif.c" "rdtarga.c" "rdrle.c" "rdbmp.c" "rdswitch.c"
  "cdjpeg.c")
COMPILE_FLAGS=" "
RUN_OPTIONS=" -dct int -progressive -opt ../data/testimg.ppm "
BENCH_NAME="mpeg2"

SRC_FILES=("display.c" "gethdr.c" "idct.c" "mpeg2dec.c" "store.c" "verify.c"
              "getbits.c" "getpic.c" "idctref.c" "recon.c" "subspic.c"
              "getblk.c" "getvlc.c" "motion.c" "spatscal.c" "systems.c")
COMPILE_FLAGS=" "
RUN_OPTIONS=" -b ../data/mei16v2.m2v -r -f -o0 tmp "
BENCH_NAME="automotive-basicmath"

SRC_FILES=( "basicmath.c" "cubic.c" "isqrt.c" "rad2deg.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=""
BENCH_NAME="automotive-bitcount"

SRC_FILES=( "bitarray.c" "bitcnt_1.c" "bitcnt_2.c" "bitcnt_3.c" "bitcnt_4.c" "bitcnts.c" "bitfiles.c" "bitstrng.c" "bstr_i.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" 1125000 "
BENCH_NAME="automotive-susan"

SRC_FILES=( "susan.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" input_large.pgm Output/output_large.smoothing.pgm -s "
BENCH_NAME="consumer-jpeg"

SRC_FILES=( "cdjpeg.c" "djpeg.c" "jcapimin.c" "jcapistd.c" "jccoefct.c" "jccolor.c" "jcdctmgr.c" "jchuff.c" "jcinit.c" "jcmainct.c" "jcmarker.c" "jcmaster.c" "jcomapi.c" "jcparam.c" "jcphuff.c" "jcprepct.c" "jcsample.c" "jctrans.c" "jdapimin.c" "jdapistd.c" "jdatadst.c" "jdatasrc.c" "jdcoefct.c" "jdcolor.c" "jddctmgr.c" "jdhuff.c" "jdinput.c" "jdmainct.c" "jdmarker.c" "jdmaster.c" "jdmerge.c" "jdphuff.c" "jdpostct.c" "jdsample.c" "jdtrans.c" "jerror.c" "jfdctflt.c" "jfdctfst.c" "jfdctint.c" "jidctflt.c" "jidctfst.c" "jidctint.c" "jidctred.c" "jmemmgr.c" "jmemnobs.c" "jquant1.c" "jquant2.c" "jutils.c" "rdcolmap.c" "wrbmp.c" "wrgif.c" "wrppm.c" "wrrle.c" "wrtarga.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" -dct int -ppm -outfile Output/output_large_decode.ppm input_large.jpg "
BENCH_NAME="consumer-lame"

SRC_FILES=( "VbrTag.c" "brhist.c" "common.c" "dct64_i386.c" "decode_i386.c" "fft.c" "formatBitstream.c" "get_audio.c" "gpkplotting.c" "gtkanal.c" "id3tag.c" "ieeefloat.c" "interface.c" "l3bitstream.c" "lame.c" "layer3.c" "main.c" "mpglib_main.c" "newmdct.c" "parse.c" "portableio.c" "psymodel.c" "quantize-pvt.c" "quantize.c" "reservoir.c" "rtp.c" "tabinit.c" "tables.c" "takehiro.c" "timestatus.c" "util.c" "vbrquantize.c" "version.c" )
COMPILE_FLAGS=" -lm -DHAVEMPGLIB -DLAMEPARSE -DNDEBUG -D__NO_MATH_INLINES -O -DLAMESNDFILE "
RUN_OPTIONS=" large.wav Output/output_large.mp3 "
BENCH_NAME="network-dijkstra"

SRC_FILES=( "dijkstra.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" input.dat "
BENCH_NAME="network-patricia"

SRC_FILES=( "patricia.c" "patricia_test.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" large.udp "
BENCH_NAME="office-stringsearch"

SRC_FILES=( "bmhasrch.c" "bmhisrch.c" "bmhsrch.c" "pbmsrch.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=""
BENCH_NAME="security-blowfish"

SRC_FILES=( "bf_cbc.c" "bf_cfb64.c" "bf_ecb.c" "bf_enc.c" "bf_ofb64.c" "bf_skey.c" "bftest.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" d output_large.enc output_large.asc 1234567890abcdeffedcba0987654321 "
BENCH_NAME="security-rijndael"

SRC_FILES=( "aes.c" "aesxam.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" input_large.asc large.enc e 1234567890abcdeffedcba09876543211234567890abcdeffedcba0987654321 "
BENCH_NAME="security-sha"

SRC_FILES=( "sha.c" "sha_driver.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" input_large.asc "
BENCH_NAME="telecomm-CRC32"

SRC_FILES=( "crc_32.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" large.pcm "
BENCH_NAME="telecomm-FFT"

SRC_FILES=( "fftmisc.c" "fourierf.c" "main.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" 8 32768 -i "
BENCH_NAME="dt"

SRC_FILES=( "dt.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="evalloop"

SRC_FILES=( "evalloop.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="fbench"

SRC_FILES=( "fbench.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="ffbench"

SRC_FILES=( "ffbench.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="flops-1"

SRC_FILES=( "flops-1.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="flops-2"

SRC_FILES=( "flops-2.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="flops-3"

SRC_FILES=( "flops-3.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="flops-4"

SRC_FILES=( "flops-4.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="flops-5"

SRC_FILES=( "flops-5.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="flops-6"

SRC_FILES=( "flops-6.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="flops-7"

SRC_FILES=( "flops-7.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="flops-8"

SRC_FILES=( "flops-8.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="flops"

SRC_FILES=( "flops.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="fp-convert"

SRC_FILES=( "fp-convert.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="himenobmtxpa"

SRC_FILES=( "himenobmtxpa.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="lowercase"

SRC_FILES=( "lowercase.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="mandel-2"

SRC_FILES=( "mandel-2.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="mandel"

SRC_FILES=( "mandel.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="matmul_f64_4x4"

SRC_FILES=( "matmul_f64_4x4.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="oourafft"

SRC_FILES=( "oourafft.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="perlin"

SRC_FILES=( "perlin.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="pi"

SRC_FILES=( "pi.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="ReedSolomon"

SRC_FILES=( "ReedSolomon.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="revertBits"

SRC_FILES=( "revertBits.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="richards_benchmark"

SRC_FILES=( "richards_benchmark.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="salsa20"

SRC_FILES=( "salsa20.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="whetstone"

SRC_FILES=( "whetstone.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="nbench"

SRC_FILES=("emfloat.c" "misc.c" "nbench0.c" "nbench1.c" "sysspec.c")
COMPILE_FLAGS="-DBASE_ITERATIONS=25"
RUN_OPTIONS=""
BENCH_NAME="dc"

SRC_FILES=("adc.c" "dc.c" "jobcntl.c" "c_print_results.c" "extbuild.c" "rbt.c")
COMPILE_FLAGS=" "
RUN_OPTIONS=" 10000000 ADC.par "

if [[ $SMALL_PROGRAM_SIZE ]]; then
  COMPILE_FLAGS="-DSMALL_PROBLEM_SIZE"
fi
BENCH_NAME="is"

SRC_FILES=( "is.c" )
COMPILE_FLAGS=" "
RUN_OPTIONS=""

if [[ -n $SMALL_PROBLEM_SIZE ]]; then
  COMPILE_FLAGS="-DSMALL_PROBLEM_SIZE"
fi
BENCH_NAME="bh"

SRC_FILES=( "args.c" "newbh.c" "util.c" "walksub.c" )
COMPILE_FLAGS=" -lm -DTORONTO "

PROJ_SRC_DIR=$(pwd)

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="40000 30"
elif [[ -n $SMALL_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="2000 5"
else
  RUN_OPTIONS="20000 20"
fi
BENCH_NAME="bisort"

SRC_FILES=( "args.c" "bitonic.c" )
COMPILE_FLAGS=" -lm -DTORONTO "

PROJ_SRC_DIR=$(pwd)

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="3000000"
else
  RUN_OPTIONS="700000"
fi
BENCH_NAME="em3d"

SRC_FILES=( "args.c" "em3d.c" "main.c" "make_graph.c" "util.c" )
COMPILE_FLAGS=" -lm -DTORONTO "

PROJ_SRC_DIR=$(pwd)

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="1024 1000 125"
else
  RUN_OPTIONS="256 250 35"
fi
BENCH_NAME="health"

SRC_FILES=( "args.c" "health.c" "list.c" "poisson.c" )
COMPILE_FLAGS=" -lm -DTORONTO "

PROJ_SRC_DIR=$(pwd)

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="10 40 1"
elif [[ -n $SMALL_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="8 15 1"
else
  RUN_OPTIONS="9 20 1"
fi
BENCH_NAME="mst"

SRC_FILES=( "args.c" "hash.c" "main.c" "makegraph.c" )
COMPILE_FLAGS=" -lm -DTORONTO "

PROJ_SRC_DIR=$(pwd)

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="4000"
else
  RUN_OPTIONS="1000"
fi
BENCH_NAME="perimeter"

SRC_FILES=( "args.c" "main.c" "maketree.c" )
COMPILE_FLAGS=" -lm -DTORONTO "

PROJ_SRC_DIR=$(pwd)

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="11"
elif [[ -n $SMALL_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="9"
else
  RUN_OPTIONS="10"
fi
BENCH_NAME="power"

SRC_FILES=( "build.c" "compute.c" "main.c" )
COMPILE_FLAGS=" -lm -DTORONTO "
BENCH_NAME="treeadd"

SRC_FILES=( "args.c" "node.c" "par-alloc.c" )
COMPILE_FLAGS=" -lm -DTORONTO "

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="22"
else
  RUN_OPTIONS="20"
fi
BENCH_NAME="tsp"

SRC_FILES=( "args.c" "build.c" "main.c" "tsp.c" )
COMPILE_FLAGS=" -lm -DTORONTO "

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="2048000"
elif [[ -n $SMALL_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="102400"
else
  RUN_OPTIONS="1024000"
fi
BENCH_NAME="voronoi"

SRC_FILES=( "args.c" "newvor.c" "output.c" "vector.c" )
COMPILE_FLAGS=" -lm -DTORONTO "

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="1000000 20 32 7"
elif [[ -n $SMALL_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="10000 20 32 7"
else
  RUN_OPTIONS="100000 20 32 7"
fi
BENCH_NAME="PAQ8p"

SRC_FILES=($(ls *.cpp))
COMPILE_FLAGS=" -DNOASM -DLLVM -lstdc++ -lm "
COMPILER=clang++

if [[ $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS=" -4 file1.in "
else
  RUN_OPTIONS=" -1 small.in "
fi
BENCH_NAME="correlation"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="covariance"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="gemm"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="gemver"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="gesummv"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="symm"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="syr2k"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="syrk"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="trmm"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="2mm"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="3mm"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="atax"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="bicg"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="doitgen"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="mvt"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="cholesky"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="durbin"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="gramschmidt"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="ludcmp"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="lu"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "BENCH_NAME="trisolv"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="deriche"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="floyd-warshall"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="nussinov"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="adi"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="fdtd-2d"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="heat-3d"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="jacobi-1d"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="jacobi-2d"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="seidel-2d"

SRC_FILES=($(ls *.c))

COMPILE_FLAGS=" -I. -DPOLYBENCH_DUMP_ARRAYS "
RUN_OPTIONS=" "
BENCH_NAME="agrep"

SRC_FILES=( "asearch.c" "asearch1.c" "bitap.c" "checkfile.c" "compat.c" "follow.c" "main.c" "maskgen.c" "mgrep.c" "parse.c" "preprocess.c" "sgrep.c" "utilities.c" )

RUN_OPTIONS="-2 int InstructionCombining.cpp"
BENCH_NAME="allroots"

SRC_FILES=( "all.c" "horners.c" "newton.c" )
BENCH_NAME="archie-client"

SRC_FILES=( "aquery.c" "archie.c" "atalloc.c" "dirsend.c" "get_pauth.c" "get_vdir.c" "perrmesg.c" "procquery.c" "ptalloc.c" "regex.c" "stcopy.c" "support.c" "vl_comp.c" "vlalloc.c" )
COMPILE_FLAGS="-I."
BENCH_NAME="assembler"

SRC_FILES=( "assem.c" "buffer.c" "code.c" "convert.c" "op_tab.c" "pass1.c" "pass2.c" "pseudo.c" "record.c" "scan_line.c" "stringI.c" "sym_tab.c" )
COMPILE_FLAGS="-lm"
RUN_OPTIONS=" "
# RUN_OPTIONS="assem.lst"
BENCH_NAME="bison"

SRC_FILES=( "LR0.c" "allocate.c" "closure.c" "conflicts.c" "derives.c" "files.c" "getargs.c" "getopt.c" "gram.c" "lalr.c" "lex.c" "main.c" "nullable.c" "output.c" "print.c" "reader.c" "symtab.c" "warshall.c" )
RUN_OPTIONS="parse.y.in -v"
BENCH_NAME="cdecl"

SRC_FILES=( "cdecl.c" )
COMPILE_FLAGS="-std=gnu89"
STDIN="testset"
BENCH_NAME="compiler"

SRC_FILES=( "emitter.c" "error.c" "init.c" "lexer.c" "main.c" "parser.c" "symbol.c" )

# STDIN=" testset "
BENCH_NAME="fixoutput"

SRC_FILES=( "fixoutput.c" "stringI.c" )
BENCH_NAME="football"

SRC_FILES=( "common.c" "io.c" "sort.c" "stats.c" )
BENCH_NAME="gnugo"

SRC_FILES=( "count.c" "countlib.c" "endgame.c" "eval.c" "exambord.c" "findcolr.c" "findnext.c" "findopen.c" "findpatn.c" "findsavr.c" "findwinr.c" "fioe.c" "genmove.c" "getij.c" "getmove.c" "initmark.c" "main.c" "matchpat.c" "opening.c" "openregn.c" "random.c" "seed.c" "sethand.c" "showbord.c" "showinst.c" "suicide.c" )
STDIN="stdin"
BENCH_NAME="loader"

SRC_FILES=( "convert.c" "load.c" "memory.c" "pass1.c" "pass2.c" "print.c" "stringI.c" "sym_tab.c" )
COMPILE_FLAGS="-lm"
BENCH_NAME="plot2fig"

SRC_FILES=( "alabel.c" "arc.c" "circle.c" "closepl.c" "color.c" "cont.c" "dot.c" "draw_line.c" "erase.c" "fill.c" "fontname.c" "fontsize.c" "label.c" "line.c" "linemod.c" "move.c" "openpl.c" "plot.c" "point.c" "rotate.c" "space.c" )
BENCH_NAME="simulator"

SRC_FILES=( "convert.c" "debugger.c" "format.c" "instruct.c" "instruct2.c" "interupt.c" "loadexe.c" "machine.c" "memory.c" "print.c" "sim_debug.c" "stringI.c" "sym_tab.c" )
COMPILE_FLAGS="-lm"
BENCH_NAME="TimerWolfMC"

SRC_FILES=( "23tree.c" "addpins.c" "analyze.c" "bellman.c" "buster.c" "changraph.c" "checkpen.c" "config1.c" "config2.c" "config3.c" "density.c" "doborder.c" "doublecheck.c" "finalout.c" "finalpin.c" "findcheck.c" "findcost.c" "findloc.c" "findnodes.c" "findside.c" "fixpenal.c" "fulllink.c" "fuloop.c" "genorient.c" "gentwf.c" "ggenorien.c" "gglobals.c" "globals.c" "gmain.c" "goverlap.c" "goverlapf.c" "goverlapx.c" "gpass2.c" "grdcell.c" "grepair.c" "hash.c" "hprobes.c" "initbb.c" "loadbins.c" "loadpg.c" "main.c" "makebins.c" "makelink.c" "makesite.c" "move.c" "mshortest.c" "mt.c" "neworient.c" "outbig.c" "outgeo.c" "outpin.c" "output.c" "outsmall.c" "parser.c" "pass2.c" "perimeter.c" "placepads.c" "placepin.c" "prboard.c" "prepair.c" "prestrict.c" "printgph.c" "printnets.c" "procesnet.c" "readcells.c" "readgeo.c" "readgraph.c" "readnets.c" "readpar.c" "readpnode.c" "rebin.c" "reduceg.c" "rglobals.c" "rmain.c" "routenet.c" "savewolf.c" "scrapnet.c" "scrappin.c" "selectpin.c" "setpwates.c" "shortpath.c" "test2loop.c" "testloop.c" "twstats.c" "uaspect.c" "ufixnet.c" "ufixpin.c" "uloop.c" "unbust.c" "upin.c" "upinswap.c" "usite0.c" "usite1.c" "usite2.c" "usiteo1.c" "usiteo2.c" "usoftnet.c" "usoftpin.c" "utemp.c" "vprobes.c" "watesides.c" "wirecosts.c" "wireest.c" "wireratio.c" "woverlap.c" "woverlapf.c" "woverlapx.c" "xgraph.c" "ygraph.c" )
COMPILE_FLAGS="-lm"
BENCH_NAME="unix-smail"

SRC_FILES=( "alias.c" "deliver.c" "getopt.c" "getpath.c" "headers.c" "main.c" "map.c" "misc.c" "pw.c" "resolve.c" "str.c" )
RUN_OPTIONS="-v ALL"
STDIN="main.c"
BENCH_NAME="unix-tbl"

SRC_FILES=( "t..c" "t0.c" "t1.c" "t2.c" "t3.c" "t4.c" "t5.c" "t6.c" "t7.c" "t8.c" "t9.c" "tb.c" "tc.c" "te.c" "tf.c" "tg.c" "ti.c" "tm.c" "ts.c" "tt.c" "tu.c" "tv.c" )
BENCH_NAME="anagram"

SRC_FILES=("anagram.c")
COMPILE_FLAGS=" -lm -D_POSIX_SOURCE -DHYPRE_TIMING -DHYPRE_SEQUENTIAL "
RUN_OPTIONS=" words 2 "
STDIN="input.OUT"
BENCH_NAME="bc"

SRC_FILES=( "bc.c" "execute.c" "global.c" "load.c" "main.c" "number.c" "scan.c" "storage.c" "util.c" )
COMPILE_FLAGS=" "
RUN_OPTIONS=" "
STDIN="primes.b"
BENCH_NAME="ft"

SRC_FILES=( "Fheap.c" "Fsanity.c" "ft.c" "graph.c" "item.c" )
COMPILE_FLAGS=" "
RUN_OPTIONS=" 1500 100000 "
BENCH_NAME="ks"

SRC_FILES=( "KS-1.c" "KS-2.c" )
COMPILE_FLAGS=" "
RUN_OPTIONS=" KL-4.in "
BENCH_NAME="yacr2"

SRC_FILES=( "assign.c" "channel.c" "hcg.c" "main.c" "maze.c" "option.c" "vcg.c" )
COMPILE_FLAGS=" -DTODD "
RUN_OPTIONS=" input2.in "
BENCH_NAME="SciMark2-C"

SRC_FILES=( "FFT.c" "LU.c" "MonteCarlo.c" "Random.c" "SOR.c" "SparseCompRow.c" "Stopwatch.c" "array.c" "kernel.c" "scimark2.c" )
COMPILE_FLAGS=" -lm "

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="-large"
else
  RUN_OPTIONS=" "
fi
BENCH_NAME="ackermann"

SRC_FILES=( "ackermann.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="ary3"

SRC_FILES=( "ary3.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="fib2"

SRC_FILES=( "fib2.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="hash"

SRC_FILES=( "hash.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="heapsort"

SRC_FILES=( "heapsort.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="hello"

SRC_FILES=( "hello.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="lists"

SRC_FILES=( "lists.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="matrix"

SRC_FILES=( "matrix.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="methcall"

SRC_FILES=( "methcall.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="nestedloop"

SRC_FILES=( "nestedloop.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="objinst"

SRC_FILES=( "objinst.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="random"

SRC_FILES=( "random.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="sieve"

SRC_FILES=( "sieve.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="strcat"

SRC_FILES=( "strcat.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="sim"

SRC_FILES=( "sim.c" )
COMPILE_FLAGS=" -DUNIX "
RUN_OPTIONS=" 8 tob.38-44 liv.42-48 "
BENCH_NAME="Bubblesort"

SRC_FILES=( "Bubblesort.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="FloatMM"

SRC_FILES=( "FloatMM.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="IntMM"

SRC_FILES=( "IntMM.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="Oscar"

SRC_FILES=( "Oscar.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="Puzzle"

SRC_FILES=( "Puzzle.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="Queens"

SRC_FILES=( "Queens.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="Quicksort"

SRC_FILES=( "Quicksort.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="RealMM"

SRC_FILES=( "RealMM.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="Towers"

SRC_FILES=( "Towers.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="Treesort"

SRC_FILES=( "Treesort.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" "
BENCH_NAME="test"

SRC_FILES=( "t11.c" )
COMPILE_FLAGS=" "
RUN_OPTIONS="10"
BENCH_NAME="tramp3d-v4"

SRC_FILES=( "tramp3d-v4.cpp" )
COMPILER=clang++
COMPILE_FLAGS=" -lm -fno-exceptions -lstdc++ "

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS=" --cartvis 1.0 0.0 --rhomin 1e-8 -n 10 --domain 32 32 32"
else
  RUN_OPTIONS=" --cartvis 1.0 0.0 --rhomin 1e-8 -n 4 --domain 32 32 32"
fi
BENCH_NAME="enc-3des"

SRC_FILES=( "des.c" )
COMPILE_FLAGS=" "

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="200"
elif [[ -n $SMALL_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="10"
else
  RUN_OPTIONS="100"
fi
BENCH_NAME="enc-md5"

SRC_FILES=("md5.c")
COMPILE_FLAGS=" "

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="50"
elif [[ -n $SMALL_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="1"
else
  RUN_OPTIONS="10"
fi
BENCH_NAME="enc-pc1"

SRC_FILES=("pc1cod.c")
COMPILE_FLAGS=" "

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="20000000"
elif [[ -n $SMALL_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="1000000"
else
  RUN_OPTIONS="5000000"
fi
BENCH_NAME="enc-rc4"

SRC_FILES=("rc4.c")
COMPILE_FLAGS=" "

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="1000000"
elif [[ -n $SMALL_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="2000"
else
  RUN_OPTIONS="200000"
fi
BENCH_NAME="netbench-crc"

SRC_FILES=( "crc32.c" "packet.c" )
COMPILE_FLAGS=" "

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="40000"
elif [[ -n $SMALL_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="1000"
else
  RUN_OPTIONS="12000"
fi
BENCH_NAME="netbench-url"

SRC_FILES=( "packet.c" "search.c" "url.c" "utils.c" )
COMPILE_FLAGS=" "

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="medium_inputs 1400"
elif [[ -n $SMALL_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="medium_inputs 100"
else
  RUN_OPTIONS="medium_inputs 900"
fi
BENCH_NAME="ControlFlow-dbl"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -lm -std=gnu99"
RUN_OPTIONS=" 2325 14 "
BENCH_NAME="ControlFlow-flt"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 "
RUN_OPTIONS=" 2325 5 "
BENCH_NAME="ControlLoops-dbl"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 "
RUN_OPTIONS=" 1640 14 "
BENCH_NAME="ControlLoops-flt"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 "
RUN_OPTIONS=" 1640 5 "
BENCH_NAME="CrossingThresholds-dbl"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 5880 14 "
BENCH_NAME="CrossingThresholds-flt"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 5880 5 "
BENCH_NAME="Equivalencing-dbl"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 3125 14 "
BENCH_NAME="Equivalencing-flt"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 3125 5 "
BENCH_NAME="Expansion-dbl"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 4160 14 "
BENCH_NAME="Expansion-flt"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 4160 5 "
BENCH_NAME="GlobalDataFlow-dbl"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 3450 14 "
BENCH_NAME="GlobalDataFlow-flt"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 3450 5 "
BENCH_NAME="IndirectAddressing-dbl"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 12500 14 "
BENCH_NAME="IndirectAddressing-flt"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 12500 5 "
BENCH_NAME="InductionVariable-dbl"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 9100 14 "
BENCH_NAME="InductionVariable-flt"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 9100 5 "
BENCH_NAME="LinearDependence-dbl"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 3570 14 "
BENCH_NAME="LinearDependence-flt"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 3570 5 "
BENCH_NAME="LoopRerolling-dbl"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 5260 14 "
BENCH_NAME="LoopRerolling-flt"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 5260 5 "
BENCH_NAME="LoopRestructuring-dbl"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 4350 14 "
BENCH_NAME="LoopRestructuring-flt"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 4350 5 "
BENCH_NAME="NodeSplitting-dbl"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 10000 14 "
BENCH_NAME="NodeSplitting-flt"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 10000 5 "
BENCH_NAME="Packing-dbl"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 50000 14 "
BENCH_NAME="Packing-flt"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 50000 5 "
BENCH_NAME="Recurrences-dbl"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 20000 14 "
BENCH_NAME="Recurrences-flt"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 20000 5 "
BENCH_NAME="Reductions-dbl"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 1670 14 "
BENCH_NAME="Reductions-flt"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 1670 5 "
BENCH_NAME="Searching-dbl"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 80000 14 "
BENCH_NAME="Searching-flt"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 80000 5 "
BENCH_NAME="StatementReordering-dbl"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 20000 14 "
BENCH_NAME="StatementReordering-flt"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 20000 5 "
BENCH_NAME="Symbolics-dbl"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 9090 14 "
BENCH_NAME="Symbolics-flt"

SRC_FILES=( "dummy.c" "tsc.c" )
COMPILE_FLAGS=" -std=gnu99 -lm "
RUN_OPTIONS=" 9090 5 "
BENCH_NAME="8b10b"

SRC_FILES=( "calc.c" "main.c" "testbench.c" )
COMPILE_FLAGS=""

PROJ_SRC_DIR=$(pwd)
if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="$PROJ_SRC_DIR/input 20000"
else
  RUN_OPTIONS="$PROJ_SRC_DIR/input 2000"
fi
BENCH_NAME="beamformer"

SRC_FILES=( "beamformer.c" )
COMPILE_FLAGS=" -lm -DFP_ABSTOLERANCE=1e-5 "

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="-i 400"
elif [[ -n $SMALL_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="-i 25"
else
  RUN_OPTIONS="-i 140"
fi
BENCH_NAME="bmm"

SRC_FILES=( "bmm.c" )
COMPILE_FLAGS=""

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="1024 1024"
elif [[ -n $SMALL_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="128 32"
else
  # medium problem size
  RUN_OPTIONS="1024 64"
fi
BENCH_NAME="dbms"

SRC_FILES=( "calcMetricsData.c" "chooseEntry.c" "clearLine.c" "closeFiles.c" "consistent.c" "createDataObject.c" "createIndexEntry.c" "createIndexNode.c" "delete.c" "deleteDataObject.c" "deleteEntry.c" "deleteIndexEntry.c" "deleteIndexNode.c" "errorMessage.c" "getDeleteCommand.c" "getFloat.c" "getInitCommand.c" "getInsertCommand.c" "getInt.c" "getKeyAttribute.c" "getNextCommandCode.c" "getNonKeyAttribute.c" "getQueryCommand.c" "getString.c" "initMetricsData.c" "insert.c" "insertEntry.c" "keyUnion.c" "main.c" "openFiles.c" "outputMetricsData.c" "outputQuery.c" "partitionEntries.c" "penalty.c" "query.c" "setMetricsData.c" "splitNode.c" "timer.c" "updateMetricsData.c" "valid.c" "volume.c" )
COMPILE_FLAGS=""

PROJ_SRC_DIR=$(pwd)
if [[ -n $SMALL_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="-i ${PROJ_SRC_DIR}/dbms.train.in"
else
  RUN_OPTIONS="-i ${PROJ_SRC_DIR}/dbms.ref.in"
fi
BENCH_NAME="ecbdes"

SRC_FILES=( "des_enc.c" "driver.c" "ecb_enc.c" "set_key.c" )
COMPILE_FLAGS=""

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="34"
elif [[ -n $SMALL_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="4"
else
  # medium problem size
  RUN_OPTIONS="16"
fi
