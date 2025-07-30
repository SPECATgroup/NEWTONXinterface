#!/bin/bash -l  
#SBATCH --job-name=initcond
#SBATCH --time=48:00:00
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=1
#SBATCH --output=test.out
#SBATCH --error=test.err
#SBATCH --partition=base
#SBATCH --mem=180G

module load gcc12-env/12.1.0
module load gcc/12.1.0
module load openmpi/4.1.3
module load intel-mkl/2022.1.0
module load libint/2.6.0
module load libxc/6.1.0
module load gsl/2.7.1
module load fftw/3.3.10-with-openmpi-4.1.3

source /zfshome/suphc356/SOFTWARE/CP2K/cp2k_master/tools/toolchain/install/setup
export CP2K=/zfshome/suphc356/SOFTWARE/CP2K/cp2k_master/exe/local
export PATH=$PATH:$CP2K

#module load intel2021-env/2021.6.0
#module load intel/2021.6.0
#module load intel-mpi/2021.6.0
#module load libint/2.6.0
#module load intel-mkl/2022.1.0
#module load gsl/2.7.1
#module load cp2k/2023.1
#module load cluster-env/default
#module load turbomole-mpi/7.7

#source /work_beegfs/suphc356/CP2K/cp2k_master/tools/toolchain/install/setup
#export CP2K=/zfshome/sw/spack/spack0.18.1/usr/opt/spack/linux-rocky8-x86_64/intel-2021.6.0/cp2k-2023.1-x2ysmlrbt5lefiwklgbv7c7h5mnt4tyn/bin

#module load gcc12-env/12.1.0
#module load gcc/13.2.0
#module load gsl/2.7.1
#module load autoconf/2.69
#module load automake/1.15.1
#module load netlib-lapack/3.11.0
#module load openblas
#
#export NX=/zfshome/suphc356/SOFTWARE/NEWTONX/newtonx_CS_ownfork_Nov2024/bin
#export PATH=$PATH:$NX
#
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

export OMP_STACKSIZE=256M
ulimit -s unlimited

##NEWTONX
jobinfo
#/zfshome/suphc356/SOFTWARE/NEWTONX/newtonx_CS_ownfork_Nov2024/bin/initcond.pl > initcond.out

##CP2K
mpirun -np 64 cp2k.psmp -i cp2k.inp -o cp2k.out

#rundir=`pwd`
#rm ${rundir}/RESULTS/sh.out

