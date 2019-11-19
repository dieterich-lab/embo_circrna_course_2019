#!/bin/bash

# Copyright (C) 2019 Tobias Jakobi
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either self.version 3 of the License, or
# (at your option) any later self.version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# @Author: Tobias Jakobi <tjakobi>
# @Email:  tobias.jakobi@med.uni-heidelberg.de
# @Project: University Hospital Heidelberg, Section of Bioinformatics and Systems Cardiology

#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 20
#SBATCH --mem=20G
#SBATCH -J "bowtie2 rRNA filtering"


# check if we have 5 arguments
if [ ! $# == 5 ]; then
  echo "Usage: $0 [rRNA index argument] [Read 1 file] [Read 2 file] [target dir e.g. /awesome/project/] [R1 marker, e.g. R1 or 1_sequence]"
  exit
fi

# $1 -> rRNA index
# $2 -> Read 1
# $3 -> Read 2
# $4 -> Target directory
# $5 -> R1 marker

# remove the file extension and potential "R1" markings
# (works for double extension, e.g. .fastq.gz)
target=`expr ${2/$5/} : '\(.*\)\..*\.' | sed 's/_1$//g' `
#echo $target
#exit
# load the bowtie2 module
module load bowtie2

# SAM output goes to /dev/null
# run on 20 CPUs
# set fixed seed
# memory mapped IO for multiple instances
# display timing information
# write gz unmapping reads [== no rRNA] to target dir

bowtie2 -S /dev/null -x $1 -1 $2 -2 $3 --no-unal --omit-sec-seq --threads 8 --mm --seed 1337 --time --un-conc-gz $4/$target.fastq.gz 2> $4/$target.log
