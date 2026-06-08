load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
load "/lfs/home/yihsuanc/scripts/ncl//ignorantNCL.ncl"
;load "./ignorantNCL.ncl"
load "/lfs/home/yihsuanc/scripts/ncl//ignorantNCL-colormaps.ncl"
;load "zz-read_parameters.ncl"

begin

;--------------------
; Description:
;   plot contour over map of CESM files, variables, and time stpes
;--------------------

;%%%%%%%%%%%%%%%%%%%%%%%%%
; To-do list
;   1. rename output files in choice 1-7
;      file name: head-type-file-var-step-.png. REF: choice 8
;%%%%%%%%%%%%%%%%%%%%%%%%%

;-------------------
; general settings
;-------------------

  ; file name: head-type-file-var-step-.png
  wks_type = "png"
  plotname_type = "cn_map"
  stepname = "step"

  mapview = ""
  ;mapview = "polar_NH"
  ;mapview = "polar_SH"

  plotname_head = "fig-"
  txString_ALL = "TaiAM1, F2000, 10-yr climo (Year 3-12)"
;
;---------------------------------------
; set files, variables, suffiexes, and steps
;---------------------------------------
  
  ;**********************************
  ; set files, suffixes, and steps
  ;**********************************

  ;option_group = True          ; group infiles, e.g. plot 2,4,6 and plot 1-2,3-4,5-6
  option_group = False          ; Done. choice 1 & 2
    option_group@nfile_per_group = 2

  ;opt_infiles = "with_CTL"
  ;opt_infiles = "F2000_with_CTL_2"
  ;opt_infiles = "wo_CTL"
  ;opt_infiles = "wo_CTL_2"
  ;opt_infiles = "B2000_with_CTL_2"
  ;opt_infiles = "B2000_wo_CTL_2"
  ;opt_infiles = "F2000_B2000"

  ;;; ncl 'opt_infiles = "kt1_F2000_B2000"' 1a-nf1v.ncl ; ncl 'opt_infiles = "kt2_F2000_B2000"' 1a-nf1v.ncl ; ncl 'opt_infiles = "CTL_F2000_B2000"' 1a-nf1v.ncl ; ncl 'opt_infiles = "F2000_with_CTL_2"' 1a-nf1v.ncl ; ncl 'opt_infiles = "B2000_with_CTL_2"' 1a-nf1v.ncl

  ;opt_infiles = "kt1_F2000_B2000"
  ;opt_infiles = "kt2_F2000_B2000"
  ;opt_infiles = "CTL_F2000_B2000"
  ;opt_infiles = "F2000_with_CTL_2"
  ;opt_infiles = "F2000_kt1_kt2"
  ;opt_infiles = "B2000_with_CTL_1"
  ;opt_infiles = "B2000_with_CTL_2"

  opt_infiles = "B2000_with_CTL_2_yrs"
  ;opt_infiles = "B2000_with_CTL_2_yrs.test01"
    proc_years = ".yr1_5"
    ;proc_years = ".yr6_10"

  plotname_step = "ANN"
  ;plotname_step = "JJA"
  ;plotname_step = "DJF"

  ;#######################
  ;#######################
  if (opt_infiles .eq. "with_CTL_1") then
    infilenames = (/  \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.F_2000_TAI.f09_f09.0410_1659/q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.F_2000_TAI.f09_f09.0410_1659_ANN_climo.nc", \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651_ANN_climo.nc",  \
                 "../diag_archive/climo/q1-taiesm1_modified_Ke_Sc_top_sl.F_2000_TAI.f09_f09.0330_1627/q1-taiesm1_modified_Ke_Sc_top_sl.F_2000_TAI.f09_f09.0330_1627_ANN_climo.nc", \
                  "../diag_archive/climo/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612_ANN_climo.nc" /)
;
    suffixes = infilenames
    suffixes = (/"mod_Ke_cldtop","mod_Ke_pbltop","mod_Ke_WRONG","CTL"/)
    plotname_head = "fig_wCTL-"

  ;#######################
  ;#######################
  elseif (opt_infiles .eq. "with_CTL") then
    infilenames = (/  \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.F_2000_TAI.f09_f09.0410_1659/q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.F_2000_TAI.f09_f09.0410_1659_ANN_climo.nc", \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651_ANN_climo.nc",  \
                  "../diag_archive/climo/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612_ANN_climo.nc" /)
;
    suffixes = infilenames
    suffixes = (/"mod_Ke_cldtop","mod_Ke_pbltop","CTL"/)
    plotname_head = "fig_wCTL-"

  elseif (opt_infiles .eq. "CTL_F2000_B2000") then
    infilenames = (/  \
                  "../diag_archive/climo/f09.B2000.ft13/f09.B2000.ft13_"+plotname_step+"_climo.nc", \
                  "../diag_archive/climo/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612_"+plotname_step+"_climo.nc" /)

    suffixes = infilenames
    suffixes = (/"CTL_coupled","CTL_AGCM"/)
    plotname_head = "fig_ctl_F2000_B2000-"

  ;#######################
  ;#######################
  elseif (opt_infiles .eq. "kt2_F2000_B2000") then
    infilenames = (/  \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.B_2000_TAI.f09_g16.0422_1417/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.B_2000_TAI.f09_g16.0422_1417_"+plotname_step+"_climo.nc", \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651_"+plotname_step+"_climo.nc" /)
;
    suffixes = infilenames
    suffixes = (/"mod_Ke_pbltop_coupled","mod_Ke_pbltop_AGCM"/)
    plotname_head = "fig_kt2_F2000_B2000-"

  ;#######################
  ;#######################
  elseif (opt_infiles .eq. "kt1_F2000_B2000") then
    infilenames = (/  \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.B_2000_TAI.f09_g16.0516_0552/q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.B_2000_TAI.f09_g16.0516_0552_"+plotname_step+"_climo.nc", \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.F_2000_TAI.f09_f09.0514_1345/q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.F_2000_TAI.f09_f09.0514_1345_"+plotname_step+"_climo.nc" /)                
 
    suffixes = infilenames
    suffixes = (/"mod_Ke_cldtop_coupled","mod_Ke_cldtop_AGCM"/)
    plotname_head = "fig_kt1_F2000_B2000-"

  ;#######################
  ;#######################
  elseif (opt_infiles .eq. "F2000_with_CTL_2") then
                 ;"../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651_ANN_climo.nc",  \
                 ; "../diag_archive/climo/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612_ANN_climo.nc" /)
   ;               "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651_"+plotname_step+"_climo.nc" /)
    infilenames = (/  \
                  "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.F_2000_TAI.f09_f09.0514_1345/q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.F_2000_TAI.f09_f09.0514_1345_"+plotname_step+"_climo.nc", \
                  "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651_"+plotname_step+"_climo.nc",  \
                  "../diag_archive/climo/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612_"+plotname_step+"_climo.nc" /)
;
    suffixes = infilenames
    suffixes = (/"mod_Ke_cldtop_AGCM","mod_Ke_pbltop_AGCM","CTL_AGCM"/)
    plotname_head = "fig_wCTL2_F2000-"

  ;#######################
  ;#######################
  elseif (opt_infiles .eq. "F2000_B2000") then  ;*** don't support ngroup ***
                 ;"../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651_ANN_climo.nc",  \
                 ; "../diag_archive/climo/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612_ANN_climo.nc" /)
    infilenames = (/  \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651_"+plotname_step+"_climo.nc",  \
                  "../diag_archive/climo/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612_"+plotname_step+"_climo.nc", \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.B_2000_TAI.f09_g16.0422_1417/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.B_2000_TAI.f09_g16.0422_1417_"+plotname_step+"_climo.nc",  \
                  "../diag_archive/climo/f09.B2000.ft13/f09.B2000.ft13_"+plotname_step+"_climo.nc" /)
;
    suffixes = infilenames
    suffixes = (/"mod_Ke_pbltop_AGCM","CTL_AGCM","mod_Ke_pbltop_coupled","CTL_coupled"/)
    plotname_head = "fig_F2000_B2000-"

    choice_opt = True
    option_group   = True
    option_group@nfile_per_group = 2

  ;#######################
  ;#######################
  elseif (opt_infiles .eq. "B2000_with_CTL_1") then
                 ;"../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651_ANN_climo.nc",  \
                 ; "../diag_archive/climo/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612_ANN_climo.nc" /)
    infilenames = (/  \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.B_2000_TAI.f09_g16.0422_1417/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.B_2000_TAI.f09_g16.0422_1417_"+plotname_step+"_climo.nc",  \
                  "../diag_archive/climo/f09.B2000.ft13/f09.B2000.ft13_"+plotname_step+"_climo.nc" /)
;
    suffixes = infilenames
    suffixes = (/"mod_Ke_pbltop_coupled","CTL_coupled"/)
    plotname_head = "fig_wCTL1_B2000-"

  ;#######################
  ;#######################
  elseif (opt_infiles .eq. "B2000_with_CTL_2") then
                 ;"../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651_ANN_climo.nc",  \
                 ; "../diag_archive/climo/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612_ANN_climo.nc" /)
    infilenames = (/  \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.B_2000_TAI.f09_g16.0516_0552/q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.B_2000_TAI.f09_g16.0516_0552_"+plotname_step+"_climo.nc", \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.B_2000_TAI.f09_g16.0422_1417/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.B_2000_TAI.f09_g16.0422_1417_"+plotname_step+"_climo.nc",  \
                  "../diag_archive/climo/f09.B2000.ft13/f09.B2000.ft13_"+plotname_step+"_climo.nc" /)
;
    suffixes = infilenames
    suffixes = (/"mod_Ke_cldtop_coupled", "mod_Ke_pbltop_coupled","CTL_coupled"/)
    plotname_head = "fig_wCTL2_B2000-"

  elseif (opt_infiles .eq. "wo_CTL") then
    infilenames = (/  \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.F_2000_TAI.f09_f09.0410_1659/q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.F_2000_TAI.f09_f09.0410_1659_ANN_climo.nc", \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651_ANN_climo.nc" /)
;
    suffixes = infilenames
    suffixes = (/"mod_Ke_cldtop","mod_Ke_pbltop"/)
    plotname_head = "fig_woCTL-"

  ;#######################
  ;#######################
  elseif (opt_infiles .eq. "B2000_with_CTL_2_yrs") then
                 ;"../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651_ANN_climo.nc",  \
                 ; "../diag_archive/climo/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612_ANN_climo.nc" /)
    infilenames = (/  \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.B_2000_TAI.f09_g16.0516_0552"+proc_years+"/q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.B_2000_TAI.f09_g16.0516_0552_"+plotname_step+"_climo.nc", \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt3_cldtop_ocn.B_2000_TAI.f09_g16.0604_1108"+proc_years+"/q2-taiesm1_modified_Ke_Sc_top_sl_kt3_cldtop_ocn.B_2000_TAI.f09_g16.0604_1108_"+plotname_step+"_climo.nc",  \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.B_2000_TAI.f09_g16.0422_1417"+proc_years+"/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.B_2000_TAI.f09_g16.0422_1417_"+plotname_step+"_climo.nc",  \
                 "../diag_archive/climo/f09.B2000.ft13"+proc_years+"/f09.B2000.ft13_"+plotname_step+"_climo.nc" /)
;
    suffixes = infilenames
    suffixes = (/"mod_Ke_cldtop_coupled"+proc_years, "mod_Ke_cldtop_ocn_coupled"+proc_years, "mod_Ke_pbltop_coupled"+proc_years, "CTL_coupled"+proc_years/)
    plotname_head = "fig_wCTL2_B2000"+proc_years+"-"

  ;#######################
  ;#######################
  elseif (opt_infiles .eq. "B2000_with_CTL_2_yrs.test01") then
                 ;"../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651_ANN_climo.nc",  \
                 ; "../diag_archive/climo/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612/q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612_ANN_climo.nc" /)
    infilenames = (/  \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.B_2000_TAI.f09_g16.0516_0552"+proc_years+"/q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.B_2000_TAI.f09_g16.0516_0552_"+plotname_step+"_climo.nc", \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt3_cldtop_ocn.B_2000_TAI.f09_g16.0604_1108"+proc_years+"/q2-taiesm1_modified_Ke_Sc_top_sl_kt3_cldtop_ocn.B_2000_TAI.f09_g16.0604_1108_"+plotname_step+"_climo.nc",  \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.B_2000_TAI.f09_g16.0422_1417"+proc_years+"/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.B_2000_TAI.f09_g16.0422_1417_"+plotname_step+"_climo.nc" /)
                 ;"../diag_archive/climo/f09.B2000.ft13"+proc_years+"/f09.B2000.ft13_"+plotname_step+"_climo.nc" /)
;
    suffixes = infilenames
    suffixes = (/"mod_Ke_cldtop_coupled"+proc_years, "mod_Ke_cldtop_ocn_coupled"+proc_years, "mod_Ke_pbltop_coupled"+proc_years/)
    plotname_head = "fig_wCTL2_B2000"+proc_years+"-"

  ;#######################
  ;#######################
  elseif (opt_infiles .eq. "wo_CTL_2") then
    infilenames = (/  \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651_"+plotname_step+"_climo.nc" /)
;
    suffixes = infilenames
    suffixes = (/"mod_Ke_pbltop"/)
    plotname_head = "fig_woCTL-"

  ;#######################
  ;#######################
  elseif (opt_infiles .eq. "B2000_wo_CTL_2") then
    infilenames = (/  \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.B_2000_TAI.f09_g16.0422_1417/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.B_2000_TAI.f09_g16.0422_1417_"+plotname_step+"_climo.nc" /)
;
    suffixes = infilenames
    suffixes = (/"mod_Ke_pbltop_B2000"/)
    plotname_head = "fig_woCTL_B2000-"

  ;#######################
  ;#######################
  elseif (opt_infiles .eq. "wo_CTL_1") then
    infilenames = (/  \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.F_2000_TAI.f09_f09.0410_1659/q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.F_2000_TAI.f09_f09.0410_1659_ANN_climo.nc", \
                 "../diag_archive/climo/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651/q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651_ANN_climo.nc",  \
                 "../diag_archive/climo/q1-taiesm1_modified_Ke_Sc_top_sl.F_2000_TAI.f09_f09.0330_1627/q1-taiesm1_modified_Ke_Sc_top_sl.F_2000_TAI.f09_f09.0330_1627_ANN_climo.nc" /)
;
    suffixes = infilenames
    suffixes = (/"mod_Ke_cldtop","mod_Ke_pbltop","mod_Ke_WRONG"/)
    plotname_head = "fig_woCTL-"

  end if

  plotname_steps = infilenames
  plotname_steps = stepname
  ;plotname_steps = (/"ANN","ANN","DJF","DJF","JJA","JJA"/)

  ;******************
  ; set variables
  ;******************
  varvars = (/"PBLH","TS", "TREFHT", "QREFHT", \
              "PRECC","PRECL", "TMQ", \
              "CLDLOW","CLDTOT", "TGCLDLWP", \
              "PS", "PSL", \
              "SHFLX","LHFLX", "FLNS", "FSNS", "FLDS", "FSDS", \
              "FSNTOA", "FSNTOAC", "FLUT", "FLUTC", "SWCF", "LWCF"/)

  delete(varvars)
  ;varvars = (/"PS","PSL"/)
  ;varvars = (/"freq_ke_factor"/)
  ;varvars = (/"freq_ke_factor","ke_factor", "z_cldtop_PBL","kvh_kt_orig"/)
  ;varvars = (/"CLDLOW", "TGCLDLWP", "SWCF"/)
  ;varvars = (/"PRECC","PRECL", "TMQ"/)
  ;varvars = (/"TS"/)
  varvars = (/"TS","CLDLOW", "TGCLDLWP", "SWCF"/)


  ;varvars = (/"SHFLX","LHFLX"/)
  ;var11vars = (/"FLDS","FLDSC","FLUS","FSDS","FSDSC","FSNS","FSNSC","FSUS", \
  ;              "FLUT","FLUTC","FSNTOA","FSNTOAC","SHFLX","LHFLX","TS","TREFHT","ICEFRAC","RADSURF", \
  ;              "CLDLOW","CLDMED","CLDHGH","CLDTOT", "LWCF","SWCF","LWCF_SURF","SWCF_SURF", \
  ;              "PRECT","PRECC","PRECL","EVAP","P_minus_E","TMQ","LWCOOL_TOA_TO_SURF","SWWARM_TOA_TO_SURF","RADCOOL_TOA_TO_SURF"/)

;  ;*************************************
;  ; set from zz-read_parameters.ncl
;  ;*************************************
;  choice_var = "var_tji"
;  choice_files = "climo_all_seasons"
;  if (choice_files .ne. "") then
;    ss1 = ""
;    ss2 = True
;    choice_opt  = True
;    read_parameters(ss1, ss2, choice_files, choice_var, choice_opt)
;  end if
;  ;print(choice_opt)
;
;  plotname_head  = choice_opt@plotname_head
;  txString_ALL   = choice_opt@txString_ALL
;  option_group   = choice_opt@option_group
;    option_group@nfile_per_group = choice_opt@nfile_per_group
;  infilenames    = choice_opt@infilenames
;  suffixes       = choice_opt@suffixes
;  plotname_steps = choice_opt@plotname_steps
;  varvars        = choice_opt@varvars
;  mapview        = choice_opt@mapview

;-----------------

; other settings
;-----------------
  nfile = dimsizes(infilenames)
  nvar = dimsizes(varvars)
  filename_base = infilenames(nfile-1)
  suffix_base   = suffixes(nfile-1)
  plotname_step_base = stepname

  tt1 = 0      ; process time step from tt1 to tt2. If tt2 exceeds the max steps, the max steps will use instead.
  ;tt2 = 5
  tt2 = 9999

  option_plot = True
  option_plot@choice1 = "fig_1var_nfiles-name_nvars_nsteps"		; At each figure, plot a varaible from different files
  ;option_plot@choice2 = "fig_nvars_1file-name_nfiles_nsteps"		; At each figure, plot many variables in a file
  ;option_plot@choice3 = "fig-1var_ntimes-name_nvars_nfiles"		; At each figure, plot a variable at many time steps in a file
  ;option_plot@choice4 = "fig_1var_nfiles_sameLB-name_nvars_nsteps"	; At each figure, plot a variable and diff from different files and use the same labelbar for all time steps.
									; This can be used to make animation or a movie.
  ;option_plot@choice5 = "fig_1var_2files_siglvl-name_nvars"            ; At each figure, plot a variable from the base file and diff between another file with significane level
  ;option_plot@choice6 = "fig_nvars_tavg_siglvl-nfiles"			; At each figure, plot many variables in a file and diff with respec to the base file
  ;option_plot@choice7 = "fig_nvars_tavg_siglvl-nfiles_group"            ; Same as choice6, but for user-defined group of files, e.g. 6 files with nfile_per_group=2, will plot file 1-2, file 3-4, file 5-6
  ;option_plot@choice8 = "fig_1var_tavg_siglvl-nfiles_group"            ; 

  option_sameLB = True		; use same colorbar for values and differences. For choice1, 3, and 4.
  ;option_sameLB = False		; use same colorbar for values and differences. For choice1, 3, and 4.
    ;opt_sameLB@factor = 0.9
    ;opt_sameLB@max_levels = 20
    ;opt_sameLB@filename_base = filename_base

  opt_2Ddata = True                                                     ; use ignorant_convert_2Ddata to read variables
  ;opt_2Ddata@return_type = "tlji2tji_intp"       ; input: CESM var(time,lev/ilev,lat,lon). return var(time,lat,lon) at the given pressure level
  ;  opt_2Ddata@plev        = 300.                ; interpolate the var at this pressure level (hPa)
  ;  opt_2Ddata@time_step   = 0                   ; set the time step

  opt_cncolors = True  ; a logical varialbe to control availabe features in this procedure
  ;opt_cncolors@max_levels = 15  ; level for using function nice_mnmxintvl
  ;opt_cncolors@cnlevels_predefine = False    ; True  - contour levels are given in res
  ;                                           ; False - contour levels will be computed in this procedure
  ;opt_cncolors@colormap_positive = "WhiteYellowOrangeRed"  ; colormap for plotting positive colors
  ;opt_cncolors@colormap_positive_index_start = 2           ; the least positive color
  ;opt_cncolors@colormap_positive_index_end = 999           ; the most  positive color
  ;    
  ;opt_cncolors@colormap_negative = "MPL_GnBu"              ; colormap for plotting negative colors
  ;opt_cncolors@colormap_negative_index_start = 127         ; the most  negative color
  ;opt_cncolors@colormap_negative_index_end = 2             ; the least negative color

  opt_file = True

  opt_cnmap = True
  ;opt_cnmap@LatWeighted = True (default)    ; do average considering latitude transformation effects
  ;                                            ; if turn on, data_input coordinate variable's MUST in correct format
  ;opt_cnmap@MeanFormat = "%7.3f" (default)  ; set mean value format
  ;opt_cnmap@MeanPrefix = "mean: " (default) ; set prefix of mean value
   opt_cnmap@mapview    = mapview
  ;opt_cnmap@mapview    = "polar_SH"

  opt_change = True
  opt_change@chg_cncolors = True ; turn on changing contour colors

  ;*** choice 5: set t-test significance level ***
  siglvl = 0.05                      ; significance level 
  siglev = 100.*(1.-siglvl)
  iflag= False

  ; define step names. note that the dimension must be the same at plotting time steps
  ;stepnames = (/"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"/)

;---------
; check
;---------
  if (option_sameLB) then
    opt_cncolors@cnlevels_predefine = True
    opt_cnmap@cnlevels_predefine = True
  end if

;----------------
; set resources
;----------------

  res  = True
  res@gsnFrame = False
  res@gsnDraw = False
  ;res@gsnAddCyclic = False

  res@cnFillOn = True
  res@cnLinesOn = False
  res@cnLineLabelsOn = False

  res@mpCenterLonF = 180.

  if (isatt(opt_cnmap, "mapview") .and. opt_cnmap@mapview .eq. "polar_NH") then
    res@mpMinLatF = 66.5
  end if 

  if (isatt(opt_cnmap, "mapview") .and. opt_cnmap@mapview .eq. "polar_SH") then
    res@mpMinLatF = -66.5
  end if 

  ;res@gsnCenterString = ""

  resp = True    ; panel res
  resp@gsnMaximize = True
  resp@txString = txString_ALL

  ;*** "fig_nvars_1file-name_nfiles_nsteps" changable parts ***
  ;*** "fig-1var_ntimes-name_nvars_nfiles"  changable parts *** 
  res_vars = res
  res_vars@cnFillPalette = "WhiteBlueGreenYellowRed"

  res_diff_vars = res

  ;*** res for plotting t-test results ***
  res_sig = res
  res_sig@cnLevelSelectionMode = "ExplicitLevels"
  res_sig@cnLevels = (/siglev/)
  res_sig@cnLinesOn = False

  res_sig@cnLineThicknessF = 3.

  res_sig@cnMonoFillColor = False
  res_sig@cnFillColors = (/-1,1/)

  res_sig@cnMonoFillPattern = False
  res_sig@cnFillPatterns = (/0,4/)   ; slash
  ;res_sig_work@cnFillPatterns = (/0,17/)  ; dotted

  res_sig@cnInfoLabelOn = False

;-------------------------------
; check the dimension of files
;-------------------------------

  ftemp1_base = addfile(infilenames(nfile-1),"r")
  fdims_base = getfiledimsizes(ftemp1_base)
  fdims_name_base = getvardims(ftemp1_base)
  ndim_base  = dimsizes(fdims_base)

  do ff=0,nfile-2
    ftemp1_any = addfile(infilenames(ff),"r")
    fdims_any = getfiledimsizes(ftemp1_any)
    fdims_name_any = getvardims(ftemp1_any)
    ndim_any = dimsizes(fdims_any)

    if (ndim_base .ne. ndim_any) then
      print("ERROR: input files have different number of dimensions")
      ;print(" "+infilenames(nfile-1))
      ;print(" "+fdims_base)
      ;print(infilenames(ff))
      ;print(" "+fdims_any)
      print("program stop")
      exit()
    
    else
      if (.not.all(fdims_base .eq. fdims_any)) then
        print("")
        print("ERROR: input files have different dimensions")
        print("")
        print(" file: ["+infilenames(nfile-1)+"]")
        print("   "+fdims_name_base+": "+fdims_base)
        print("")
        print(" file: ["+infilenames(ff)+"]")
        print("   "+fdims_name_any+": "+fdims_any)
        print("")
        print("program stop")
        exit()
      end if
    end if
    
    delete(ftemp1_any)
    delete(fdims_any)
  end do

;------------------------------------------
; check input time steps & set time steps
;------------------------------------------
  ftemp1 = addfile(filename_base,"r")
  fdims = getfiledimsizes(ftemp1)
  fdims_name = getvardims(ftemp1)
  nfdim = dimsizes(fdims)

  do i=0,nfdim-1
    if (fdims_name(i) .eq. "time") then
      timemax = fdims(i)-1
    end if
  end do

  if ( tt1 .gt. timemax .or. tt1 .lt. 0 ) then
    tt1 = 0
    tt2 = timemax
    print("WARNING: given time step is out of range, set to 0 to MAX steps")
  else if ( tt2 .gt. timemax ) then
    tt2 = timemax
    print("WARNING: given time step is out of range, set to 0 to MAX steps")
  end if
  end if

  ntime = tt2-tt1+1

  ;*** set stepname ***
  stepname_work = new(timemax+1,"string")
  if ( isdefined("stepnames") .and. dimsizes(stepnames).eq.ntime ) then
    stepname_work(:) = stepnames(:)
  else
    do tt=tt1,tt2
      if (isatt(option_plot,"choice4")) then
        ss1 = sprinti("%4.4i",tt+1)
      else
        ss1 = sprinti("%2.2i",tt+1)
      end if
      stepname_work(tt) = stepname+ss1
    end do
  end if
  ;print(stepname_work)

  delete(ftemp1)

;----------
; set date 
;---------- 
  filetemp_base = addfile(filename_base, "r")

  if (isfilevar(filetemp_base,"date") .and. isfilevar(filetemp_base,"datesec")) then
    date_base = filetemp_base->date
    hour_base = filetemp_base->datesec
    hour_base = divide(hour_base,3600)
    ;print(date_base+" , "+hour_base)
    time_string = sprinti ("%0.6i",date_base)+"_"+sprinti ("%0.2i",hour_base)+"h"
  else
    time_string = ""
  end if

  delete(filetemp_base)

;----------------
; set base file
;-----------------
  if (option_group) then
    if (isatt(option_group,"nfile_per_group") .and. isint(option_group@nfile_per_group)) then
      nfile_per_group = option_group@nfile_per_group
    else
      print("ERROR: option_group@nfile_per_group is either not set or is not an integer")
      print("Program stop")
      exit()
    end if

   ; make sure the number of group is an integer
    if ( nfile_per_group.eq.nfile .or. mod(nfile,nfile_per_group).ne.0 ) then
      print("ERROR: nfile is ["+nfile+"] and nfile_per_group is ["+nfile_per_group+"], # of group MUST be an interger and not equal to nfile")
      print("Program stop")
      exit()
    end if

    ;*** set infilenames_base ***
    infilenames_base = infilenames
    infilenames_group = infilenames(nfile_per_group-1::nfile_per_group)
    ngroup = dimsizes(infilenames_group)
    gg = 0
    do i=0,nfile-1,nfile_per_group
      infilenames_base(i:i+nfile_per_group-1) = infilenames_group(gg)
      gg=gg+1
    end do
    ;print(infilenames+" , "+infilenames_base)

    ;*** set suffixes_base ***
    suffixes_base = suffixes
    suffixes_group = suffixes(nfile_per_group-1::nfile_per_group)
    ngroup = dimsizes(suffixes_group)
    gg = 0
    do i=0,nfile-1,nfile_per_group
      suffixes_base(i:i+nfile_per_group-1) = suffixes_group(gg)
      gg=gg+1
    end do
    ;print(suffixes+" , "+suffixes_base)

    ;*** set plotname_steps_base ***
    plotname_steps_base = plotname_steps
    plotname_steps_group = plotname_steps(nfile_per_group-1::nfile_per_group)
    ngroup = dimsizes(plotname_steps_group)
    gg = 0
    do i=0,nfile-1,nfile_per_group
      plotname_steps_base(i:i+nfile_per_group-1) = plotname_steps_group(gg)
      gg=gg+1
    end do
    ;print(plotname_steps+" , "+plotname_steps_base)

  else  ; option_group = False
    infilenames_base = infilenames
    infilenames_base = filename_base

    suffixes_base = suffixes 
    suffixes_base = suffix_base

    plotname_steps_base = plotname_steps
    plotname_steps_base = plotname_step_base

    nfile_per_group = nfile
  end if ; end if of option_group

  ;print(infilenames+" , "+infilenames_base)
  ;print(suffixes+" , "+suffixes_base)
  ;print(infilenames_base+" , "+infilenames)

;--------------------------------------------------------------
; option_plot, choice1,  "fig_1var_nfiles-name_nvars"
;-------------------------------------------------------------

if ( isatt(option_plot,"choice1") .and. option_plot@choice1 .eq. "fig_1var_nfiles-name_nvars_nsteps" ) then

  print("")
  print("--------------------------------------------------------------------------")
  print("choice 1: plot every variable of multiple files and diff at each time step")
  print("--------------------------------------------------------------------------")

  ;----------------------
  ; set number of plots
  ;----------------------
  nplot = nfile_per_group
  ;print(nplot)

  ; compute panel row# and column# 
  row1 = toint(sqrt(nplot))
  pp1 = sqrt(nplot)-tofloat(row1)
  if (pp1 .gt. 0.5) then
    row1 = row1+1
  end if
  column1 = row1+1

  do i=2,5
    if (sqrt(nplot).eq.tofloat(i)) then
      row1 = i
      column1 = row1
    end if
  end do

  plot_varvar_baseAdiff = new( nplot, "graphic" )
  plot_varvar_allAvalue = new( nplot, "graphic" )
  plot_varvar_allAdiff  = new( nplot, "graphic" )

  ;-------
  ; plot
  ;-------
  ; loop for time steps
  do tt=tt1,tt2
    ;stepname1 = stepname_work(tt)
    stepname1 = plotname_step
  
    opt_2Ddata@time_step = tt
  
    ; loop for variables
    do vv=0,nvar-1
  
      varvar = varvars(vv)
      print("")
      print("process ["+varvar+", "+stepname1+"] ...")
      
      opt_cncolors1 = opt_cncolors

      delete(res_vars)
      delete(res_diff_vars)

      res_vars = res
      res_vars@cnFillPalette = "WhiteBlueGreenYellowRed"

      res_diff_vars = res

      if (varvar .eq. "freq_ke_factor") then
        ;res_vars@cnLevelSelectionMode = "ManualLevels"
        ;res_vars@cnMinLevelValF = 0.05
        ;res_vars@cnMaxLevelValF = 0.75
        ;res_vars@cnLevelSpacingF = 0.05

        res_vars@cnLevelSelectionMode = "ExplicitLevels"
        res_vars@cnLevels = (/1e-3, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75/)

      elseif (varvar .eq. "ke_factor") then
        res_vars@cnLevelSelectionMode = "ManualLevels"
        res_vars@cnMinLevelValF = 0.55
        res_vars@cnMaxLevelValF = 0.95
        res_vars@cnLevelSpacingF = 0.05
      
      elseif (varvar .eq. "PBLH") then
        res_diff_vars@cnLevelSelectionMode = "ManualLevels"
        res_diff_vars@cnMinLevelValF = -50
        res_diff_vars@cnMaxLevelValF = 50
        res_diff_vars@cnLevelSpacingF = 10

      elseif (varvar .eq. "CLDLOW" .or. varvar .eq. "CLDTOT") then
        res_diff_vars@cnLevelSelectionMode = "ManualLevels"
        res_diff_vars@cnMinLevelValF = -10
        res_diff_vars@cnMaxLevelValF = 10
        res_diff_vars@cnLevelSpacingF = 2

      elseif (varvar .eq. "TGCLDLWP") then
        res_diff_vars@cnLevelSelectionMode = "ManualLevels"
        res_diff_vars@cnMinLevelValF = -20
        res_diff_vars@cnMaxLevelValF = 20
        res_diff_vars@cnLevelSpacingF = 4

      elseif (varvar .eq. "FSDS" .or. varvar .eq. "FLDS") then
        res_diff_vars@cnLevelSelectionMode = "ManualLevels"
        res_diff_vars@cnMinLevelValF = -15
        res_diff_vars@cnMaxLevelValF = 15
        res_diff_vars@cnLevelSpacingF = 3

      elseif (varvar .eq. "FSNTOA") then
        res_diff_vars@cnLevelSelectionMode = "ManualLevels"
        res_diff_vars@cnMinLevelValF = -15
        res_diff_vars@cnMaxLevelValF = 15
        res_diff_vars@cnLevelSpacingF = 3

      elseif (varvar .eq. "SWCF") then
        res_diff_vars@cnLevelSelectionMode = "ManualLevels"
        res_diff_vars@cnMinLevelValF = -15
        res_diff_vars@cnMaxLevelValF = 15
        res_diff_vars@cnLevelSpacingF = 3

      elseif (varvar .eq. "QREFHT") then
        res_diff_vars@cnLevelSelectionMode = "ManualLevels"
        res_diff_vars@cnMinLevelValF = -2
        res_diff_vars@cnMaxLevelValF = 2
        res_diff_vars@cnLevelSpacingF = 0.2

      elseif (varvar .eq. "PRECC" .or. varvar.eq."PRECL" ) then
        res_diff_vars@cnLevelSelectionMode = "ManualLevels"
        res_diff_vars@cnMinLevelValF = -2
        res_diff_vars@cnMaxLevelValF = 2
        res_diff_vars@cnLevelSpacingF = 0.2

      elseif (varvar .eq. "TMQ") then
        res_diff_vars@cnLevelSelectionMode = "ManualLevels"
        res_diff_vars@cnMinLevelValF = -4
        res_diff_vars@cnMaxLevelValF = 4
        res_diff_vars@cnLevelSpacingF = 0.4

      ;elseif (varvar .eq. "SHFLX") then
      ;  res_diff_vars@cnLevelSelectionMode = "ManualLevels"
      ;  res_diff_vars@cnMinLevelValF = -14
      ;  res_diff_vars@cnMaxLevelValF = 14
      ;  res_diff_vars@cnLevelSpacingF = 2

      elseif (varvar .eq. "LHFLX" .or. varvar .eq. "SHFLX" .or. varvar .eq. "FLNS" .or. varvar .eq. "FSNS") then
        res_diff_vars@cnLevelSelectionMode = "ManualLevels"
        res_diff_vars@cnMinLevelValF = -16
        res_diff_vars@cnMaxLevelValF = 16
        res_diff_vars@cnLevelSpacingF = 2

      elseif (varvar .eq. "TS" .or. varvar.eq."TREFHT") then
        res_diff_vars@cnLevelSelectionMode = "ExplicitLevels"
        ;res_diff_vars@cnLevels = (/-5., -4. ,-3., -2., -1., -0.5, 0., 0.5, 1., 2., 3., 4., 5./)
        res_diff_vars@cnLevels = (/-4. ,-3., -2., -1., -0.5, -0.2, 0., 0.2, 0.5, 1., 2., 3., 4./)

      end if
  
      ; loop for file_base
      do ff1=0,nfile-1,nfile_per_group
        infilename_base = infilenames_base(ff1)
        suffix_base     = suffixes_base(ff1)
    
        ;*** set res for diff vars ***
        res_vars1 = res_vars             ; plot res
        res_diff_vars1 = res_diff_vars   ; plot res
        res_temp = True
    
        wks_name_baseAdiff = plotname_head+varvar+"-"+stepname1+"-"+suffix_base+"_allM"+suffix_base
        wks_baseAdiff = gsn_open_wks(wks_type, wks_name_baseAdiff)
    
        wks_name_allAvalue = plotname_head+varvar+"-"+stepname1+"-"+suffix_base+"-all_values"
        wks_allAvalue = gsn_open_wks(wks_type, wks_name_allAvalue)
    
        wks_name_allAdiff = plotname_head+varvar+"-"+stepname1+"-allM"+suffix_base
        wks_allAdiff = gsn_open_wks(wks_type, wks_name_allAdiff)
    
        ;******************************
        ; plot variables of base file
        ;******************************
        varvar_base = ignorant_convert_2Ddata(infilename_base,varvar,opt_2Ddata)
        ;varvar_base = filetemp_any->$varvar$(tt,:,:)
    
        change_var_atts(varvar, varvar_base, res_vars1, opt_change)
        change_var_atts(varvar, varvar_base, res_diff_vars1, opt_change)
    
        ; plot
        res_vars1@tiMainString = suffix_base
    
        plot_varvar_baseAdiff(0) = gsn_csm_contour_map_avg(wks_baseAdiff, varvar_base, res_vars1, opt_cnmap)
        plot_varvar_allAvalue(0) = gsn_csm_contour_map_avg(wks_allAvalue, varvar_base, res_vars1, opt_cnmap)
    
        res_diff_vars1@tiMainString = suffix_base+" - "+suffix_base
        plot_varvar_allAdiff(0) = gsn_csm_contour_map_avg(wks_allAdiff, diff(varvar_base,varvar_base), res_diff_vars1, opt_cnmap)
  
        ;******************************
        ; plot variables of any file
        ;******************************
        ff=1
        do ff2=ff1,ff1+nfile_per_group-2
          res_vars2 = res_vars             ; plot res
          res_diff_vars2 = res_diff_vars   ; plot res
    
          filename_any = infilenames(ff2)
          suffix_any   = suffixes(ff2)
    
          ; read variables and rearrange
          varvar_any = ignorant_convert_2Ddata(filename_any,varvar,opt_2Ddata)
          ;varvar_any = filetemp_any->$varvar$(tt,:,:)
    
          change_var_atts(varvar, varvar_any, res_vars2, opt_change)
          change_var_atts(varvar, varvar_any, res_diff_vars2, opt_change)
    
          ; plot 
          varvar_anyMbase = diff(varvar_any,varvar_base)
          res_vars2@tiMainString = suffix_any
          res_diff_vars2@tiMainString = suffix_any+" - "+suffix_base
    
          opt_cncolors2 = opt_cncolors1
          cnColors_PosNeg(varvar_anyMbase, res_diff_vars2, opt_cncolors2)

          plot_varvar_baseAdiff(ff) = gsn_csm_contour_map_avg(wks_baseAdiff, varvar_anyMbase, res_diff_vars2, opt_cnmap)
    
          plot_varvar_allAdiff(ff) = gsn_csm_contour_map_avg(wks_allAdiff, varvar_anyMbase, res_diff_vars2, opt_cnmap)
    
          res_vars1@tiMainString = suffix_any
          plot_varvar_allAvalue(ff) = gsn_csm_contour_map_avg(wks_allAvalue, varvar_any, res_vars2, opt_cnmap)
    
          ff=ff+1
          delete(varvar_any)
          delete(varvar_anyMbase)
          delete(res_vars2)
          delete(res_diff_vars2)
          delete(opt_cncolors2)
        end do ; end do of file_any
  
      delete(varvar_base)
  
      ; panel
      resp@txString =  varvar+" - "+stepname1
      resp@gsnPanelRowSpec = True
      gsn_panel(wks_baseAdiff, plot_varvar_baseAdiff, (/1,row1,nplot-row1/), resp)
      print("Done. Create ["+wks_name_baseAdiff+"]")
  
      resp@txString =  varvar+" - "+stepname1
      resp@gsnPanelRowSpec = False
      gsn_panel(wks_allAdiff, plot_varvar_allAdiff, (/row1,column1/), resp)
      print("Done. Create ["+wks_name_allAdiff+"]")
  
      resp@txString =  varvar+" - "+stepname1
      resp@gsnPanelRowSpec = False
      gsn_panel(wks_allAvalue, plot_varvar_allAvalue, (/row1,column1/), resp)
      print("Done. Create ["+wks_name_allAvalue+"]")
  
    end do ; end do of file_base
  
      delete(res_vars1)
      delete(res_diff_vars1)
      delete(opt_cncolors1)
    end do ; end do of var
  end do ; end do of time
end if ; end if of choice1: option_plot = "fig_1var_nfiles-name_nvars_nsteps"

;------------------------------------------------------------
; option_plot, choice2, "fig_nvars_1file-name_nfiles_nsteps"
;------------------------------------------------------------

if ( isatt(option_plot,"choice2") .and. option_plot@choice2 .eq. "fig_nvars_1file-name_nfiles_nsteps" ) then

  print("")
  print("---------------------------------------------------------")
  print("choice 2: plot all variable of iindividual file and diff")
  print("---------------------------------------------------------")

  nplot = nvar
 
  ; set graphic variable
  plot_varvar_any = new (nplot,"graphic")
  plot_varvar_anyMbase = new (nplot,"graphic")

  ; compute panel row# and column# 
  row1 = toint(sqrt(nplot))
  pp1 = sqrt(nplot)-tofloat(row1)
  if (pp1 .gt. 0.5) then
    row1 = row1+1
  end if
  column1 = row1+1

  do i=2,5
    if (sqrt(nplot).eq.tofloat(i)) then
      row1 = i
      column1 = row1
    end if
  end do

  ; loop for time steps
  do tt=tt1,tt2
    ;stepname1 = stepname_work(tt)
    stepname1 = time_string(tt)  ; use yymmdd_hh"h", e.g. 090101_03h
    opt_2Ddata@time_step = tt

    ; loop for every file
    do ff1=0,nfile-1
      filename_base = infilenames_base(ff1)
      suffix_base     = suffixes_base(ff1)

      filename_any = infilenames(ff1)
      suffix_any   = suffixes(ff1)
      ;print("b, "+filename_any+" , "+filename_base)
      ;print("b, "+suffix_any+" , "+suffix_base)

      ; set wks
      wks_name_any      = plotname_head+"all_vars-"+suffix_any+"-"+stepname1
      wks_name_anyMbase = plotname_head+"all_vars-"+suffix_any+"M"+suffix_base+"-"+stepname1

      wks_any      = gsn_open_wks(wks_type, wks_name_any)
      wks_anyMbase = gsn_open_wks(wks_type, wks_name_anyMbase)

      ; loop for every var
      do vv=0,nvar-1 
        varvar = varvars(vv)
        print("  process variable ["+varvar+"] ...")
  
        ;*** set res for diff vars ***
        res_vars1 = res_vars             ; plot res
        res_diff_vars1 = res_diff_vars   ; plot res
        opt_cncolors1 = opt_cncolors
        opt_change1 = opt_change

        ;if (varvar .eq. "") then
        ;  res_diff_vars1@cnLevelSelectionMode = "ManualLevels"
        ;  res_diff_vars1@cnMinLevelValF = 
        ;  res_diff_vars1@cnMaxLevelValF = 
        ;  res_diff_vars1@cnLevelSpacingF = 
        ;  opt_cncolors1@cnlevels_predefine = True
        ;end if

        ;if (varvar .eq. "") then
        ;  res_vars1@cnLevelSelectionMode = "ManualLevels"
        ;  res_vars1@cnMinLevelValF = 
        ;  res_vars1@cnMaxLevelValF =
        ;  res_vars1@cnLevelSpacingF = 
      
        ;  res_diff_vars1@cnLevelSelectionMode = "ManualLevels"
        ;  res_diff_vars1@cnMinLevelValF = 
        ;  res_diff_vars1@cnMaxLevelValF = 
        ;  res_diff_vars1@cnLevelSpacingF = 
        ;  opt_cncolors1@cnlevels_predefine = True
        ;end if

        copy_VarAtts(opt_cncolors1, opt_change1)
  
        ; read variable and rearrange
        varvar_base = ignorant_convert_2Ddata(filename_base,varvar,opt_2Ddata)
        varvar_any  = ignorant_convert_2Ddata(filename_any,varvar,opt_2Ddata)
   
        change_var_atts(varvar, varvar_base, res_vars1, opt_change1)
        change_var_atts(varvar, varvar_base, res_diff_vars1, opt_change1)
  
        change_var_atts(varvar, varvar_any, res_vars1, opt_change1)
        change_var_atts(varvar, varvar_any, res_diff_vars1, opt_change1)
  
        varvar_anyMbase = diff(varvar_any,varvar_base)
  
        ; plot
        res_vars1@tiMainString = varvar
        plot_varvar_any(vv) = gsn_csm_contour_map_avg(wks_any, varvar_any(:,:), res_vars1, opt_cnmap)
   
        res_diff_vars1@tiMainString = varvar

        cnColors_PosNeg(varvar_anyMbase, res_diff_vars1, opt_cncolors1)
        plot_varvar_anyMbase(vv) = gsn_csm_contour_map_avg(wks_anyMbase, varvar_anyMbase(:,:), res_diff_vars1, opt_cnmap)
  
        delete(varvar_any)
        delete(varvar_base)
        delete(varvar_anyMbase)
  
        delete(res_vars1)
        delete(res_diff_vars1)
        delete(opt_cncolors1)
        delete(opt_change1)
      end do ; end do of vars
  
      ; panel
      resp@txString =  suffix_any+" - "+stepname1
      gsn_panel(wks_any, plot_varvar_any, (/row1,column1/), resp)
      print("Done. Create ["+wks_name_any+"]")
  
      resp@txString =  suffix_any+" MINUS "+suffix_base+" - "+stepname1
      gsn_panel(wks_anyMbase, plot_varvar_anyMbase, (/row1,column1/), resp)
      print("Done. Create ["+wks_name_anyMbase+"]")

    end do ; end do of file_base
  end do ; end do of time steps

end if ; end if of choice2: option_plot = "fig_nvars_1file-name_nfiles"

;--------------------------------------------------------------
; option_plot, choice 3, "fig-1var_ntimes-name_nvars_nfiles"
;--------------------------------------------------------------

if ( isatt(option_plot,"choice3") .and. option_plot@choice3 .eq. "fig-1var_ntimes-name_nvars_nfiles" ) then

  print("")
  print("----------------------------------------------------------------------")
  print("choice 3: plot all time steps of each variable in every file and diff")
  print("----------------------------------------------------------------------")

  ; set plot variables
  ntime = tt2-tt1+1
  plot_varvar_any = new (ntime,"graphic")
  plot_varvar_anyMbase = new (ntime,"graphic")

 ; compute panel row# and column#
  row1 = toint(sqrt(ntime))
  pp1 = sqrt(ntime)-tofloat(row1)
  if (pp1 .gt. 0.5) then
    row1 = row1+1
  end if
  column1 = row1+1

; loop for files
do ff=0,nfile-1
 
  ; set process file
  filename_any = infilenames(ff)
  filetemp_any = addfile(filename_any,"r")
  print("")
  print("process ["+filename_any+"] ...")

  suffix_any  = suffixes(ff)
  suffix_anyMbase = suffix_any+"M"+suffix_base
 
  ; loop for variables
  do vv=0,nvar-1

    varvar = varvars(vv)
    print("")
    print("  process ["+varvar+"] ...")

    ;*** set res for diff vars ***
    res_vars1 = res_vars             ; plot res
    res_diff_vars1 = res_diff_vars   ; plot res

    ;if ( varvar .eq. "" ) then
    ; res_vars1@gsnLeftString = ""
    ; res_diff_vars1@gsnLeftString = ""
    ;end if

    ; set wks
    wks_name_any      = plotname_head+"all_"+stepname+"-"+varvar+"-"+suffix_any
    wks_name_anyMbase = plotname_head+"all_"+stepname+"-"+varvar+"-"+suffix_any+"M"+suffix_base

    wks_any      = gsn_open_wks(wks_type, wks_name_any)
    wks_anyMbase = gsn_open_wks(wks_type, wks_name_anyMbase)

    ; read a varialbe
    if ( isatt(opt_2Ddata,"time_step") ) then
      delete(opt_2Ddata@time_step)
    end if

    varvar_base0 = ignorant_convert_2Ddata(filename_base,varvar,opt_2Ddata)
    varvar_base  = varvar_base0(tt1:tt2,:,:)

    varvar_any0 = ignorant_convert_2Ddata(filename_any,varvar,opt_2Ddata)
    varvar_any  = varvar_any0(tt1:tt2,:,:)

    change_var_atts(varvar, varvar_base, res_vars1, opt_change)
    change_var_atts(varvar, varvar_base, res_diff_vars1, opt_change)

    change_var_atts(varvar, varvar_any, res_vars1, opt_change)
    change_var_atts(varvar, varvar_any, res_diff_vars1, opt_change)

    varvar_anyMbase = diff(varvar_any,varvar_base)

    ; plot each time step
    tcount = 0
    do tt=tt1,tt2
      stepname1 = stepname_work(tt)

      if (varvar.eq."U" .or. varvar.eq."V") then
        opt_cncolors@colormap_positive = "MPL_Greens"
        opt_cncolors@colormap_negative = "MPL_Purples"
        cnColors_PosNeg(varvar_any(tcount,:,:), res_vars1, opt_cncolors)
      end if

      ; plot
      res_vars1@tiMainString = stepname1
      plot_varvar_any(tcount) = gsn_csm_contour_map_avg(wks_any, varvar_any(tcount,:,:), res_vars1, opt_cnmap)

      res_diff_vars1@tiMainString = stepname1

      delete(opt_cncolors)
      opt_cncolors = True

      cnColors_PosNeg(varvar_anyMbase(tcount,:,:), res_diff_vars1, opt_cncolors)
      plot_varvar_anyMbase(tcount) = gsn_csm_contour_map_avg(wks_anyMbase, varvar_anyMbase(tcount,:,:), res_diff_vars1, opt_cnmap)

      tcount = tcount + 1
    end do

    ; panel
    resp@txString =  varvar+" - "+suffix_any
    gsn_panel(wks_any, plot_varvar_any, (/row1,column1/), resp)
    print("Done. Create ["+wks_name_any+"]")

    resp@txString =  varvar+" - "+suffix_any+" MINUS "+suffix_base
    gsn_panel(wks_anyMbase, plot_varvar_anyMbase, (/row1,column1/), resp)
    print("Done. Create ["+wks_name_anyMbase+"]")

    delete(varvar_base)
    delete(varvar_base0)
    delete(varvar_any)
    delete(varvar_any0)
    delete(res_vars1)
    delete(res_diff_vars1)

    end do ; end do of vars
  end do ; end do of files

  delete(plot_varvar_any)
  delete(plot_varvar_anyMbase)

end if ; end if of choice3: option_plot = "fig-1var_ntimes-name_nvars_nfiles"

;--------------------------------------------------------------
; option_plot, choice 4,  "fig_1var_nfiles_diff-name_nvars"
;--------------------------------------------------------------

if ( isatt(option_plot,"choice4") .and. option_plot@choice4 .eq. "fig_1var_nfiles_sameLB-name_nvars_nsteps" ) then
 
  print("") 
  print("--------------------------------------------------------------------------")
  print("choice 4: plot a variable of multiple files and diff at each time step")
  print("--------------------------------------------------------------------------")

  ;*************
  ; user setup
  ;*************
  ; set string
  gsnleftstrings = new(nvar, "string")
  gsnrightstrings = gsnleftstrings
  gsnleftstrings = ""

  ; set plot variables
  plot_varvar_allAdiff  = new( nfile*2-1, "graphic" )

  ;***************
  ; program start
  ;***************
  ; set panel #column & #row
  row1 = nfile        ; #column of upper row
  column1 = nfile-1   ; #column of lower row

; loop for variables
do vv=0,nvar-1
  varvar = varvars(vv)

  ;*** set res ***
  res_vars1 = res_vars
  res_diff_vars1 = res_diff_vars

  ;if ( varvar .eq. "" ) then
  ; res_vars1@gsnLeftString = ""
  ; res_diff_vars1@gsnLeftString = ""
  ;end if

  ;*************************************
  ; set common contour values and diff 
  ;*************************************

  ; read all files
  varvar_all = ignorant_get_var_files(infilenames,varvar,opt_file)

  change_var_atts(varvar, varvar_all, res_vars1, opt_change)
  change_var_atts(varvar, varvar_all, res_diff_vars1, opt_change)

  varvar_allMbase = varvar_all

  do ff=0,nfile-1
    varvar_allMbase(ff,:,:,:) = diff(varvar_all(ff,:,:,:),varvar_all(nfile-1,:,:,:))
  end do

  ; determine max and min values for all values
  varvar_all_max      = max(varvar_all)
  varvar_all_min      = min(varvar_all)

  mnmxint_all = nice_mnmxintvl(varvar_all_min, varvar_all_max, max_levels_any, False)
  cnmin_all = mnmxint_all(0)
  cnmax_all = mnmxint_all(1)
  cnint_all = mnmxint_all(2)

  res_vars1@cnLevelSelectionMode = "ManualLevels"
  res_vars1@cnMinLevelValF = cnmin_all
  res_vars1@cnMaxLevelValF = cnmax_all
  res_vars1@cnLevelSpacingF = cnint_all

  ; determine max and min values for all diff values
  varvar_allMbase_max = max(varvar_allMbase)
  varvar_allMbase_min = min(varvar_allMbase)

  mnmxint_allMbase = nice_mnmxintvl(varvar_allMbase_min, varvar_allMbase_max, max_levels_anyMbase, False)
  cnmin_allMbase = mnmxint_allMbase(0)
  cnmax_allMbase = mnmxint_allMbase(1)
  cnint_allMbase = mnmxint_allMbase(2)

  res_diff_vars1@cnLevelSelectionMode = "ManualLevels"
  res_diff_vars1@cnMinLevelValF = cnmin_allMbase
  res_diff_vars1@cnMaxLevelValF = cnmax_allMbase
  res_diff_vars1@cnLevelSpacingF = cnint_allMbase

  ;if (varvar.eq."") then
  ;  res_diff_vars1@cnMinLevelValF = 
  ;  res_diff_vars1@cnMaxLevelValF = 
  ;  res_diff_vars1@cnLevelSpacingF = 
  ;end if
   
  ; determine diff fill colors
  opt_cncolors1 = opt_cncolors 
  opt_cncolors1@cnlevels_predefine = True
  cnColors_PosNeg(varvar_all(0,0,:,:),res_diff_vars1,opt_cncolors1)
  
  ; loop for time steps
  do tt=tt1,tt2
    ;ss1 = sprinti("%4.4i",tt+1)
    stepname1 = stepname_work(tt)
    stepname1 = time_string(tt)  ; use yymmdd_hh"h", e.g. 090101_03h
    opt_2Ddata@time_step = tt

    print("")
    print("process ["+varvar+", "+stepname1+"] ...")

    ;wks_name_allAdiff = plotname_head+varvar+"-"+stepname1+"-all_values-allM"+suffixes(nfile-1)
    ;wks_name_allAdiff = plotname_head+varvar+"-all_values-allM"+suffixes(nfile-1)+"-"+stepname1
    wks_name_allAdiff = plotname_head+"all_values-allM"+suffixes(nfile-1)+"-"+varvar+"-"+stepname1
    wks_allAdiff = gsn_open_wks(wks_type, wks_name_allAdiff)

    ;******************************
    ; plot variables of base file
    ;******************************
    varvar_base = ignorant_convert_2Ddata(filename_base,varvar,opt_2Ddata)
    ;varvar_base = filetemp_base->$varvar$(tt,:,:)

    change_var_atts(varvar, varvar_base, res_vars1, opt_change)
    change_var_atts(varvar, varvar_base, res_diff_vars1, opt_change)

    res_vars1@tiMainString = suffix_base
    plot_varvar_allAdiff(0) = gsn_csm_contour_map_avg(wks_allAdiff, varvar_base, res_vars1, opt_cnmap)

    ;******************************
    ; plot variables except base file
    ;******************************

    do ff=0,nfile-2
      ; set file name and suffix
      filename_any = infilenames(ff)
      filetemp_any = addfile(filename_any,"r")

      suffix_any  = suffixes(ff)
      suffix_anyMbase = suffix_any+"M"+suffix_base

      ; read variables and rearrange
      varvar_any = ignorant_convert_2Ddata(filename_any,varvar,opt_2Ddata)
      ;varvar_any = filetemp_any->$varvar$(tt,:,:)

      change_var_atts(varvar, varvar_any, res_vars1, opt_change)
      change_var_atts(varvar, varvar_any, res_diff_vars1, opt_change)
     
      varvar_anyMbase = diff(varvar_any,varvar_base)

      ; plot 
      res_vars1@tiMainString = suffix_any
      plot_varvar_allAdiff(ff+1)     = gsn_csm_contour_map_avg(wks_allAdiff, varvar_any, res_vars1, opt_cnmap)

      res_diff_vars1@tiMainString = suffix_any+" - "+suffix_base
      plot_varvar_allAdiff(ff+nfile) = gsn_csm_contour_map_avg(wks_allAdiff, varvar_anyMbase, res_diff_vars1, opt_cnmap)

    end do ; end do of files

    delete(varvar_any)
    delete(varvar_base)
    delete(varvar_anyMbase)

    ; panel
    resp@txString =  varvar+" - "+stepname1
    resp@gsnPanelRowSpec = True
    gsn_panel(wks_allAdiff, plot_varvar_allAdiff, (/row1,column1/), resp)
    print("Done. Create ["+wks_name_allAdiff+"]")

  end do ; end do of time steps

  delete(varvar_all)
  delete(varvar_allMbase)
  delete(res_vars1)
  delete(res_diff_vars1)
  delete(opt_cncolors1)

end do ; end do of vars

  delete(plot_varvar_allAdiff)
end if ; end if of choice4: option_plot = "fig_1var_nfiles_sameLB-name_nvars_nsteps"

;--------------------------------------------------------------
; option_plot, choice 5,  "fig_1var_2files_siglvl-name_nvars"
;--------------------------------------------------------------

if ( isatt(option_plot,"choice5") .and. option_plot@choice5 .eq. "fig_1var_2files_siglvl-name_nvars" ) then
 
  print("") 
  print("--------------------------------------------------------------------------")
  print("choice 5: plot every variable of two files and diff with t-test overlay")
  print("--------------------------------------------------------------------------")

  ;******************************
  ; get lat and lon dimensions
  ;******************************

  nlat = -1
  nlon = -1

  if ( isdim(filetemp_base,"lat") ) then
    nlat = dimsizes(filetemp_base&lat)
  end if

  if ( isdim(filetemp_base,"lon") ) then
    nlon = dimsizes(filetemp_base&lon)
  end if

  ;****************************************
  ; set panel plot, row and column number
  ;****************************************
  plot = new(2,"graphic")
  row1    = 1
  column1 = 2

  ; loop for variables
  do vv=0,nvar-1
    varvar = varvars(vv)
    print("")
    print("process ["+varvar+"] ...")

    ;*** set res for diff vars ***
    res_vars1 = res_vars
    res_diff_vars1 = res_diff_vars

    opt_cncolors = True

    ;if ( varvar .eq. "" ) then
    ; ;opt_cncolors = False
    ; ;opt_cncolors@cnlevels_predefine = False
    ; res_vars1@gsnLeftString = ""
    ; res_diff_vars1@gsnLeftString = " at "+siglev+"% level"
    ;end if

    ;******************************
    ; plot variables of base file
    ;******************************
    varvar_base0 = ignorant_convert_2Ddata(filename_base,varvar,opt_2Ddata)
    varvar_base  = varvar_base0(tt1:tt2,:,:)
    varvar_base_avg = dim_avg_n_Wrap(varvar_base,0)

    change_var_atts(varvar, varvar_base, res_vars1, opt_change)
    change_var_atts(varvar, varvar_base, res_diff_vars1, opt_change)

    ;******************************
    ; plot* variables except base file
    ;******************************

    do ff=0,nfile-2

      ; set file name and suffix
      filename_any = infilenames(ff)
      filetemp_any = addfile(filename_any,"r")

      suffix_any  = suffixes(ff)
      suffix_anyMbase = suffix_any+"M"+suffix_base

      print("  process file ["+suffix_any+" , "+suffix_base+"] ...")

      ; read variables and rearrange
      varvar_any0 = ignorant_convert_2Ddata(filename_any,varvar,opt_2Ddata)
      varvar_any  = varvar_any0(tt1:tt2,:,:)

      change_var_atts(varvar, varvar_any, res_vars1, opt_change)
      change_var_atts(varvar, varvar_any, res_diff_vars1, opt_change)

      ;wksname_anyMbase_siglvl = plotname_head+varvar+"-"+suffix_anyMbase+"_siglvl-"+varvar
      wksname_anyMbase_siglvl = plotname_head+suffix_anyMbase+"_siglvl-"+varvar
      wks_anyMbase_siglvl = gsn_open_wks(wks_type, wksname_anyMbase_siglvl)

      ;********
      ; plot
      ;********
   
      ; plot varvar_base
      res_vars1@tiMainString = suffix_base
      ;res_vars1@gsnCenterString = (mean_prefix + sprintf(mean_format,lat_wgt_avg(varvar_base_avg)))

      ; plot varvar_anyMbase with siglvl
      res_diff_vars1@tiMainString = suffix_any+" - "+suffix_base+" at "+siglev+"% level for ("+tt1+"- "+tt2+") "+stepname
      ;res_diff_vars1@gsnCenterString = (mean_prefix + sprintf(mean_format,lat_wgt_avg(varvar_anyMbase_avg)))

      plot_base_avg = gsn_csm_contour_map_avg(wks_anyMbase_siglvl, varvar_base_avg, res_vars1, opt_cnmap)

      opt11 = opt_cnmap
      opt11@siglvl = siglvl
      plot_anyMbase_siglev = gsn_csm_contour_map_siglvl(wks_anyMbase_siglvl, varvar_any, varvar_base,res_diff_vars1,res_sig,opt11)

      ;*************
      ; panel plot
      ;*************
      plot(0) = plot_base_avg
      plot(1) = plot_anyMbase_siglev
      gsn_panel(wks_anyMbase_siglvl ,plot, (/row1,column1/),resp)

      delete(varvar_any0)
      delete(varvar_any)
      delete(wksname_anyMbase_siglvl)
      delete(wks_anyMbase_siglvl)
    end do ; end do of files

    delete(varvar_base0)
    delete(varvar_base)
    delete(res_vars1)
    delete(res_diff_vars1)
    delete(opt_cncolors)

  end do ; end do of vars

end if ; end if of choice5: option_plot = "fig_1var_2files_siglvl-name_nvars"

;--------------------------------------------------------------
; option_plot, choice 6,  "fig_nvars_tavg_siglvl-nfiles"
;--------------------------------------------------------------

if ( isatt(option_plot,"choice6") .and. option_plot@choice6 .eq. "fig_nvars_tavg_siglvl-nfiles" ) then

  print("")
  print("------------------------------------------------------------------------------------------------")
  print("choice 6: plot time-avgeraged all variable of individual file and diff with significance level") 
  print("------------------------------------------------------------------------------------------------")

  ; set graphic variable
  plot_varvar_any = new (nvar,"graphic")
  plot_varvar_anyMbase = new (nvar,"graphic")

  ; compute panel row# and column#
  row1 = toint(sqrt(nvar))
  pp1 = sqrt(nvar)-tofloat(row1)
  if (pp1 .gt. 0.5) then
    row1 = row1+1
  end if
  column1 = row1+1

  do i=2,5
    if (sqrt(nvar).eq.tofloat(i)) then
      row1 = i
      column1 = row1
    end if
  end do

  do ff=0,nfile-1
    filename_any = infilenames(ff)
    filetemp_any = addfile(filename_any,"r")
    print("")
    print("procees file ["+filename_any+"] ...")

    ; set f=suffix
    suffix_any  = suffixes(ff)
    suffix_base = suffixes(nfile-1)

    ; set wks
    wks_name_any      = plotname_head+"all_vars_tavg-"+suffix_any
    wks_name_anyMbase = plotname_head+"all_vars_tavg-"+suffix_any+"M"+suffix_base+"-siglvl"

    wks_any      = gsn_open_wks(wks_type, wks_name_any)
    wks_anyMbase = gsn_open_wks(wks_type, wks_name_anyMbase)

    ; loop for each variable
    do vv=0,nvar-1
      varvar = varvars(vv)
      print("  process variable ["+varvar+"] ...")

      ;*** set res for diff vars ***
      res_vars1 = res_vars             ; plot res
      res_diff_vars1 = res_diff_vars   ; plot res

      varvar_base0 = ignorant_convert_2Ddata(filename_base,varvar,opt_2Ddata)
      varvar_base  = varvar_base0(tt1:tt2,:,:)

      varvar_any0 = ignorant_convert_2Ddata(filename_any,varvar,opt_2Ddata)
      varvar_any  = varvar_any0(tt1:tt2,:,:)

      change_var_atts(varvar, varvar_base, res_vars1, opt_change)
      change_var_atts(varvar, varvar_base, res_diff_vars1, opt_change)

      change_var_atts(varvar, varvar_any, res_vars1, opt_change)
      change_var_atts(varvar, varvar_any, res_diff_vars1, opt_change)

      varvar_anyMbase = diff(varvar_any,varvar_base)
      varvar_base_tavg      = dim_avg_n_Wrap(varvar_base,0)
      varvar_any_tavg       = dim_avg_n_Wrap(varvar_any,0)
      varvar_anyMbase_tavg  = dim_avg_n_Wrap(varvar_anyMbase,0)
     
      ; plot
      res_vars1@tiMainString = varvar
      plot_varvar_any(vv) = gsn_csm_contour_map_avg(wks_any, varvar_any_tavg(:,:), res_vars1, opt_cnmap)

      res_diff_vars1@tiMainString = varvar

      delete(opt_cncolors)
      opt_cncolors = True
      ;cnColors_PosNeg(varvar_anyMbase, res_diff_vars1, opt_cncolors)
      
      opt11 = opt_cnmap
      opt11@siglvl = siglvl 
      ;res_diff_vars1@gsnCenterString = (mean_prefix + sprintf(mean_format,lat_wgt_avg(varvar_anyMbase_tavg)))
      plot_varvar_anyMbase(vv) = gsn_csm_contour_map_siglvl(wks_anyMbase,varvar_any, varvar_base,res_diff_vars1,res_sig,opt11)  

      delete(varvar_any0)
      delete(varvar_any)
      delete(varvar_any_tavg)
      delete(varvar_base0)
      delete(varvar_base)
      delete(varvar_base_tavg)
      delete(varvar_anyMbase)
      delete(varvar_anyMbase_tavg)

      delete(res_vars1)
      delete(res_diff_vars1)
    end do ; end do of vars

    ; panel
    resp@txString =  suffix_any+" - avg over ("+tt1+"-"+tt2+") "+stepname
    gsn_panel(wks_any, plot_varvar_any, (/row1,column1/), resp)
    print("Done. Create ["+wks_name_any+"]")

    resp@txString =  suffix_any+" MINUS "+suffix_base+", at "+siglev+"% level for ("+tt1+"- "+tt2+") "+stepname
    gsn_panel(wks_anyMbase, plot_varvar_anyMbase, (/row1,column1/), resp)
    print("Done. Create ["+wks_name_anyMbase+"]")

  end do   ; end do of files

  delete(plot_varvar_any)
  delete(plot_varvar_anyMbase)  

end if ; end if of choice6: option_plot = "fig_nvars_tavg_siglvl-nfiles"

;---------------------------------------------------------------
; option_plot, choice 7,  "fig_nvars_tavg_siglvl-nfiles_group"
;---------------------------------------------------------------
if ( isatt(option_plot,"choice7") .and. option_plot@choice7 .eq. "fig_nvars_tavg_siglvl-nfiles_group" ) then

  print("")
  print("------------------------------------------------------------------------------------------------")
  print("choice 7: plot time-avgeraged all variables of grouped files and diff with significance level") 
  print("------------------------------------------------------------------------------------------------")

  ; set graphic variable
  plot_varvar_any  = new (nvar,"graphic")
  plot_varvar_base = new (nvar,"graphic")
  plot_varvar_anyMbase = new (nvar,"graphic")

  ; compute panel row# and column#
  row1 = toint(sqrt(nvar))
  pp1 = sqrt(nvar)-tofloat(row1)
  if (pp1 .gt. 0.5) then
    row1 = row1+1
  end if
  column1 = row1+1

  do i=2,5
    if (sqrt(nvar).eq.tofloat(i)) then
      row1 = i
      column1 = row1
    end if
  end do

  ; make sure the number of group is an integer
  if ( option_group .and. nfile_per_group.eq.nfile .or. mod(nfile,nfile_per_group).ne.0 ) then
    print("ERROR: nfile is ["+nfile+"] and nfile_per_group is ["+nfile_per_group+"], # of group MUST be an interger and not equal to nfile")
    print("Program stop")
    exit()
  end if

  ; loop for each group
  do gg=0,nfile-1,nfile_per_group
    ff1=gg
    ff2=ff1+nfile_per_group-1
    ;print("a, "+ff1+" , "+ff2)

    ; set base file
    filename_base = infilenames(ff2)
    filetemp_base = addfile(filename_base,"r")
    suffix_base = suffixes(ff2)
    wks_name_base = plotname_head+"all_vars_tavg-"+suffix_base
    wks_base      = gsn_open_wks(wks_type, wks_name_base)

    ; process every file with respect to the base file in the same group
    ; this part is the same as choice6
    do ff=ff1,ff2-1
      filename_any = infilenames(ff1)
      filetemp_any = addfile(filename_any,"r")
      suffix_any  = suffixes(ff)

      print("")
      print("procees file ["+filename_any+"] with respect to ["+filename_base+"]")
    
      ; set wks
      wks_name_any = plotname_head+"all_vars_tavg-"+suffix_any
      wks_any      = gsn_open_wks(wks_type, wks_name_any)

      wks_name_anyMbase = plotname_head+"all_vars_tavg-"+suffix_any+"M"+suffix_base+"-siglvl"  
      wks_anyMbase      = gsn_open_wks(wks_type, wks_name_anyMbase)
  
      ; loop for each variable
      do vv=0,nvar-1
        varvar = varvars(vv)
        print("  process variable ["+varvar+"] ...")
  
        ;*** set res for diff vars ***
        res_vars1 = res_vars             ; plot res
        res_diff_vars1 = res_diff_vars   ; plot res
  
        varvar_base0 = ignorant_convert_2Ddata(filename_base,varvar,opt_2Ddata)
        varvar_base  = varvar_base0(tt1:tt2,:,:)
  
        varvar_any0 = ignorant_convert_2Ddata(filename_any,varvar,opt_2Ddata)
        varvar_any  = varvar_any0(tt1:tt2,:,:)
  
        change_var_atts(varvar, varvar_base, res_vars1, opt_change)
        change_var_atts(varvar, varvar_base, res_diff_vars1, opt_change)
  
        change_var_atts(varvar, varvar_any, res_vars1, opt_change)
        change_var_atts(varvar, varvar_any, res_diff_vars1, opt_change)
  
        varvar_anyMbase = diff(varvar_any,varvar_base)
        varvar_base_tavg      = dim_avg_n_Wrap(varvar_base,0)
        varvar_any_tavg       = dim_avg_n_Wrap(varvar_any,0)
        varvar_anyMbase_tavg  = dim_avg_n_Wrap(varvar_anyMbase,0)
       
        ; plot
        res_vars1@tiMainString = varvar
        plot_varvar_base(vv) = gsn_csm_contour_map_avg(wks_base, varvar_base_tavg(:,:), res_vars1, opt_cnmap)
        plot_varvar_any(vv) = gsn_csm_contour_map_avg(wks_any, varvar_any_tavg(:,:), res_vars1, opt_cnmap)
  
        res_diff_vars1@tiMainString = varvar
  
        delete(opt_cncolors)
        opt_cncolors = True
        ;cnColors_PosNeg(varvar_anyMbase, res_diff_vars1, opt_cncolors)
        
        opt11 = opt_cnmap
        opt11@siglvl = siglvl 
        ;res_diff_vars1@gsnCenterString = (mean_prefix + sprintf(mean_format,lat_wgt_avg(varvar_anyMbase_tavg)))

        ;if (varvar.eq."") then
        ;  opt11@cnlevels_predefine = True
        ;  res_diff_vars1@cnLevelSelectionMode = "ManualLevels"
        ;  res_diff_vars1@cnMinLevelValF = 
        ;  res_diff_vars1@cnMaxLevelValF = 
        ;  res_diff_vars1@cnLevelSpacingF = 
        ;end if

        plot_varvar_anyMbase(vv) = gsn_csm_contour_map_siglvl(wks_anyMbase,varvar_any, varvar_base,res_diff_vars1,res_sig,opt11)  
        delete(varvar_any0)
        delete(varvar_any)
        delete(varvar_any_tavg)
        delete(varvar_base0)
        delete(varvar_base)
        delete(varvar_base_tavg)
        delete(varvar_anyMbase)
        delete(varvar_anyMbase_tavg)
  
        delete(opt11)
        delete(res_vars1)
        delete(res_diff_vars1)
      end do ; end do of vars
  
      ; panel
      ;resp@txString =  suffix_base+" - avg over ("+tt1+"-"+tt2+") "+stepname
      resp@txString = txString_ALL+", "+suffix_base     
      gsn_panel(wks_base, plot_varvar_base, (/row1,column1/), resp)
      print("Done. Create ["+wks_name_base+"]")

      ;resp@txString =  suffix_any+" - avg over ("+tt1+"-"+tt2+") "+stepname
      resp@txString = txString_ALL+", "+suffix_any
      gsn_panel(wks_any, plot_varvar_any, (/row1,column1/), resp)
      print("Done. Create ["+wks_name_any+"]")
  
      ;resp@txString =  suffix_any+" MINUS "+suffix_base+", at "+siglev+"% level for ("+tt1+"- "+tt2+") "+stepname
      resp@txString = txString_ALL+", ~C~"+suffix_any+" - "+suffix_base
      gsn_panel(wks_anyMbase, plot_varvar_anyMbase, (/row1,column1/), resp)
      print("Done. Create ["+wks_name_anyMbase+"]")
  
    end do   ; end do of files
  end do ; end do of group

end if ; end if of choice7: option_plot = "fig_nvars_tavg_siglvl-nfiles_group"

;--------------------------------------------------------------
; option_plot, choice8,  "fig_1var_nfiles-name_nvars"
;-------------------------------------------------------------

if ( isatt(option_plot,"choice8") .and. option_plot@choice8 .eq. "fig_1var_tavg_siglvl-nfiles_group" ) then

  print("")
  print("--------------------------------------------------------------------------")
  print("choice 8: plot each variable in all files with significance level")
  print("--------------------------------------------------------------------------")

  ;----------------------
  ; set number of plots
  ;----------------------
  nplot = nfile_per_group
  ;print(nplot)

  ; compute panel row# and column# 
  row1 = toint(sqrt(nplot))
  pp1 = sqrt(nplot)-tofloat(row1)
  if (pp1 .gt. 0.5) then
    row1 = row1+1
  end if
  column1 = row1+1

  do i=2,5
    if (sqrt(nplot).eq.tofloat(i)) then
      row1 = i
      column1 = row1
    end if
  end do

  plot_varvar_baseAdiff = new( nplot, "graphic" )
  plot_varvar_allAvalue = new( nplot, "graphic" )
  plot_varvar_allAdiff  = new( nplot, "graphic" )

  ;-------
  ; plot
  ;-------
  ; loop for variables
  do vv=0,nvar-1

    varvar = varvars(vv)
    print("")
    print("process ["+varvar+"] ...")
    
    opt_cncolors1 = opt_cncolors
    ;if (varvar .eq. "") then
    ;  res_vars@cnLevelSelectionMode = "ManualLevels"
    ;  res_vars@cnMinLevelValF = 
    ;  res_vars@cnMaxLevelValF = 
    ;  res_vars@cnLevelSpacingF =
    ;
    ;  res_diff_vars@cnLevelSelectionMode = "ManualLevels"
    ;  res_diff_vars@cnMinLevelValF = 
    ;  res_diff_vars@cnMaxLevelValF = 
    ;  res_diff_vars@cnLevelSpacingF =
    ;end if

    ; loop for file_base
    do ff1=0,nfile-1,nfile_per_group
      infilename_base = infilenames_base(ff1)
      suffix_base     = suffixes_base(ff1)

      res_vars0 = res_vars             ; plot res
      res_diff_vars0 = res_diff_vars   ; plot res

      if (option_sameLB) then  
        opt_sameLB1   = option_sameLB 
        ;ignorant_sameLB(infilenames(ff1:ff1+nfile_per_group-1), varvar, res_vars0, opt_sameLB1)
        ignorant_sameLB(infilenames(:), varvar, res_vars0, opt_sameLB1)

        opt_sameLB1@diff2base = True
        opt_sameLB1@filename_base = infilenames_base
        ;ignorant_sameLB(infilenames(ff1:ff1+nfile_per_group-1), varvar, res_diff_vars0, opt_sameLB1)
        ignorant_sameLB(infilenames(:), varvar, res_diff_vars0, opt_sameLB1)
        ;print(res_vars)
        ;print(res_diff_vars)
        ;print(opt_sameLB1)
        delete(opt_sameLB1)
      end if

      ;*** set res for diff vars ***
      res_vars1 = res_vars0             ; plot res
      res_diff_vars1 = res_diff_vars0   ; plot res
      res_temp = True

      plotname_var  = varvar
      plotname_step = plotname_steps_base(ff1)

      plotname_file = suffix_base+"_diff2"+suffix_base
      wks_name_baseAdiff = plotname_head +"-"+ plotname_type +"-"+ plotname_file +"-"+ plotname_var +"-"+ plotname_step +"-" 
      wks_baseAdiff = gsn_open_wks(wks_type, wks_name_baseAdiff)
  
      plotname_file = suffix_base+"_ALL_values"
      wks_name_allAvalue = plotname_head +"-"+ plotname_type +"-"+ plotname_file +"-"+ plotname_var +"-"+ plotname_step +"-"
      wks_allAvalue = gsn_open_wks(wks_type, wks_name_allAvalue)
  
      plotname_file = suffix_base+"_ALL_diff"
      wks_name_allAdiff = plotname_head +"-"+ plotname_type +"-"+ plotname_file +"-"+ plotname_var +"-"+ plotname_step +"-"
      wks_allAdiff = gsn_open_wks(wks_type, wks_name_allAdiff)
  
      ;******************************
      ; plot variables of base file
      ;******************************
      varvar_base = ignorant_convert_2Ddata(infilename_base,varvar,opt_2Ddata)
      ;varvar_base = filetemp_any->$varvar$(tt,:,:)
  
      change_var_atts(varvar, varvar_base, res_vars1, opt_change)
      change_var_atts(varvar, varvar_base, res_diff_vars1, opt_change)
  
      varvar_base_tavg      = dim_avg_n_Wrap(varvar_base,0)

      ; plot
      res_vars1@tiMainString = suffix_base
  
      plot_varvar_baseAdiff(0) = gsn_csm_contour_map_avg(wks_baseAdiff, varvar_base_tavg, res_vars1, opt_cnmap)
      plot_varvar_allAvalue(0) = gsn_csm_contour_map_avg(wks_allAvalue, varvar_base_tavg, res_vars1, opt_cnmap)
  
      res_diff_vars1@tiMainString = suffix_base+" - "+suffix_base
      plot_varvar_allAdiff(0) = gsn_csm_contour_map_avg(wks_allAdiff, diff(varvar_base_tavg,varvar_base_tavg), res_diff_vars1, opt_cnmap)

      ;******************************
      ; plot variables of any file
      ;******************************
      ff=1
      do ff2=ff1,ff1+nfile_per_group-2
        res_vars2 = res_vars0             ; plot res
        res_diff_vars2 = res_diff_vars0   ; plot res
  
        filename_any = infilenames(ff2)
        suffix_any   = suffixes(ff2)
  
        ; read variables and rearrange
        varvar_any = ignorant_convert_2Ddata(filename_any,varvar,opt_2Ddata)
        ;varvar_any = filetemp_any->$varvar$(tt,:,:)
  
        change_var_atts(varvar, varvar_any, res_vars2, opt_change)

        varvar_anyMbase = diff(varvar_any,varvar_base)
        change_var_atts(varvar, varvar_anyMbase, res_diff_vars2, opt_change)

        ; plot 
        ;res_vars2@tiMainString = suffix_any
        ;res_diff_vars2@tiMainString = suffix_any+" - "+suffix_base  
        ;opt_cncolors2 = opt_cncolors1
        ;cnColors_PosNeg(varvar_anyMbase, res_diff_vars2, opt_cncolors2)
        ;plot_varvar_baseAdiff(ff) = gsn_csm_contour_map_avg(wks_baseAdiff, varvar_anyMbase, res_diff_vars2, opt_cnmap)
        ;plot_varvar_allAdiff(ff) = gsn_csm_contour_map_avg(wks_allAdiff, varvar_anyMbase, res_diff_vars2, opt_cnmap)

        opt11 = opt_cnmap
        opt11@siglvl = siglvl

        res_diff_vars2@tiMainString = suffix_any+" - "+suffix_base+", p-value < "+siglvl
        plot_varvar_baseAdiff(ff) = gsn_csm_contour_map_siglvl(wks_baseAdiff,varvar_any, varvar_base,res_diff_vars2,res_sig,opt11)
        plot_varvar_allAdiff(ff) = gsn_csm_contour_map_siglvl(wks_allAdiff,varvar_any, varvar_base,res_diff_vars2,res_sig,opt11)

        varvar_any_tavg       = dim_avg_n_Wrap(varvar_any,0)
        res_vars2@tiMainString = suffix_any
        plot_varvar_allAvalue(ff) = gsn_csm_contour_map_avg(wks_allAvalue, varvar_any_tavg, res_vars2, opt_cnmap)

        ff=ff+1
        delete(varvar_any)
        delete(varvar_any_tavg)
        delete(res_vars2)
        delete(res_diff_vars2)
        ;delete(opt_cncolors2)
        delete(opt11)
      end do ; end do of file_any

    delete(varvar_base)
    delete(varvar_base_tavg)
    delete(res_vars0)
    delete(res_diff_vars0)

    ; panel
    resp@txString =  txString_ALL+" - "+varvar+", "+plotname_step
    ;resp@gsnPanelRowSpec = True
    ;gsn_panel(wks_baseAdiff, plot_varvar_baseAdiff, (/1,row1,nplot-row1/), resp)
    resp@gsnPanelRowSpec = False
    gsn_panel(wks_baseAdiff, plot_varvar_baseAdiff, (/row1,column1/), resp)

    ffname=wks_name_baseAdiff+"."+wks_type
    system("convert -trim "+ffname+" "+ffname)
    print("Done. Create ["+wks_name_baseAdiff+"]")

    ;resp@txString =  txString_ALL+" - "+varvar
    resp@gsnPanelRowSpec = False
    gsn_panel(wks_allAdiff, plot_varvar_allAdiff, (/row1,column1/), resp)
    ffname=wks_name_allAdiff+"."+wks_type
    system("convert -trim "+ffname+" "+ffname)
    print("Done. Create ["+wks_name_allAdiff+"]")

    ;resp@txString =  txString_ALL+" - "+varvar
    resp@gsnPanelRowSpec = False
    gsn_panel(wks_allAvalue, plot_varvar_allAvalue, (/row1,column1/), resp)
    ffname=wks_name_allAvalue+"."+wks_type
    system("convert -trim "+ffname+" "+ffname)
    print("Done. Create ["+wks_name_allAvalue+"]")

  end do ; end do of file_base

    delete(res_vars1)
    delete(res_diff_vars1)
    delete(opt_cncolors1)
  end do ; end do of var
end if ; end if of choice8: option_plot = "fig_1var_nfiles-name_nvars_nsteps"


end
