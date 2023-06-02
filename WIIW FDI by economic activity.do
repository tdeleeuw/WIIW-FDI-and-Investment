*****************************************************************
*** STATA Replication Code for matching NACE Rev. 1 and Rev.2 ***
***         and convert to local currencies                   ***
***    (normalisation variable is also in local currency)     ***
*****************************************************************
******* BEFORE STARTING: *************
* 1. Set a WORKING DIRECTORY (folder) in line 13.
*    This folder should already exist on your computer.
*    The global defined in line 13 will ensure the code can access this folder on various code lines.
*    Type "help global" for details.
*****************************************************************

global path "working directory"
cd "$path\"

import excel "wiiw FDI by activities file.xlsx", sheet("Worksheet") cellrange(A6:AM9345) firstrow case(preserve)
* might have to change cellrange if updated

drop Footnotes Sources

// Assigns stub to varnames for reshaping //
foreach var of varlist J K L M N O P Q R S T U V W X Y Z A* {
    local label : variable label `var'
    if ("`label'" != "") {
        local oldnames `oldnames' `var'
        local newnames `newnames' yr`label'
    }
}

rename (`oldnames')(`newnames')

// we are interested only in the observations denoted in m€ as these can more easily be transformed. Therefore we exclude the variables measured as a % of the total //
keep if Unit == "EUR m"

// we will be using the NACE 1-letter classifications, alternatives are dropped //
keep if Digit == "NACE 1-letter"

// FDI inflows are of interest, otherwise adjust here //
keep if Direction == "FDI inflow"

// reshaping to long // 
encode Country, gen(country)
encode Classification, gen(classification)
encode IndustryProduct, gen(industry)
drop Country Classification IndustryProduct
reshape long yr, i(country classification industry) j(year)

ren yr fdi_inflow
label variable fdi_inflow "FDI Inflow in EUR m"
drop Direction Unit Digit
order CountryCode country classification industry year fdi_inflow

// removing the totals per country //
drop if industry == 42

// destring and removing dots placed as missing values //
destring fdi_inflow, replace

// temporary save //
save "$path\fdi_bothrevs.dta", replace




// first tackling the second revision of NACE //
keep if classification == 2

// dropping industries "Outflow from withdrawing non-resident investment" and "Private purchases & sales of real estate" data only available in one and four countries, respectively // we also drop sector "Activities of househ. as employers and for own use" as only Estonia records it and we have no counterpart for FDI inflows in Rev.1 // finally we drop "Other not elsewhere classified activities (A-U)" since we cannot know what this sector represents //
drop if industry == 34 | industry == 36 | industry == 41 | industry == 33

// making NACE letters consistent for Rev.2 //
reshape wide fdi_inflow, i(country year) j(industry)

egen fdi_inflow7 = rowtotal(fdi_inflow8 fdi_inflow11), missing
label variable fdi_inflow7 "sum industries D and E"

egen fdi_inflow14 = rowtotal(fdi_inflow15 fdi_inflow19), missing
label variable fdi_inflow14 "sum industries H and J"

egen fdi_inflow24 = rowtotal(fdi_inflow23 fdi_inflow26 fdi_inflow28), missing
label variable fdi_inflow24 "sum industries L, M and N"

egen fdi_inflow36 = rowtotal(fdi_inflow31 fdi_inflow35 fdi_inflow38 fdi_inflow39 fdi_inflow40 fdi_inflow43), missing
label variable fdi_inflow36 "sum industries O, P, Q, R, S and U"

drop fdi_inflow8 fdi_inflow11 fdi_inflow15 fdi_inflow19 fdi_inflow23 fdi_inflow26 fdi_inflow28 fdi_inflow31 fdi_inflow35 fdi_inflow38 fdi_inflow39 fdi_inflow40 fdi_inflow43

reshape long fdi_inflow, i(country year) j(industry)

// renaming so that names match changes //
decode industry, gen(Industry)

replace Industry = "D-E  Electricity, gas, water supply and other utilities" if Industry == "C  Mining and quarrying"
replace Industry = "H-J  Transportation, storage, information and communication" if Industry == "H  Hotels and restaurants"
replace Industry = "L-M-N  Real estate, professional, scientific and business activities" if Industry == "L-Q  Other services"
replace Industry = "O-P-Q-R-S-U  Other services" if Industry == "Private purchases & sales of real estate"


sort Industry
drop industry
encode Industry, gen(sector)
drop Industry classification
order CountryCode country sector year fdi_inflow
sort country year sector
rename fdi_inflow fdi_inflowR2

save "$path\fdirev2.dta", replace
clear




// Performing similar transformations for first revision //
use "$path\fdi_bothrevs.dta"

keep if classification == 1

// dropping industries "Outflow from withdrawing non-resident investment" and "Private purchases & sales of real estate" data only available in one and five countries, respectively // we also drop sector A-B, L-Q and M-N, because only a limited amount of countries kept track of these, we opt to compute A-B from the individual components instead // finally we drop "Other not elsewhere classified activities (A-Q)" since we cannot know what this sector represents //
drop if industry == 34 | industry == 36 | industry == 3 | industry == 27 | industry == 24 | industry == 32

// making NACE letters consistent for Rev.1 //
reshape wide fdi_inflow, i(country year) j(industry)

egen fdi_inflow3 = rowtotal(fdi_inflow2 fdi_inflow4), missing
label variable fdi_inflow3 "sum industries A and B"
egen fdi_inflow38 = rowtotal(fdi_inflow22 fdi_inflow25 fdi_inflow29 fdi_inflow30 fdi_inflow37), missing
label variable fdi_inflow38 "sum industries O, P, Q, R, S and U"

drop fdi_inflow2 fdi_inflow4 fdi_inflow22 fdi_inflow25 fdi_inflow29 fdi_inflow30 fdi_inflow37

reshape long fdi_inflow, i(country year) j(industry)

// renaming so that names match changes //
decode industry, gen(Industry)

replace Industry = "A  Agriculture, forestry and fishing" if Industry == "A-B  Agriculture, hunting, forestry, fishing"
replace Industry = "B  Mining and quarrying" if Industry == "C  Mining and quarrying"
replace Industry = "C  Manufacturing" if Industry == "D  Manufacturing"
replace Industry = "D-E  Electricity, gas, water supply and other utilities" if Industry == "E  Electricity, gas and water supply"
replace Industry = "I  Accommodation and food service activities" if Industry == "H  Hotels and restaurants"
replace Industry = "H-J  Transportation, storage, information and communication" if Industry == "I  Transport, storage and communication"
replace Industry = "K  Financial and insurance activities" if Industry == "J  Financial intermediation"
replace Industry = "L-M-N  Real estate, professional, scientific and business activities" if Industry == "K  Real estate, renting and business activities"
replace Industry = "O-P-Q-R-S-U  Other services" if Industry == "Q  Human health and social work activities"

sort Industry
drop industry
encode Industry, gen(sector)
drop Industry classification
order CountryCode country sector year fdi_inflow
sort country sector year

rename fdi_inflow fdi_inflowR1

save "$path\fdirev1.dta", replace
clear




// merging the two adjusted revisions into one dataset //
use "$path\fdirev2.dta"
merge 1:1 country sector year using "$path\fdirev1.dta", nogenerate
save "$path\fdipanelnoconvert.dta", replace
clear



// currency conversion //
import excel "eurncu_conv.xlsx", sheet("Sheet 1") cellrange(A9:AD21) firstrow case(preserve)

drop in 1
destring B C D E F G H, replace force

foreach var of varlist B C D E F G H I J K L M N O P Q R S T U V W X Y Z A* {
    local label : variable label `var'
    if ("`label'" != "") {
        local oldnames `oldnames' `var'
        local newnames `newnames' yr`label'
    }
}

rename (`oldnames')(`newnames')

rename TIME CountryCode
reshape long yr, i(CountryCode) j(year)
rename yr xr

replace CountryCode = "AL" if CountryCode == "Albanian lek"
replace CountryCode = "BA" if CountryCode == "Bosnia and Herzegovina convertible mark"
replace CountryCode = "BG" if CountryCode == "Bulgarian lev"
replace CountryCode = "CZ" if CountryCode == "Czech koruna"
replace CountryCode = "HU" if CountryCode == "Hungarian forint"
replace CountryCode = "KZ" if CountryCode == "Kazakhstan tenge"
replace CountryCode = "MK" if CountryCode == "North Macedonian denar"
replace CountryCode = "PL" if CountryCode == "Polish zloty"
replace CountryCode = "RU" if CountryCode == "Russian rouble"
replace CountryCode = "RS" if CountryCode == "Serbian dinar"
replace CountryCode = "UA" if CountryCode == "Ukraine hryvnia"
save "$path\eurncu_conv.dta", replace
clear

use "$path\fdipanelnoconvert.dta"
merge m:1 CountryCode year using "$path\eurncu_conv.dta", nogenerate
* assign 1 to xr for euro fixed series countries
replace xr = 1 if country == 6 | country == 4 | country == 11 | country == 10 | country == 17 | country == 16
gen fdi_inflowR2c = fdi_inflowR2 * xr
gen fdi_inflowR1c = fdi_inflowR1 * xr
label var fdi_inflowR2c "FDI inflows in NCU m"
label var fdi_inflowR1c "FDI inflows in NCU m"
drop fdi_inflowR1 fdi_inflowR2 xr 

// We have to drop Kosovo as the currency conversion is arduous and little data is available for the country anyway //
drop if country == 9

save "$path\fdipanel.dta", replace



