#!/bin/bash

export MESASDK_ROOT="/mnt/home/ajermyn/Software/MESA/mesasdk"
source $MESASDK_ROOT/bin/mesasdk_init.sh
export MESA_DIR="/mnt/home/ajermyn/Software/MESA/mesa-r21.12.1"
export OMP_NUM_THREADS=20


echo "Compiling..."
cd template
./mk &> ../mk.out
cd ..
echo "Done compiling."

echo "Starting runs."
mkdir runs

for j in 1.0 1.2 1.4 1.6 1.8 2.0
do
    rm -r runs/$j
    cp -R template runs/$j    
    cd runs/$j
    sed -i "s/MMM/$j/" inlist_project
    echo "Running Model..." $j
    ./rn &> rn.out &
    cd ../../
done

wait
