*****************************************************************
***     STATA code for construction of the final dataset      ***
*****************************************************************
******* BEFORE STARTING: *************
* 1. Set a WORKING DIRECTORY (folder) in line 11.
*    This folder should already exist on your computer.
*    The global defined in line 11 will ensure the code can access this folder on various code lines.
*    Type "help global" for details.
*****************************************************************

global path "working directory"
cd "$path"

// FDI //
use "$path\fdipanel.dta"
keep if year > 1996 & year < 2021

// GFCF //
merge 1:1 CountryCode sector year using "$path\gfcf_final.dta", nogenerate
* we have to drop Romania --> no FDI data available
drop if CountryCode == "RO"
* we have to drop Russia, Serbia, Kazakhstan, Ukraine and Croatia --> no GFCF data available
drop if CountryCode == "UA" | CountryCode == "RU" | CountryCode == "RS" | CountryCode == "HR" | CountryCode == "KZ"
* Exclude observations of financial sector --> not part of analysis
replace GFCFR1 = . if sector == 9
replace GFCFR2 = . if sector == 9

// GVA //
merge 1:1 CountryCode sector year using "$path\gvapanel.dta", nogenerate
* we have to drop countries omitted earlier --> Belarus, Croatia, Kazakhstan, Moldova, Montenegro, Romania, Serbia, Russia, Turkey, Ukraine, Kosovo, Yugoslavia
drop if CountryCode == "BY" | CountryCode == "HR" | CountryCode == "KZ" | CountryCode == "MD" | CountryCode == "ME" | CountryCode == "RO" | CountryCode == "RS" | CountryCode == "RU" | CountryCode == "TR" | CountryCode == "UA" | CountryCode == "XK" | CountryCode == "YO"

*GVA as denominator
gen gfcf1 = GFCFR1 / GVAR1
label var gfcf1 "GFCF share of GVA, NACE Rv.1 (incl. 'euro fixed' series)"
gen gfcf2 = GFCFR2 / GVAR2
label var gfcf2 "GFCF share of GVA, NACE Rv.2 (incl. 'euro fixed' series)"
gen fdi1 = fdi_inflowR1c / GVAR1
label var fdi1 "FDI share of GVA, NACE Rv.1 (incl. 'euro fixed' series)"
gen fdi2 = fdi_inflowR2c / GVAR2
label var fdi2 "FDI share of GVA, NACE Rv.2 (incl. 'euro fixed' series)"
drop GFCFR1 GFCFR2 fdi_inflowR1c GVAR1 

// FIN FDI // 
*Creating total Non-Financial sector GVA per country and year
gen GVARnfc = GVAR2
replace GVARnfc = . if sector == 9
egen nfcGVA = total(GVARnfc), by(country year) missing
replace nfcGVA = . if nfcGVA == 0

*Adding financial sector FDI
gen fin_fdi2b = fdi_inflowR2c
replace fin_fdi2b = . if sector != 9
bys country year: egen fin_fdi2 = max(fin_fdi2b)
drop fin_fdi2b GVARnfc GVAR2 fdi_inflowR2c

*dividing Financial sector FDI by total NFC GVA
gen fin_fdi = fin_fdi2/nfcGVA
label var fin_fdi "Financial sector FDI share of total Non-Financial sector GVA, NACE Rv.2 (incl. 'euro fixed' series)"
drop nfcGVA fin_fdi2
sort country year sector

// LEND1 // 
merge m:1 sector year using "$path\lendcoeff1.dta", nogenerate
order CountryCode country year sector gfcf1 gfcf2 fdi1 fdi2 lendcoeff_avg
sort country year sector

// LEND2 //
merge 1:1 CountryCode sector year using "$path\lendcoeff2.dta", nogenerate
order CountryCode country year sector gfcf1 gfcf2 fdi1 fdi2 lendcoeff_avg lendcoeff_gva
sort country year sector

// LEND3 //
decode sector, gen(industry)
drop sector
ren industry sector
order CountryCode country year sector
merge 1:1 CountryCode sector year using "$path\lendcoeff3.dta", force nogenerate
ren sector industry 
encode industry, gen(sector) 
drop industry
order CountryCode country year sector gfcf1 gfcf2 fdi1 fdi2 fin_fdi lendcoeff_avg lendcoeff_gva lendcoeff_IO
sort country year sector

// CONTROLS //
merge m:1 CountryCode year using "$path\controls.dta", force nogenerate
** for now not using NACE Rev.1
drop gfcf1 fdi1

// OMIT 2020 & SECTOR K IN 2005 ESTONIA //
drop if year == 2020
replace fin_fdi = . if fin_fdi > .18
order CountryCode country year sector gfcf2 fdi2 fin_fdi lendcoeff_avg lendcoeff_gva lendcoeff_IO
sort country year sector

// DROP ALBANIA, BOSNIA & HERZEGOVINA, NORTH MACEDONIA FROM IO LENDING MEASURE //
replace lendcoeff_IO = . if country == 1 | country == 2 | country == 12

save "$path\finaldata", replace




