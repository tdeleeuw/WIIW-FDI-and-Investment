*****************************************************************
*** STATA Replication Code for matching NACE Rev. 1 and Rev.2 ***
*****************************************************************
******* BEFORE STARTING: *************
* 1. Set a WORKING DIRECTORY (folder) in line 11.
*    This folder should already exist on your computer.
*    The global defined in line 11 will ensure the code can access this folder on various code lines.
*    Type "help global" for details.
*****************************************************************

global path "working directory"
cd "$path"

import excel "wiiw GFCF by activities file.xlsx", sheet("Worksheet") cellrange(A7:AM1189) firstrow case(preserve)
* might have to change cellrange if updated

drop Digit IndustryProductCode Footnotes Sources

// Assigns stub to varnames for reshaping //
foreach var of varlist J K L M N O P Q R S T U V W X Y Z A* {
    local label : variable label `var'
    if ("`label'" != "") {
        local oldnames `oldnames' `var'
        local newnames `newnames' yr`label'
    }
}

rename (`oldnames')(`newnames')

// we are interested only in the observations denoted in NCU m as these can more easily be transformed than shares. On top of that, NCU m is available for all countries, as opposed to 2015 reference prices //
keep if Unit == "NCU m (incl. 'euro fixed' series)"

// Removing the totals per country //
drop if IndustryProduct == "Total by activities"

// destring and removing dots placed as missing values //
destring yr*, replace

// Reshaping to long // 
encode Country, gen(country)
encode Classification, gen(classification)
encode IndustryProduct, gen(industry)
drop Country Classification IndustryProduct
reshape long yr, i(country classification industry) j(year)

ren yr GFCF
label variable GFCF "GFCF in NCU m (incl. 'euro fixed' series)"
drop Unit
order CountryCode country classification industry year GFCF

// Temporary save including both NACE revisions //
save "$path\gfcf_bothrevs", replace




// first tackling the second revision //
keep if classification == 2

// making NACE letters consistent for Rev.2 //
reshape wide GFCF, i(country year) j(industry)

egen GFCF7 = rowtotal(GFCF8 GFCF11), missing
label variable GFCF7 "sum industries D and E"

egen GFCF14 = rowtotal(GFCF15 GFCF19), missing
label variable GFCF14 "sum industries H and J"

egen GFCF24 = rowtotal(GFCF23 GFCF25 GFCF26), missing
label variable GFCF24 "sum industries L, M and N"

egen GFCF34 = rowtotal(GFCF29 GFCF30 GFCF31 GFCF32 GFCF33), missing
label variable GFCF34 "sum industries O, P, Q, R, S and U"

drop GFCF8 GFCF11 GFCF15 GFCF19 GFCF23 GFCF25 GFCF26 GFCF29 GFCF30 GFCF31 GFCF32 GFCF33

reshape long GFCF, i(country year) j(industry)


// renaming so that names match changes //
decode industry, gen(Industry)

replace Industry = "D-E  Electricity, gas, water supply and other utilities" if Industry == "C  Mining and quarrying"
replace Industry = "H-J  Transportation, storage, information and communication" if Industry == "H  Hotels and restaurants"
replace Industry = "L-M-N  Real estate, professional, scientific and business activities" if Industry == "M  Education"
replace Industry = "O-P-Q-R-S-U  Other services" if Industry == ""

sort Industry
drop industry
encode Industry, gen(sector)
drop Industry classification
order CountryCode country sector year GFCF
sort country year sector
rename GFCF GFCFR2

save "$path\gfcf_rev2", replace
clear


// Performing similar transformations for first revision //
use "$path\gfcf_bothrevs.dta"

keep if classification == 1

// we drop sector A-B, because only a limited amount of countries kept track of these, we opt to compute A-B from the individual components instead //
drop if industry == 3

// making NACE letters consistent for Rev.1 //
reshape wide GFCF, i(country year) j(industry)

egen GFCF3 = rowtotal(GFCF2 GFCF4), missing
label variable GFCF3 "sum industries A and B"
egen GFCF222 = rowtotal(GFCF22 GFCF24 GFCF27 GFCF28), missing
label variable GFCF222 "sum industries O, P, Q, R, S and U"

drop GFCF2 GFCF4 GFCF22 GFCF24 GFCF27 GFCF28

reshape long GFCF, i(country year) j(industry)

// renaming so that names match changes //
decode industry, gen(Industry)

replace Industry = "A  Agriculture, forestry and fishing" if Industry == "A-B  Agriculture, hunting, forestry, fishing"
replace Industry = "B  Mining and quarrying" if Industry == "C  Mining and quarrying"
replace Industry = "C  Manufacturing" if Industry == "D  Manufacturing"
replace Industry = "D-E  Electricity, gas, water supply and other utilities" if Industry == "E  Electricity, gas and water supply"
replace Industry = "H-J  Transportation, storage, information and communication" if Industry == "I  Transport, storage and communication"
replace Industry = "I  Hotels and restaurants" if Industry == "H  Hotels and restaurants"
replace Industry = "K  Financial and insurance activities" if Industry == "J  Financial intermediation"
replace Industry = "L-M-N  Real estate, professional, scientific and business activities" if Industry == "K  Real estate, renting and business activities"
replace Industry = "O-P-Q-R-S-U  Other services" if Industry == ""

sort Industry
drop industry
encode Industry, gen(sector)
drop Industry classification
order CountryCode country sector year GFCF
sort country year sector
rename GFCF GFCFR1

save "$path\gfcf_rev1.dta", replace
clear


// merging the two adjusted revisions into one dataset //
use "$path\gfcf_rev2.dta" 
merge 1:1 country sector year using "$path\gfcf_rev1.dta", nogenerate
keep if year > 1996 & year < 2021

save "$path\gfcf_final.dta", replace










