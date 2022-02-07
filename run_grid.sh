#!/bin/bash

export MESASDK_ROOT="/mnt/home/ajermyn/Software/MESA/mesasdk"
source $MESASDK_ROOT/bin/mesasdk_init.sh
export MESA_DIR="/mnt/home/ajermyn/Software/MESA/mesa-r21.12.1"
export OMP_NUM_THREADS=4


echo "Compiling..."
cd template
./mk &> ../mk.out
cd ..
echo "Done compiling."

echo "Starting runs."
mkdir runs

for j in 1.0 1.2 1.4 1.6 1.8 2.0
do
    for k in 0.005 0.01 0.015 0.02 0.03
    do
        rm -r runs/$j_$k
        cp -R template runs/$j_$k    
        cd runs/$j_$k
        sed -i "s/MMM/$j/" inlist_project
        sed -i "s/ZZZ/$k/" inlist_project
        echo "Running Model..." $j_$k
        ./rn &> rn.out &
        cd ../../
    done
done

wait
