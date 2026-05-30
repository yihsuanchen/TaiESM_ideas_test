#!/bin/csh -f
#
#   Master script for CCSM Ocean Time Series Diagnostics
#
module purge
module load ncl_gcc-4.8.5/6.2.1 
module load aws-sdk-cpp_gcc-10.3.1/1.11.30 netcdf_hdf5-1.10.5_gcc-10.3.1/4.9.1 nco_netcdf-4.9.1_gcc-10.3.1/5.1.4 netcdf_hdf5-1.10.5_gcc-10.3.1/4.9.1 

#----------------- SET CASE INFO -------------------------------#
setenv CASE f09.B2000.ft13
#setenv RESOLUTION tx0.1v2 
setenv RESOLUTION gx1v6 
setenv YEAR0  6
setenv YEAR1  35
setenv CPL 7			# set to 7 if CCSM4 or higher, set to 6 otherwise
setenv MOC0  $YEAR0	# y-bounds for MOC timeseries plots
setenv MOC1  $YEAR1

#----------------- SET PLOT INFO -------------------------------#
setenv DOPLOTS 1		# generate plots for flagged PM's
setenv BASEDATE       0000-01-01
setenv NINO_MON_SKIP  0
## available plot modules
setenv PM_CPLLOG 	1	# CPL log energy budget line plots
setenv PM_YPOPLOG       1	# Yeager's  POP log file line plots (new and improved)
setenv PM_HORZMN 	1	# Regional Mean T,S(z,t) w/ diff&rms from obs
setenv PM_ENSOWVLT      1	# ENSO wavelet plots
setenv PM_MOCANN 	1	# Annual mean max MOC time series
setenv PM_MOCMON 	1	# Monthly mean max MOC time series
setenv PM_GENANN 	0	# Generate annual means

#----------------- SET MSS INFO --------------------------------#
setenv TAVGFILE tavg.$YEAR0.$YEAR1.nc
setenv MSLOGREAD 1
setenv MSROOT /lfs/home/yihsuanc/test/j1-modified_Ke_Sc_top
#setenv MSROOT /lfs/home/simonc/data/taiesm
#setenv MSROOT /lfs/archive/TaiESM_output
setenv MSPROJ 00000000
setenv MSRPD 3000
# NOTE! $TOOLPATH scripts assume the following mass store directory
# structure:
#     /${MSROOT}/${CASE}/ocn/hist
#     /${MSROOT}/${CASE}/ocn/logs
#     /${MSROOT}/${CASE}/ocn/proc/tavg/annual
#     /${MSROOT}/${CASE}/ocn/proc/tavg/monthly


#----------------- SET WEB PAGE INFO - -------------------------#
setenv DOWEB 1		# generate a web page for flagged PM's 
setenv WEBMACH webpub.ucar.edu
setenv WEBDIR1 /web/ncl/Applications/popdiag/
setenv WEBDIR2 ${WEBDIR1}/pdts
setenv APPEND 0		# append new plots if web page already exists
setenv GLOSSARY 0	# append a POP glossary at the bottom of web page

#----------------- SET PATH INFO -------------------------------#
#setenv DIAGROOTPATH /lfs/home/lama/work/taiesm_diag/pop_diag 
setenv DIAGROOTPATH /lfs/home/yihsuanc/test/j1-modified_Ke_Sc_top/POP2_diag
setenv MODPATH ${DIAGROOTPATH}/sourcemods
setenv IDLPATH ${DIAGROOTPATH}/idl_lib
setenv FERPATH ${DIAGROOTPATH}/fer_lib
setenv NCLPATH ${DIAGROOTPATH}/ncl_lib
setenv TOOLPATH ${DIAGROOTPATH}/tool_lib
setenv HTMLPATH ${DIAGROOTPATH}/html_lib
setenv WORKDIR $DIAGROOTPATH/diag_archive/${CASE}.ts
setenv PATH ${MODPATH}:${TOOLPATH}:${PATH}

#----------------- SET OBS INFO -------------------------------#
#setenv PDATA $DIAGROOTPATH/OBS_DATA/pop_obs_data_20100719
setenv PDATA /lfs/home/lama/data/obsdata/pop_data
setenv NINOOBSDIR ${PDATA}/nino
setenv NINOOBSFILE ANOMS_1950-2000.nc
setenv TSCLIMDIR ${PDATA}/phc/POP_format
setenv TCLIMFILE PHC2_TEMP_${RESOLUTION}_ann_avg.nc
setenv SCLIMFILE PHC2_SALT_${RESOLUTION}_ann_avg.nc

#----------------- SET FERRET INFO -------------------------------#
setenv FER_DIR      /contrib/ferret
setenv FER_PALETTE  "$FER_DIR/ppl"
setenv PLOTFONTS    "$FER_DIR/ppl/fonts"
setenv FER_GO       "${MODPATH} ${FERPATH} $FER_DIR/go"

#----------------- SET NCL INFO -------------------------------#
#setenv NCARG_ROOT  /data1/opt/ncl_ncarg-6.1.2_gcc-4.4.6 
setenv NCARG_ROOT $NCARG_ROOT 
setenv NCARG_COLORMAP_PATH $NCLPATH/colormaps:$NCARG_ROOT/lib/ncarg/colormaps
setenv PATH $NCARG_ROOT/bin:$PATH

#----------------- SET IDL INFO -------------------------------#
setenv PATH /fs/local/apps/rsi/idl/bin:/fs/local/bin:$PATH
setenv IDLCOLORTABLEFILE ${IDLPATH}/colortables/colors1.tbl
setenv IDLCOLORTABLE 42         # Blue/White/Red
setenv IDLMINCOLOR 1
setenv IDLMAXCOLOR 255

#--------------------------------------------------------------#
#----------------- END USER DEFINED SETTINGS ------------------#
#--------------------------------------------------------------#

if !(-d ${WORKDIR}) mkdir -p ${WORKDIR} 
cd ${WORKDIR} 
\rm -f *.pro  *.gif *.dat *.ps *.png

if ($DOWEB == 1) then
#  ssh -n ${WEBMACH} "if !(-d ${WEBDIR1}) mkdir -p -m 0775 ${WEBDIR1}"
#  ssh -n ${WEBMACH} "if !(-d ${WEBDIR2}) mkdir -p -m 0775 ${WEBDIR2}"
  if ($APPEND == 1) then 
    scp ${WEBMACH}:${WEBDIR2}/popdiagts.html . && removefooter.csh popdiagts.html
  else
    svn info $DIAGROOTPATH > tmp
    setenv POPDIAGREV "`sed -n '/Revision/p' tmp`"
    echo "running popdiagts $POPDIAGREV"
    sed "s/CASENAME/${CASE}/g" ${HTMLPATH}/tsheader.html > tmp.html
    sed "s/REVISION/${POPDIAGREV}/g" tmp.html > popdiagts.html && \rm tmp*
  endif
endif

##==> generate a plot data file
##   which contains general plot information available
##   to any of the plot module routines via ascii read.
echo 0. 360. -90. 90. >! plot.dat
echo 1 >> plot.dat
echo 0. >> plot.dat

####################  plot modules
##==> CPL log annual mean energy budget time series plots
if ($PM_CPLLOG == 1) then
  if ($DOWEB == 1) cat ${HTMLPATH}/cpllog_timeseries.html >> popdiagts.html
  if ($DOPLOTS == 1) then
    if ($MSLOGREAD == 1) then 
      echo "reading cpl log files"
      #\rm -f cpl.log.*   kilmer
      #hsi -P "prompt; mget /$MSROOT/$CASE/cpl/logs/cpl.log*"  kilmer
      cp /$MSROOT/$CASE/cpl/logs/* ${WORKDIR}  # kilmer 
      gunzip -f *.log*.gz
      
    endif
#   process_cpl6_logfiles_heat.old.awk y0=$YEAR0 y1=$YEAR1 cpl.log* >! cplheatbudget.txt
    if ($CPL == 7) then 
      setenv ntailht 23
      setenv ntailfw 23
      process_cpl7b_logfiles_heat.awk y0=$YEAR0 y1=$YEAR1 cpl.log* >! cplheatbudget.txt 
      process_cpl7b_logfiles_fw.awk y0=$YEAR0 y1=$YEAR1 cpl.log* >! cplfwbudget.txt    
    else
      setenv ntailht 16
      setenv ntailfw 16
      process_cpl6_logfiles_heat.awk y0=$YEAR0 y1=$YEAR1 cpl.log* >! cplheatbudget.txt
      process_cpl6_logfiles_fw.awk y0=$YEAR0 y1=$YEAR1 cpl.log* >! cplfwbudget.txt
    endif
    tail -${ntailfw} cplfwbudget.txt >! cplfwbudget.asc
    tail -${ntailht} cplheatbudget.txt >! cplheatbudget.asc
    addtowrapper.csh ncl cpl7b_log_timeseries_heat.ncl ncl_wrap.pro 
    addtowrapper.csh ncl cpl7b_log_timeseries_fw.ncl ncl_wrap.pro
  endif
endif

##==> POP log & dt file time series plots
if ($PM_YPOPLOG == 1) then
  if ($DOWEB == 1) then 
    cat ${HTMLPATH}/poplog_timeseries_yeager.html >> popdiagts.html
  endif
  if ($DOPLOTS == 1) then
    if ($MSLOGREAD == 1) then 
      echo "reading pop log files"
      # \rm -f ocn.log.*     kilmer
      # hsi -P "cd /$MSROOT/$CASE/ocn/logs ; prompt; mget ocn.log* " kilmer
      # hsi -P "cd /$MSROOT/$CASE/ocn/hist ; prompt; mget *.dt.* "  kilmer
      cp /$MSROOT/$CASE/ocn/logs/ocn.log*.gz ${WORKDIR} # kilmer 
      cp /$MSROOT/$CASE/ocn/hist/*.dt.* ${WORKDIR}      # kilmer
      gunzip -f ocn.log*.gz
    endif
    echo "process_pop2_logfiles" #kilmer
    process_pop2_logfiles.globaldiag.awk ocn.log.* 
    echo "process_pop2_dtfiles" # kilmer
    process_pop2_dtfiles.awk /$MSROOT/$CASE/ocn/hist/*.dt.*
    addtowrapper.csh ncl pop_log_diagts_3d.monthly.ncl ncl_wrap.pro
    addtowrapper.csh ncl pop_log_diagts_hflux.monthly.ncl ncl_wrap.pro
    addtowrapper.csh ncl pop_log_diagts_fwflux.monthly.ncl ncl_wrap.pro
    addtowrapper.csh ncl pop_log_diagts_cfc.monthly.ncl ncl_wrap.pro
    addtowrapper.csh ncl pop_log_diagts_nino.monthly.ncl ncl_wrap.pro
    addtowrapper.csh ncl pop_log_diagts_transports.ncl ncl_wrap.pro
    if (-e diagts_precfactor.asc) addtowrapper.csh ncl pop_log_diagts_precf.ncl ncl_wrap.pro
  endif
endif

if ($PM_HORZMN == 1) then
 ln -sf /${MSROOT}/${CASE}/ocn/hist/${CASE}.pop.h.????-??.nc ${WORKDIR}/.#JOY
  echo "PM_HORZMN"
  if ($DOWEB == 1) cat ${HTMLPATH}/horz_mean_timeseries.html >> popdiagts.html
  if ($DOPLOTS == 1) then
    ln -sf ${TSCLIMDIR}/${TCLIMFILE} .
    ln -sf ${TSCLIMDIR}/${SCLIMFILE} .
    set yr0 = `printf "%04d" $YEAR0`
    set yr1 = `printf "%04d" $YEAR1`
    if (! -e Sou_hor_mean_$CASE.$yr0-$yr1.nc) gen_TS_meandiffrms_timeseries.csh $MSROOT $CASE $YEAR0 $YEAR1
    addtowrapper.csh ncl TS_profiles_diff_plot.ncl ncl_wrap.pro
  endif
endif

if ($PM_ENSOWVLT == 1) then
  if ($DOWEB == 1) cat ${HTMLPATH}/enso_wavelet.html >> popdiagts.html
  if ($DOPLOTS == 1) then
    if (! -e diagts_nino.asc) echo "need to run POP log diagnostics"
    setenv FILE_IN diagts_nino.asc
    addtowrapper.csh ncl enso_wavelet_asc.ncl ncl_wrap.pro
  endif
endif

if ($PM_MOCANN == 1) then
 ln -sf /${MSROOT}/${CASE}/ocn/hist/${CASE}.pop.h.????-??.nc ${WORKDIR}/.#JOY
  echo "PM_MOCANN"
  if ($DOWEB == 1) cat ${HTMLPATH}/maxmoc.html >> popdiagts.html
  if ($DOPLOTS == 1) then
    set fields = (MOC N_HEAT N_SALT transport_regions transport_components moc_components)
    set yr0 = `printf "%04d" $YEAR0`
    set yr1 = `printf "%04d" $YEAR1`
    setenv MOCTSFILE $CASE.pop.h.MOC.${yr0}_cat_${yr1}.nc
    if !(-e ${MOCTSFILE}) then
#     echo "JOOOOOOY　${MOCTSFILE}"
      gen_pop_annual_timeseries.csh $MOCTSFILE $MSROOT $CASE $YEAR0 $YEAR1 $fields
    endif
    addtowrapper.csh ncl moc_annual_timeseries.ncl ncl_wrap.pro
  endif
endif

if ($PM_MOCMON == 1) then
echo "PM_MOCMON"
  if ($DOWEB == 1) cat ${HTMLPATH}/maxmoc_monthly.html >> popdiagts.html
  if ($DOPLOTS == 1) then
    set fields = (MOC N_HEAT N_SALT transport_regions transport_components moc_components)
    set yr0 = `printf "%04d" $YEAR0`
    set yr1 = `printf "%04d" $YEAR1`
    setenv MOCTSFILE $CASE.pop.h.MOC.${yr0}-01_cat_${yr1}-12.nc
    if !(-e ${MOCTSFILE}) then
    gen_pop_monthly_timeseries.csh $MOCTSFILE $MSROOT $CASE $YEAR0 $YEAR1 $fields
    endif
    addtowrapper.csh ncl moc_monthly_timeseries.ncl ncl_wrap.pro
  endif
endif

if ($PM_GENANN == 1) then
    echo "inside genann"
    gen_pop_annmean.csh $MSROOT $CASE $YEAR0 $YEAR1
endif


####################  Call analysis tools for plotting here
if ($DOPLOTS == 1) then

  if (-e idl_wrap.pro) then
    mv idl_wrap.pro tmp.pro
    echo "@$IDLPATH/pro/set_path" >> idl_wrap.pro
    cat tmp.pro >> idl_wrap.pro && \rm tmp.pro
    echo "exit" >> idl_wrap.pro
    idl idl_wrap.pro
    ls *.ps
    if ($status == 0) then 
      foreach i (*.ps)
        ps2gif $i $i.gif
        rename.pl '.ps' '' $i.gif
      end
#     \rm -f *.ps
    endif
  endif

  if (-e ncl_wrap.pro) then
    foreach i (`cat ncl_wrap.pro`)
      ncl $i
    end
    ls *.ps
    if ($status == 0) then 
      foreach i (*.ps)
        convert -trim -bordercolor white -border 5x5 -density 300 $i $i.gif
        rename.pl '.ps' '' $i.gif
      end
      \rm -f *.ps
    endif
  endif

  if (-e matlab_wrap.pro) then
    matlab matlab_wrap.pro
  endif

  if (-e fer_wrap.pro) then
    echo "exit" >> fer_wrap.pro
    ${FER_DIR}/bin/ferret -gif < fer_wrap.pro
  endif

endif

####################  Finish & transfer web page and plots
if ($DOWEB == 1) then
  if ($GLOSSARY == 1) cat ${HTMLPATH}/glossary.html >> popdiagts.html
  cat ${HTMLPATH}/footer.html >> popdiagts.html
#  scp popdiagts.html ${WEBMACH}:${WEBDIR2}
  if ($DOPLOTS == 1) then
#    scp *.asc *.gif *.png ${WEBMACH}:${WEBDIR2}
  endif
endif
mv popdiagts.html index.html
echo "DONE popdiagts.csh:  CASE = $CASE, YEAR0 = $YEAR0, YEAR1 = $YEAR1"
