#!/bin/bash -l  
#SBATCH --job-name=ba10
#SBATCH --time=48:00:00
#SBATCH --nodes=2
#SBATCH --ntasks-per-core=1
#SBATCH --ntasks-per-node=32
#SBATCH --cpus-per-task=1
#SBATCH --output=test.out
#SBATCH --error=test.err
#SBATCH --partition=base
#SBATCH --mem=180G

module load gcc12-env
module load gcc openmpi oneapi-mkl libint libxc gsl fftw
module load autoconf/2.69 automake/1.16.5 netlib-lapack openblas

source /gxfs_work/cau/suphc356/cp2k_gcc/tools/toolchain/install/setup
export CP2K=/gxfs_work/cau/suphc356/cp2k_gcc/exe/local/
export PATH=$PATH:$CP2K

export NX=/gxfs_home/cau/suphc356/NEWTONX/newtonx_CS_ownfork_Sept2024/bin
export PATH=$PATH:$NX

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

export OMP_STACKSIZE=256M
ulimit -s unlimited

/gxfs_home/cau/suphc356/NEWTONX/newtonx_CS_ownfork_Sept2024/bin/moldyn.pl > moldyn.out

#rundir=`pwd`
#rm ${rundir}/RESULTS/sh.out

jobinfo
