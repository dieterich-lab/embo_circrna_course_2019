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
#SBATCH --mem=250G
#SBATCH -J "circtools detect"


# check if we have 8 arguments
if [ ! $# == 8 ]; then
  echo "Usage: $0 [Sample sheet file] [GTF file] [Genome FASTA file] [Mate 1 file] [Mate 2 file] [BAM list file] [Repeats] [target dir e.g. project/]"
  exit
fi

circtools detect @$1 -D -an $2 -A $3 -Pi -mt1 @$4 -mt2 @$5 -B @$6 -fg -M -Nr 2 2 -G -k -O $8 -F -t ${8}_DCC_temp/ -L 20 -T 8
