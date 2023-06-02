*****************************************************************
*** STATA Replication Code for matching NACE Rev. 1 and Rev.2 ***
***           (This is the normalisation variable)            ***
*****************************************************************
******* BEFORE STARTING: *************
* 1. Set a WORKING DIRECTORY (folder) in line 13.
*    This folder should already exist on your computer.
*    The global defined in line 13 will ensure the code can access this folder on various code lines.
*    Type "help global" for details.
*****************************************************************

global path "working directory"
cd "$path"

import excel "wiiw GVA by activities file.xlsx", sheet("Worksheet") cellrange(A7:BS2797) firstrow case(preserve)
* might have to change cellrange if updated

drop Digit IndustryProductCode Footnotes Sources

// Assigns stub to varnames for reshaping //
foreach var of varlist J K L M N O P Q R S T U V W X Y Z A* B* {
    local label : variable label `var'
    if ("`label'" != "") {
        local oldnames `oldnames' `var'
        local newnames `newnames' yr`label'
    }
}

rename (`oldnames')(`newnames')

// we are interested only in the observations denoted in NCU m, since the GVA values will be used as the denominator for our GFCF and FDI variables //
keep if Unit == "NCU m (incl. 'euro fixed' series)"

// destring and removing dots placed as missing values //
destring yr*, replace

// not interested in classifications other than NACE //
drop if Classification == "Other classification"

// Reshaping to long // 
encode Country, gen(country)
encode Classification, gen(classification)
encode IndustryProduct, gen(industry)
drop Country Classification IndustryProduct
reshape long yr, i(country classification industry) j(year)

ren yr GVA
label variable GVA "GVA in NCU m (incl. 'euro fixed' series)"
drop Unit
order CountryCode country classification industry year GVA

// Temporary save including both NACE revisions //
save "$path\gva_bothrevs.dta", replace


// first tackling the second revision //
keep if classification == 2

// making NACE letters consistent for Rev.2 --> not interested in industry T (households) nor gross value added at basic prices //
drop if industry == 40 | industry == 15
reshape wide GVA, i(country year) j(industry)

egen GVA7 = rowtotal(GVA9 GVA12), missing
label variable GVA7 "sum industries D and E"

egen GVA15 = rowtotal(GVA17 GVA22), missing
label variable GVA15 "sum industries H and J"

egen GVA24 = rowtotal(GVA26 GVA28 GVA29), missing
label variable GVA24 "sum industries L, M and N"

egen GVA35 = rowtotal(GVA32 GVA34 GVA37 GVA38 GVA39), missing
label variable GVA35 "sum industries O, P, Q, R, S and U"

drop GVA9 GVA12 GVA17 GVA22 GVA26 GVA28 GVA29 GVA32 GVA34 GVA37 GVA38 GVA39
keep if year > 1996 & year < 2021
reshape long GVA, i(country year) j(industry)

// renaming so that names match changes //
decode industry, gen(Industry)

replace Industry = "D-E  Electricity, gas, water supply and other utilities" if Industry == "C  Mining and quarrying"
replace Industry = "H-J  Transportation, storage, information and communication" if Industry == "Gross value added at basic prices"
replace Industry = "L-M-N  Real estate, professional, scientific and business activities" if Industry == "K  Real estate, renting and business activities"
replace Industry = "O-P-Q-R-S-U  Other services" if Industry == "P  Private households with employed persons"

sort Industry
drop industry
encode Industry, gen(sector)
drop Industry classification
order CountryCode country sector year GVA
sort country year sector
rename GVA GVAR2

save "$path\gva_rev2.dta", replace
clear


// Performing similar transformations for first revision //
use "$path\gva_bothrevs.dta"

keep if classification == 1

// we drop sector A-B, because only a limited amount of countries kept track of these, we opt to compute A-B from the individual components instead, same counts for C-E Total Industry. Other unnecessary sectors are dropped too //
drop if industry == 3 | industry == 8 | industry == 15 | industry == 20 | industry == 33 | industry == 35 | industry == 36
reshape wide GVA, i(country year) j(industry)

egen GVA3 = rowtotal(GVA2 GVA4), missing
label variable GVA3 "sum industries A and B"

egen GVA38 = rowtotal(GVA25 GVA27 GVA30 GVA31), missing
label variable GVA38 "sum industries O, P, Q, R, S and U"

drop GVA2 GVA4 GVA25 GVA27 GVA30 GVA31
keep if year > 1996 & year < 2021
reshape long GVA, i(country year) j(industry)

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
replace Industry = "O-P-Q-R-S-U  Other services" if Industry == "R  Arts, entertainment and recreation"

sort Industry
drop industry
encode Industry, gen(sector)
drop Industry classification
order CountryCode country sector year GVA
sort country year sector
rename GVA GVAR1

save "$path\gva_rev1.dta", replace
clear

// merging the two adjusted revisions into one dataset //
use "$path\gva_rev2.dta"
merge 1:1 CountryCode sector year using "$path\gva_rev1.dta", nogenerate
save gvapanel.dta, replace
clear














