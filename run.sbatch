#!/bin/bash
#SBATCH --mail-type=ALL --mail-user=ajermyn@flatironinstitute.org
#SBATCH -n 1
#SBATCH --partition=cca
#SBATCH --time=23:59:00

export MESASDK_ROOT="/mnt/home/ajermyn/Software/MESA/mesasdk"
source $MESASDK_ROOT/bin/mesasdk_init.sh
export MESA_DIR="/mnt/home/ajermyn/Software/MESA/mesa-r21.12.1"

export CURRENT_DIR=$(pwd)
export CURRENT_NAME=$(date +%F%T.%N)

cd /scratch
mkdir $CURRENT_NAME
cd $CURRENT_NAME
mv $CURRENT_DIR/* ./

timeout 23h ./run_grid.sh >> slurm.out


cd ..
mv $CURRENT_NAME/* $CURRENT_DIR/

wait
