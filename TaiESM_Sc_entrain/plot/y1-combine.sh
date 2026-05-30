#!/bin/bash

#opt="1"
opt="3"
vars=(
"PBLH" "TS"  "TREFHT"  "QREFHT"  
              "PRECC" "PRECL"  "TMQ"  
              "CLDLOW" "CLDTOT"  "TGCLDLWP"  
              "SHFLX" "LHFLX"  "FLNS"  "FSNS"  "FLDS"  "FSDS"  
              "FSNTOA"  "FSNTOAC"  "FLUT"  "FLUTC"  "SWCF"  "LWCF"
	      )


#unset vars
#opt="2"
#vars=("freq_ke_factor" "ke_factor" "z_cldtop_PBL" "kvh_kt_orig")


for var in "${vars[@]}"; do

    file_ctl_BF="fig_ctl_F2000_B2000-${var}-ANN-CTL_AGCM_allMCTL_AGCM.png"
    file_kt1_BF="fig_kt1_F2000_B2000-${var}-ANN-mod_Ke_cldtop_AGCM_allMmod_Ke_cldtop_AGCM.png"
    file_kt2_BF="fig_kt2_F2000_B2000-${var}-ANN-mod_Ke_pbltop_AGCM_allMmod_Ke_pbltop_AGCM.png"

    file_B_all="fig_wCTL2_B2000-${var}-ANN-CTL_coupled_allMCTL_coupled.png"
    file_F_all="fig_wCTL2_F2000-${var}-ANN-CTL_AGCM_allMCTL_AGCM.png"

    #--- get files_combined
    if [ $opt == "1" ]; then 
      files_combined="$file_ctl_BF $file_kt1_BF $file_kt2_BF $file_F_all $file_B_all"
      outfile="yy1-${var}.png"

    elif [ $opt == "2" ]; then
      files_combined="$file_kt1_BF $file_kt2_BF"
      outfile="yy1-${var}.png"

    elif [ $opt == "3" ]; then
      files_combined="$file_F_all $file_B_all"
      outfile="yy2-${var}.png"

    else
      echo "files_combined is not set" 
      exit 1      
    fi

  echo "Combining $var for files [$files_combined]..."
  convert $files_combined +append "$outfile"

done
