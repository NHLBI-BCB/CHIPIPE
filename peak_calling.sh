#$ -S /bin/bash
#$ -V
#$ -cwd
#$ -j yes

## Copyright 2016 Blanca Bagnos, Gonzalo Perez y Pablo Garcia.
## This file is part of CHIPIPE.

## CHIPIPE is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.

##  CHIPIPE is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.

##  You should have received a copy of the GNU General Public License
##  along with CHIPIPE.  If not, see <http://www.gnu.org/licenses/>.

W_DIR=$1
EXP_NAME=$2

W_PATH=$W_DIR/$EXP_NAME

cd $W_PATH/results

macs2 callpeak -t $W_PATH/samples/chip/chip.sam -c $W_PATH/samples/control/control.sam -f SAM -n $EXP_NAME --outdir .

Rscript ${EXP_NAME}_model.r


