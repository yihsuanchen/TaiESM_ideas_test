#!/bin/bash 
#===================================
#  Bourne-Again shell script
#
#  Description:
#
#
#  Usage:
#
#
#  History:
#
#  Author:
#    Yi-Hsuan Chen
#    yihsuan@umich.edu
#===================================

#*************************************************
# Description:
#   process files that input from command lines
#*************************************************

##################
# program start
##################

# read input parameters from command line
pram_num=$#

if [ $pram_num -eq 0 ]; then
  echo "No given file!"
  echo "program stop"
  exit 3
else

  for (( i=0; i<=$pram_num; i=i+1  ))
  do
    infile[i]=$1
    shift
  done
fi

# get total number of files
num_infile=$((${#infile[@]}-1))

# check with user
echo "------------------------"
echo "Change path of user-given NCL files"
echo ""
for ((i=0; i<$num_infile; i=i+1))
do
  j=$(($i+1))
  echo "  input files        : $j/$num_infile, [${infile[$i]}]"
done
echo "------------------------"
read -p "Is is correct? (y/n)  " choice
echo " "
if [ ! $choice ] || [ ! $choice == "y" ]; then
  echo "Cancel by user"
  echo "program stop"
  exit 5
fi

# process each file
for((i=0; i<$num_infile; i=i+1))
do
  file1=${infile[$i]}
  echo $i,$file1
  convert -trim $file1 $file1 && echo "Done. trim"
done

# convert ... png +append png
# convert x1-fig_wCTL2-PBLH-ANN-CTL_allMCTL.png x1-fig_wCTL2-TS-ANN-CTL_allMCTL.png x1-fig_wCTL2-SHFLX-ANN-CTL_allMCTL.png x1-fig_wCTL2-LHFLX-ANN-CTL_allMCTL.png +append y1_ts-ANN.png
# convert x1-fig_wCTL2-PBLH-DJF-CTL_allMCTL.png x1-fig_wCTL2-TS-DJF-CTL_allMCTL.png x1-fig_wCTL2-SHFLX-DJF-CTL_allMCTL.png x1-fig_wCTL2-LHFLX-DJF-CTL_allMCTL.png +append y1_ts-DJF.png
# convert x1-fig_wCTL2-PBLH-JJA-CTL_allMCTL.png x1-fig_wCTL2-TS-JJA-CTL_allMCTL.png x1-fig_wCTL2-SHFLX-JJA-CTL_allMCTL.png x1-fig_wCTL2-LHFLX-JJA-CTL_allMCTL.png +append y1_ts-JJA.png

# convert x1-fig_wCTL2-CLDLOW-ANN-CTL_allMCTL.png x1-fig_wCTL2-TGCLDLWP-ANN-CTL_allMCTL.png x1-fig_wCTL2-FSDS-ANN-CTL_allMCTL.png x1-fig_wCTL2-FSNTOA-ANN-CTL_allMCTL.png +append y1_cld-ANN.png
# convert x1-fig_wCTL2-CLDLOW-DJF-CTL_allMCTL.png x1-fig_wCTL2-TGCLDLWP-DJF-CTL_allMCTL.png x1-fig_wCTL2-FSDS-DJF-CTL_allMCTL.png x1-fig_wCTL2-FSNTOA-DJF-CTL_allMCTL.png +append y1_cld-DJF.png
# convert x1-fig_wCTL2-CLDLOW-JJA-CTL_allMCTL.png x1-fig_wCTL2-TGCLDLWP-JJA-CTL_allMCTL.png x1-fig_wCTL2-FSDS-JJA-CTL_allMCTL.png x1-fig_wCTL2-FSNTOA-JJA-CTL_allMCTL.png +append y1_cld-JJA.png

exit 0

