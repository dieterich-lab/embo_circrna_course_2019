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
#SBATCH -c 8
#SBATCH --mem=20G
#SBATCH -J "flexbar paired"

# check if we have 4 arguments
if [ ! $# == 4 ]; then
  echo "Usage: $0 [Read 1 file] [Read 2 file] [target dir e.g. /tmp/] [R1 marker, e.g. _R1]"
  exit
fi

# $1 -> Read 1
# $2 -> Read 2
# $3 -> Target directory

# remove the file extension and potential "R1" markings
# (works for double extension, e.g. .fastq.gz)
target=`expr ${1/$4/} : '\(.*\)\..*\.'`


# run on 8 CPUs
# compress with bz2
# only 30nt or longer
# no uncalled bases
# quality min phred 28
# use sanger quality values (i.e. Illumina 1.9+ encoding)

flexbar -r $1 -p $2 -t $3/$target  -n 8 -z GZ -m 30 -u 0  -q TAIL -qt 28 -as "AGATCGGAAGAG" -qf sanger -j
