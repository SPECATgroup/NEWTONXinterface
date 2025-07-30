#!/bin/bash -l  
#SBATCH --job-name=initcond
#SBATCH --time=48:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-core=1
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=2
#SBATCH --output=test.out
#SBATCH --error=test.err
#SBATCH --partition=base
#####SBATCH --constraint=sapphire
#SBATCH --mem=180G

module load gcc12-env
module load gcc openmpi oneapi-mkl libint libxc gsl fftw
module load autoconf/2.69 automake/1.16.5 netlib-lapack openblas

#module load cp2k/8.2
export NX=/gxfs_home/cau/suphc356/NEWTONX/newtonx_CS_ownfork_Sept2024_INITCOND/bin
export PATH=$PATH:$NX

source /gxfs_work/cau/suphc356/cp2k_gcc/tools/toolchain/install/setup
export CP2K=/gxfs_work/cau/suphc356/cp2k_gcc/exe/local/
export PATH=$PATH:$CP2K
#export PATH=$PATH:$CP2K
#export PATH=$PATH:$NX

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

## export CIOVERLAP="/gxfs_home/cau/suphc356/NEWTONX/newtonx_CS_ownfork/bin/cioverlap-64"

export OMP_STACKSIZE=256M
ulimit -s unlimited

#ulimit -s unlimited
#export CRAY_CUDA_MPS=1
#
#srun /gxfs_home/cau/suphc332/CP2K/cp2k_master_toolchain_ohne_libint/exe/local/cp2k.psmp -i cp2k.inp -o cp2k.out
mpirun -n 16 cp2k.psmp -i cp2k.inp -o cp2k.out
 #mpirun -np 64 cp2k.psmp -i cp2k.inp -o cp2k.out
#/gxfs_home/cau/suphc356/NEWTONX/newtonx_CS_ownfork_Sept2024_INITCOND/bin/initcond.pl > initcond.out 
jobinfo
