#!/bin/bash
#
#SBATCH --job-name=Chansoo
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --mem=120GB
#SBATCH --time=24:00:00

module purge
module load r/intel/3.4.2

R --no-save -q -f doc_2_vec.R
