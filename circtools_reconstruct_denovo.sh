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
#SBATCH --mem=100G
#SBATCH -J "circtools reconstruct denovo"
#SBATCH -p general

# check if we have 2 arguments
if [ ! $# == 2 ]; then
  echo "Usage: $0 [Input directory] [Sample name]"
  exit
fi


guided_denovo_circle_structure_parallel -c 8 -I ${1} -N ${2} -T /tmp/ 
