#! /bin/bash
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
URL_GENOME=$3
URL_ANNOT=$4

W_PATH=$W_DIR/$EXP_NAME

## Accesing the working directory
cd $W_PATH

## Creating the structure
mkdir genome
mkdir annotation
mkdir samples
mkdir results

## Creating subfolders for each sample
cd samples

mkdir chip
mkdir control

## Downloading annotation
echo "Downloading annotation"
echo "Downloading annotation" >> $W_PATH/logs.txt

cd ../annotation
wget -O annotation.gtf.gz $URL_ANNOT
gunzip annotation.gtf.gz


## Downloading reference genome
echo "Downloading reference genome"
echo "Downloading reference genome" >> $W_PATH/logs.txt

cd ../genome
wget -O genome.fa.gz $URL_GENOME
gunzip genome.fa.gz


## Building index for reference genome
echo "Building index for reference genome"
echo "Building index for reference genome" >> $W_PATH/logs.txt

bowtie-build genome.fa genome
