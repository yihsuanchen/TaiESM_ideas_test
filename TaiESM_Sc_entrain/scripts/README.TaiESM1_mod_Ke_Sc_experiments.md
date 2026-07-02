README of TaiESM1 simulation experiments with modified entrainment flux
Yi-Hsuan Chen
June 9, 2026

# TaiESM1 simulation settings
Resolution: 0.9° latitude × 1.25° longitude, 30 vertical levels
present-day condition, AGCM (F2000) or coupled (B2000) simulations

# Control experiments
standard TaiESM1 setting

## f09.B2000.ft13
- 100-year coupled simulations (B2000)

## q1-taiesm1_CTL.F_2000_TAI.f09_f09.0330_1612
- 35-year AGCM simulations (F2000)

# Test experiments

Modify entrainment flux when the following two criteria are met: 

Criterion 1:
Above the cloud top, liquid static energy (sl) increases monotonically and total
water mixing ratio (qt) decreases monotonically, so the extrapolation is meaningful:
sl(kt−2) > sl(kt−1) > sl(kt) & qt(kt−2) < qt(kt−1) < qt(kt), kt is the vertical index of the top of the mixed layer. 
          
Criterion 2:
In order to avoid kvh_off < 0 or kvh_off > kvh_input, the extrapolated sl (qt) value at the PBL top
is between the value of a layer above and a layer below:
sl(kt), sl(kt-1) > sl_pblh > sl(kt) & qt(kt-1) < qt_pblh < qt(kt)

"PBL top height is deﬁned as the top external interface of surface-based CL [convective layer]". CL is defined where Ri<0.

****************
yhc, 2026-07-01
All q2-* exps have too warm land surface temperatures because the land model is "cold start". This issue is fixed in q3-* exps.
****************

# q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.B_2000_TAI.f09_g16.0516_0552
- modified entrainment flux when ql > 10-6 kg/kg & cloud fraction > 0.5 at the top of the mixed layer, regardless of on land or ocean.
- 35-year coupled simulations (B2000)

# q2-taiesm1_modified_Ke_Sc_top_sl_kt1_cldtop.F_2000_TAI.f09_f09.0514_1345
- Same settings as modified_Ke_Sc_top_sl_kt1_cldtop
- 35-year AGCM simulations (F2000)

# q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.B_2000_TAI.f09_g16.0422_1417
- modified entrainment flux for all types of boundary layer, regardless of clear sky or cloudy, and on land or ocean.  
- 35-year coupled simulations (B2000)

# q2-taiesm1_modified_Ke_Sc_top_sl_kt2_pbltop.F_2000_TAI.f09_f09.0410_1651
- Same settings as modified_Ke_Sc_top_sl_kt2_pbltop
- 35-year AGCM simulations (F2000)

# q2-taiesm1_modified_Ke_Sc_top_sl_kt3_cldtop_ocn.B_2000_TAI.f09_g16.0604_1108
- modified entrainment flux ONLY on ocean grids (land fraction < 0.5), when ql > 10-6 kg/kg & cloud fraction > 0.5 at the top of the mixed layer
- 5-year coupled simulations (B2000)

# q2-taiesm1_modified_Ke_Sc_top_sl_kt4_cldtop_SEP.B_2000_TAI.f09_g16.0610_1301
- Same as modified_Ke_Sc_top_sl_kt1_cldtop, but ONLY on Southeast Pacific marine Sc region (0-30S, 70W-100W)
- 5-year coupled simulations (B2000)

# Notes - features of the UW moist turbulence scheme
- An arbitrary number of turbulent layers are allowed. These layers can be either CL (Ri<0) or STL (0 < Ri < Ric = 0.19).
- No counter-gradient transport.
- Explicit entrainment closure. Entrainment can happen at CL top and bottom (for elevated CL).  
- Diffused variables: u, v, s, qv, ql, qi and tracers (CAM5), while q_t and s_l in Brethren and Park (2009).
- According to the CAM5 technical report, "PBL top height is deﬁned as the top external interface of surface-based CL".
- References
Bretherton, C. S., & Park, S. (2009). A new moist turbulence parameterization in the community atmosphere model. Journal of Climate, 22(12), 3422–3448. https://doi.org/10.1175/2008JCLI2556.1
Neale et al. (2012): Description of the NCAR CAM5.0, Section 4.2
 


