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
SAMPLE=$3
URL_SAMPLE=$4

W_PATH=$W_DIR/$EXP_NAME

## Accessing $SAMPLE directory and downloading $SAMPLE file

cd $W_PATH/samples/$SAMPLE

echo "Accessing $SAMPLE directory" >> $W_PATH/logs.txt
echo "Downloading $SAMPLE file" >> $W_PATH/logs.txt

wget -O $SAMPLE.sra $URL_SAMPLE

echo "$SAMPLE.sra Downloaded" >> $W_PATH/logs.txt

## Dumping files and Quality Control (QC)

fastq-dump $SAMPLE.sra
rm $SAMPLE.sra

fastqc $SAMPLE.fastq
bowtie -S -v 2 --best --strata -m 1 $W_PATH/genome/genome $SAMPLE.fastq > $SAMPLE.sam

## Synchronisation point using a blackboard:

## Writing information to the blackboard:

echo "$SAMPLE DONE" >> $W_PATH/blackboard.txt

## Reading information from the blackboard

STATUS=$( wc -l $W_PATH/blackboard.txt | awk '{print $1}' )

## Checking point of synchronization to check whether or not all samples are done

if [ $STATUS -eq 2 ]
	then
		echo "Running Peak Calling Script"
		echo "Running Peak Calling Script" >> $W_PATH/logs.txt
		qsub -N peak_calling -o log_peakcalling $HOME/opt/CHIPIPE_FOLDER/peak_calling.sh $W_DIR $EXP_NAME
fi
