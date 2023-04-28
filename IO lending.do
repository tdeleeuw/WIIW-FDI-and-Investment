cd "C:\Users\Startklaar\Desktop\Studies\MSc - Economic Development & Globalisation\Thesis\Lending data"

// BULGARIA //
import excel "BGR_NIOT_nov16", sheet(National IO-tables) firstrow case(preserve)

**Selecting the right sector-pairs
drop in 1
drop K* T U CONS* GFCF INVEN EXP GO Description
destring A* B C* D35 E* F G* H* I J* L68 M* N O84 P85 Q R_S, replace
keep if Origin == "Domestic"
keep if Code == "K64"
drop Code Origin

**Matching the IO sectors to the ones in the FDI and GFCF measures
egen IND1 = rowtotal(A*), missing
drop A*
label variable IND1 "Industry A"
egen IND2 = rowtotal(B), missing
drop B
label variable IND2 "Industry B"
egen IND3 = rowtotal(C*), missing
drop C*
label variable IND3 "Industry C"
egen IND4 = rowtotal(D* E*), missing
drop D* E*
label variable IND4 "sum industries D and E"
egen IND5 = rowtotal(F*), missing
drop F*
label variable IND5 "Industry F"
egen IND6 = rowtotal(G*), missing
drop G*
label variable IND6 "Industry G"
egen IND7 = rowtotal(H* J*), missing
drop H* J*
label variable IND7 "sum industries H and J"
egen IND8 = rowtotal(I), missing
drop I
label variable IND8 "Industry I"
egen IND9 = rowtotal(L* M* N*), missing
drop L* M* N*
label variable IND9 "sum industries L, M and N"
egen IND10 = rowtotal(O* P* Q* R*), missing
drop O* P* Q* R*
label variable IND10 "sum industries O, P, Q, R, S and U"

reshape long IND, i(Year) j(industry)
tostring industry, replace
replace industry = "A  Agriculture, forestry and fishing" if industry == "1"
replace industry = "B  Mining and quarrying" if industry == "2"
replace industry = "C  Manufacturing" if industry == "3"
replace industry = "D-E  Electricity, gas, water supply and other utilities" if industry == "4"
replace industry = "F  Construction" if industry == "5"
replace industry = "G  Wholesale, retail trade, repair of motor vehicles etc." if industry == "6"
replace industry = "H-J  Transportation, storage, information and communication" if industry == "7"
replace industry = "I  Accommodation and food service activities" if industry == "8"
replace industry = "L-M-N  Real estate, professional, scientific and business activities" if industry == "9"
replace industry = "O-P-Q-R-S-U  Other services" if industry == "10"
ren IND lendcoeff_IO
gen foravg1 = lendcoeff_IO

gen CountryCode = "BG"
gen country = "Bulgaria"
order CountryCode country industry Year lendcoeff_IO
sort country Year industry
save lend_BG, replace
clear

// CZECHIA //
import excel "CZE_NIOT_nov16", sheet(National IO-tables) firstrow case(preserve)

drop in 1
drop K* T U CONS* GFCF INVEN EXP GO Description
destring A* B C* D35 E* F G* H* I J* L68 M* N O84 P85 Q R_S, replace
keep if Origin == "Domestic"
keep if Code == "K64"
drop Code Origin

egen IND1 = rowtotal(A*), missing
drop A*
label variable IND1 "Industry A"
egen IND2 = rowtotal(B), missing
drop B
label variable IND2 "Industry B"
egen IND3 = rowtotal(C*), missing
drop C*
label variable IND3 "Industry C"
egen IND4 = rowtotal(D* E*), missing
drop D* E*
label variable IND4 "sum industries D and E"
egen IND5 = rowtotal(F*), missing
drop F*
label variable IND5 "Industry F"
egen IND6 = rowtotal(G*), missing
drop G*
label variable IND6 "Industry G"
egen IND7 = rowtotal(H* J*), missing
drop H* J*
label variable IND7 "sum industries H and J"
egen IND8 = rowtotal(I), missing
drop I
label variable IND8 "Industry I"
egen IND9 = rowtotal(L* M* N*), missing
drop L* M* N*
label variable IND9 "sum industries L, M and N"
egen IND10 = rowtotal(O* P* Q* R*), missing
drop O* P* Q* R*
label variable IND10 "sum industries O, P, Q, R, S and U"

reshape long IND, i(Year) j(industry)
tostring industry, replace
replace industry = "A  Agriculture, forestry and fishing" if industry == "1"
replace industry = "B  Mining and quarrying" if industry == "2"
replace industry = "C  Manufacturing" if industry == "3"
replace industry = "D-E  Electricity, gas, water supply and other utilities" if industry == "4"
replace industry = "F  Construction" if industry == "5"
replace industry = "G  Wholesale, retail trade, repair of motor vehicles etc." if industry == "6"
replace industry = "H-J  Transportation, storage, information and communication" if industry == "7"
replace industry = "I  Accommodation and food service activities" if industry == "8"
replace industry = "L-M-N  Real estate, professional, scientific and business activities" if industry == "9"
replace industry = "O-P-Q-R-S-U  Other services" if industry == "10"
ren IND lendcoeff_IO
gen foravg2 = lendcoeff_IO

gen CountryCode = "CZ"
gen country = "Czechia"
order CountryCode country industry Year lendcoeff_IO
sort country Year industry
save lend_CZ, replace
clear

// ESTONIA //
import excel "EST_NIOT_nov16", sheet(National IO-tables) firstrow case(preserve)

drop in 1
drop K* T U CONS* GFCF INVEN EXP GO Description
destring A* B C* D35 E* F G* H* I J* L68 M* N O84 P85 Q R_S, replace
keep if Origin == "Domestic"
keep if Code == "K64"
drop Code Origin

egen IND1 = rowtotal(A*), missing
drop A*
label variable IND1 "Industry A"
egen IND2 = rowtotal(B), missing
drop B
label variable IND2 "Industry B"
egen IND3 = rowtotal(C*), missing
drop C*
label variable IND3 "Industry C"
egen IND4 = rowtotal(D* E*), missing
drop D* E*
label variable IND4 "sum industries D and E"
egen IND5 = rowtotal(F*), missing
drop F*
label variable IND5 "Industry F"
egen IND6 = rowtotal(G*), missing
drop G*
label variable IND6 "Industry G"
egen IND7 = rowtotal(H* J*), missing
drop H* J*
label variable IND7 "sum industries H and J"
egen IND8 = rowtotal(I), missing
drop I
label variable IND8 "Industry I"
egen IND9 = rowtotal(L* M* N*), missing
drop L* M* N*
label variable IND9 "sum industries L, M and N"
egen IND10 = rowtotal(O* P* Q* R*), missing
drop O* P* Q* R*
label variable IND10 "sum industries O, P, Q, R, S and U"

reshape long IND, i(Year) j(industry)
tostring industry, replace
replace industry = "A  Agriculture, forestry and fishing" if industry == "1"
replace industry = "B  Mining and quarrying" if industry == "2"
replace industry = "C  Manufacturing" if industry == "3"
replace industry = "D-E  Electricity, gas, water supply and other utilities" if industry == "4"
replace industry = "F  Construction" if industry == "5"
replace industry = "G  Wholesale, retail trade, repair of motor vehicles etc." if industry == "6"
replace industry = "H-J  Transportation, storage, information and communication" if industry == "7"
replace industry = "I  Accommodation and food service activities" if industry == "8"
replace industry = "L-M-N  Real estate, professional, scientific and business activities" if industry == "9"
replace industry = "O-P-Q-R-S-U  Other services" if industry == "10"
ren IND lendcoeff_IO
gen foravg3 = lendcoeff_IO

gen CountryCode = "EE"
gen country = "Estonia"
order CountryCode country industry Year lendcoeff_IO
sort country Year industry
save lend_EE, replace
clear

// HUNGARY //
import excel "HUN_NIOT_nov16", sheet(National IO-tables) firstrow case(preserve)

drop in 1
drop K* T U CONS* GFCF INVEN EXP GO Description
destring A* B C* D35 E* F G* H* I J* L68 M* N O84 P85 Q R_S, replace
keep if Origin == "Domestic"
keep if Code == "K64"
drop Code Origin

egen IND1 = rowtotal(A*), missing
drop A*
label variable IND1 "Industry A"
egen IND2 = rowtotal(B), missing
drop B
label variable IND2 "Industry B"
egen IND3 = rowtotal(C*), missing
drop C*
label variable IND3 "Industry C"
egen IND4 = rowtotal(D* E*), missing
drop D* E*
label variable IND4 "sum industries D and E"
egen IND5 = rowtotal(F*), missing
drop F*
label variable IND5 "Industry F"
egen IND6 = rowtotal(G*), missing
drop G*
label variable IND6 "Industry G"
egen IND7 = rowtotal(H* J*), missing
drop H* J*
label variable IND7 "sum industries H and J"
egen IND8 = rowtotal(I), missing
drop I
label variable IND8 "Industry I"
egen IND9 = rowtotal(L* M* N*), missing
drop L* M* N*
label variable IND9 "sum industries L, M and N"
egen IND10 = rowtotal(O* P* Q* R*), missing
drop O* P* Q* R*
label variable IND10 "sum industries O, P, Q, R, S and U"

reshape long IND, i(Year) j(industry)
tostring industry, replace
replace industry = "A  Agriculture, forestry and fishing" if industry == "1"
replace industry = "B  Mining and quarrying" if industry == "2"
replace industry = "C  Manufacturing" if industry == "3"
replace industry = "D-E  Electricity, gas, water supply and other utilities" if industry == "4"
replace industry = "F  Construction" if industry == "5"
replace industry = "G  Wholesale, retail trade, repair of motor vehicles etc." if industry == "6"
replace industry = "H-J  Transportation, storage, information and communication" if industry == "7"
replace industry = "I  Accommodation and food service activities" if industry == "8"
replace industry = "L-M-N  Real estate, professional, scientific and business activities" if industry == "9"
replace industry = "O-P-Q-R-S-U  Other services" if industry == "10"
ren IND lendcoeff_IO
gen foravg4 = lendcoeff_IO

gen CountryCode = "HU"
gen country = "Hungary"
order CountryCode country industry Year lendcoeff_IO
sort country Year industry
save lend_HU, replace
clear

// LITHUANIA //
import excel "LTU_NIOT_nov16", sheet(National IO-tables) firstrow case(preserve)

drop in 1
drop K* T U CONS* GFCF INVEN EXP GO Description
destring A* B C* D35 E* F G* H* I J* L68 M* N O84 P85 Q R_S, replace
keep if Origin == "Domestic"
keep if Code == "K64"
drop Code Origin

egen IND1 = rowtotal(A*), missing
drop A*
label variable IND1 "Industry A"
egen IND2 = rowtotal(B), missing
drop B
label variable IND2 "Industry B"
egen IND3 = rowtotal(C*), missing
drop C*
label variable IND3 "Industry C"
egen IND4 = rowtotal(D* E*), missing
drop D* E*
label variable IND4 "sum industries D and E"
egen IND5 = rowtotal(F*), missing
drop F*
label variable IND5 "Industry F"
egen IND6 = rowtotal(G*), missing
drop G*
label variable IND6 "Industry G"
egen IND7 = rowtotal(H* J*), missing
drop H* J*
label variable IND7 "sum industries H and J"
egen IND8 = rowtotal(I), missing
drop I
label variable IND8 "Industry I"
egen IND9 = rowtotal(L* M* N*), missing
drop L* M* N*
label variable IND9 "sum industries L, M and N"
egen IND10 = rowtotal(O* P* Q* R*), missing
drop O* P* Q* R*
label variable IND10 "sum industries O, P, Q, R, S and U"

reshape long IND, i(Year) j(industry)
tostring industry, replace
replace industry = "A  Agriculture, forestry and fishing" if industry == "1"
replace industry = "B  Mining and quarrying" if industry == "2"
replace industry = "C  Manufacturing" if industry == "3"
replace industry = "D-E  Electricity, gas, water supply and other utilities" if industry == "4"
replace industry = "F  Construction" if industry == "5"
replace industry = "G  Wholesale, retail trade, repair of motor vehicles etc." if industry == "6"
replace industry = "H-J  Transportation, storage, information and communication" if industry == "7"
replace industry = "I  Accommodation and food service activities" if industry == "8"
replace industry = "L-M-N  Real estate, professional, scientific and business activities" if industry == "9"
replace industry = "O-P-Q-R-S-U  Other services" if industry == "10"
ren IND lendcoeff_IO
gen foravg5 = lendcoeff_IO

gen CountryCode = "LT"
gen country = "Lithuania"
order CountryCode country industry Year lendcoeff_IO
sort country Year industry
save lend_LT, replace
clear

// LATVIA //
import excel "LVA_NIOT_nov16", sheet(National IO-tables) firstrow case(preserve)

drop in 1
drop K* T U CONS* GFCF INVEN EXP GO Description
destring A* B C* D35 E* F G* H* I J* L68 M* N O84 P85 Q R_S, replace
keep if Origin == "Domestic"
keep if Code == "K64"
drop Code Origin

egen IND1 = rowtotal(A*), missing
drop A*
label variable IND1 "Industry A"
egen IND2 = rowtotal(B), missing
drop B
label variable IND2 "Industry B"
egen IND3 = rowtotal(C*), missing
drop C*
label variable IND3 "Industry C"
egen IND4 = rowtotal(D* E*), missing
drop D* E*
label variable IND4 "sum industries D and E"
egen IND5 = rowtotal(F*), missing
drop F*
label variable IND5 "Industry F"
egen IND6 = rowtotal(G*), missing
drop G*
label variable IND6 "Industry G"
egen IND7 = rowtotal(H* J*), missing
drop H* J*
label variable IND7 "sum industries H and J"
egen IND8 = rowtotal(I), missing
drop I
label variable IND8 "Industry I"
egen IND9 = rowtotal(L* M* N*), missing
drop L* M* N*
label variable IND9 "sum industries L, M and N"
egen IND10 = rowtotal(O* P* Q* R*), missing
drop O* P* Q* R*
label variable IND10 "sum industries O, P, Q, R, S and U"

reshape long IND, i(Year) j(industry)
tostring industry, replace
replace industry = "A  Agriculture, forestry and fishing" if industry == "1"
replace industry = "B  Mining and quarrying" if industry == "2"
replace industry = "C  Manufacturing" if industry == "3"
replace industry = "D-E  Electricity, gas, water supply and other utilities" if industry == "4"
replace industry = "F  Construction" if industry == "5"
replace industry = "G  Wholesale, retail trade, repair of motor vehicles etc." if industry == "6"
replace industry = "H-J  Transportation, storage, information and communication" if industry == "7"
replace industry = "I  Accommodation and food service activities" if industry == "8"
replace industry = "L-M-N  Real estate, professional, scientific and business activities" if industry == "9"
replace industry = "O-P-Q-R-S-U  Other services" if industry == "10"
ren IND lendcoeff_IO
gen foravg6 = lendcoeff_IO

gen CountryCode = "LV"
gen country = "Latvia"
order CountryCode country industry Year lendcoeff_IO
sort country Year industry
save lend_LV, replace
clear

// POLAND //
import excel "POL_NIOT_nov16", sheet(National IO-tables) firstrow case(preserve)

drop in 1
drop K* T U CONS* GFCF INVEN EXP GO Description
destring A* B C* D35 E* F G* H* I J* L68 M* N O84 P85 Q R_S, replace
keep if Origin == "Domestic"
keep if Code == "K64"
drop Code Origin

egen IND1 = rowtotal(A*), missing
drop A*
label variable IND1 "Industry A"
egen IND2 = rowtotal(B), missing
drop B
label variable IND2 "Industry B"
egen IND3 = rowtotal(C*), missing
drop C*
label variable IND3 "Industry C"
egen IND4 = rowtotal(D* E*), missing
drop D* E*
label variable IND4 "sum industries D and E"
egen IND5 = rowtotal(F*), missing
drop F*
label variable IND5 "Industry F"
egen IND6 = rowtotal(G*), missing
drop G*
label variable IND6 "Industry G"
egen IND7 = rowtotal(H* J*), missing
drop H* J*
label variable IND7 "sum industries H and J"
egen IND8 = rowtotal(I), missing
drop I
label variable IND8 "Industry I"
egen IND9 = rowtotal(L* M* N*), missing
drop L* M* N*
label variable IND9 "sum industries L, M and N"
egen IND10 = rowtotal(O* P* Q* R*), missing
drop O* P* Q* R*
label variable IND10 "sum industries O, P, Q, R, S and U"

reshape long IND, i(Year) j(industry)
tostring industry, replace
replace industry = "A  Agriculture, forestry and fishing" if industry == "1"
replace industry = "B  Mining and quarrying" if industry == "2"
replace industry = "C  Manufacturing" if industry == "3"
replace industry = "D-E  Electricity, gas, water supply and other utilities" if industry == "4"
replace industry = "F  Construction" if industry == "5"
replace industry = "G  Wholesale, retail trade, repair of motor vehicles etc." if industry == "6"
replace industry = "H-J  Transportation, storage, information and communication" if industry == "7"
replace industry = "I  Accommodation and food service activities" if industry == "8"
replace industry = "L-M-N  Real estate, professional, scientific and business activities" if industry == "9"
replace industry = "O-P-Q-R-S-U  Other services" if industry == "10"
ren IND lendcoeff_IO
gen foravg7 = lendcoeff_IO

gen CountryCode = "PL"
gen country = "Poland"
order CountryCode country industry Year lendcoeff_IO
sort country Year industry
save lend_PL, replace
clear

// SLOVAKIA //
import excel "SVK_NIOT_nov16", sheet(National IO-tables) firstrow case(preserve)

drop in 1
drop K* T U CONS* GFCF INVEN EXP GO Description
destring A* B C* D35 E* F G* H* I J* L68 M* N O84 P85 Q R_S, replace
keep if Origin == "Domestic"
keep if Code == "K64"
drop Code Origin

egen IND1 = rowtotal(A*), missing
drop A*
label variable IND1 "Industry A"
egen IND2 = rowtotal(B), missing
drop B
label variable IND2 "Industry B"
egen IND3 = rowtotal(C*), missing
drop C*
label variable IND3 "Industry C"
egen IND4 = rowtotal(D* E*), missing
drop D* E*
label variable IND4 "sum industries D and E"
egen IND5 = rowtotal(F*), missing
drop F*
label variable IND5 "Industry F"
egen IND6 = rowtotal(G*), missing
drop G*
label variable IND6 "Industry G"
egen IND7 = rowtotal(H* J*), missing
drop H* J*
label variable IND7 "sum industries H and J"
egen IND8 = rowtotal(I), missing
drop I
label variable IND8 "Industry I"
egen IND9 = rowtotal(L* M* N*), missing
drop L* M* N*
label variable IND9 "sum industries L, M and N"
egen IND10 = rowtotal(O* P* Q* R*), missing
drop O* P* Q* R*
label variable IND10 "sum industries O, P, Q, R, S and U"

reshape long IND, i(Year) j(industry)
tostring industry, replace
replace industry = "A  Agriculture, forestry and fishing" if industry == "1"
replace industry = "B  Mining and quarrying" if industry == "2"
replace industry = "C  Manufacturing" if industry == "3"
replace industry = "D-E  Electricity, gas, water supply and other utilities" if industry == "4"
replace industry = "F  Construction" if industry == "5"
replace industry = "G  Wholesale, retail trade, repair of motor vehicles etc." if industry == "6"
replace industry = "H-J  Transportation, storage, information and communication" if industry == "7"
replace industry = "I  Accommodation and food service activities" if industry == "8"
replace industry = "L-M-N  Real estate, professional, scientific and business activities" if industry == "9"
replace industry = "O-P-Q-R-S-U  Other services" if industry == "10"
ren IND lendcoeff_IO
gen foravg8 = lendcoeff_IO

gen CountryCode = "SK"
gen country = "Slovakia"
order CountryCode country industry Year lendcoeff_IO
sort country Year industry
save lend_SK, replace
clear

// SLOVENIA //
import excel "SVN_NIOT_nov16", sheet(National IO-tables) firstrow case(preserve)

drop in 1
drop K* T U CONS* GFCF INVEN EXP GO Description
destring A* B C* D35 E* F G* H* I J* L68 M* N O84 P85 Q R_S, replace
keep if Origin == "Domestic"
keep if Code == "K64"
drop Code Origin

egen IND1 = rowtotal(A*), missing
drop A*
label variable IND1 "Industry A"
egen IND2 = rowtotal(B), missing
drop B
label variable IND2 "Industry B"
egen IND3 = rowtotal(C*), missing
drop C*
label variable IND3 "Industry C"
egen IND4 = rowtotal(D* E*), missing
drop D* E*
label variable IND4 "sum industries D and E"
egen IND5 = rowtotal(F*), missing
drop F*
label variable IND5 "Industry F"
egen IND6 = rowtotal(G*), missing
drop G*
label variable IND6 "Industry G"
egen IND7 = rowtotal(H* J*), missing
drop H* J*
label variable IND7 "sum industries H and J"
egen IND8 = rowtotal(I), missing
drop I
label variable IND8 "Industry I"
egen IND9 = rowtotal(L* M* N*), missing
drop L* M* N*
label variable IND9 "sum industries L, M and N"
egen IND10 = rowtotal(O* P* Q* R*), missing
drop O* P* Q* R*
label variable IND10 "sum industries O, P, Q, R, S and U"

reshape long IND, i(Year) j(industry)
tostring industry, replace
replace industry = "A  Agriculture, forestry and fishing" if industry == "1"
replace industry = "B  Mining and quarrying" if industry == "2"
replace industry = "C  Manufacturing" if industry == "3"
replace industry = "D-E  Electricity, gas, water supply and other utilities" if industry == "4"
replace industry = "F  Construction" if industry == "5"
replace industry = "G  Wholesale, retail trade, repair of motor vehicles etc." if industry == "6"
replace industry = "H-J  Transportation, storage, information and communication" if industry == "7"
replace industry = "I  Accommodation and food service activities" if industry == "8"
replace industry = "L-M-N  Real estate, professional, scientific and business activities" if industry == "9"
replace industry = "O-P-Q-R-S-U  Other services" if industry == "10"
ren IND lendcoeff_IO
gen foravg9 = lendcoeff_IO

gen CountryCode = "SI"
gen country = "Slovenia"
order CountryCode country industry Year lendcoeff_IO
sort country Year industry
save lend_SI, replace
clear

// ALBANIA, BOSNIA & HERZEGOVINA, NORTH MACEDONIA --> average of sample //
**No WIOD data available for these three countries, instead assign an average of the other countries in the sample

use lend_BG.dta
merge 1:1 industry Year using lend_CZ, nogenerate
merge 1:1 industry Year using lend_EE, nogenerate
merge 1:1 industry Year using lend_HU, nogenerate
merge 1:1 industry Year using lend_LT, nogenerate
merge 1:1 industry Year using lend_LV, nogenerate
merge 1:1 industry Year using lend_PL, nogenerate
merge 1:1 industry Year using lend_SI, nogenerate
merge 1:1 industry Year using lend_SK, nogenerate
drop lendcoeff_IO
egen lendcoeff_IO = rowmean(foravg*)
drop foravg*
replace CountryCode = "AL"
replace country = "Albania"
save lend_AL, replace
clear

use lend_AL.dta
replace CountryCode = "BA"
replace country = "Bosnia and Herzegovina"
save lend_BA.dta, replace
clear

use lend_AL.dta
replace CountryCode = "MK"
replace country = "North Macedonia"
save lend_MK.dta, replace
clear

// MERGING //
use lend_BG.dta

append using lend_CZ
append using lend_EE
append using lend_HU
append using lend_LT
append using lend_LV
append using lend_PL
append using lend_SI
append using lend_SK
append using lend_AL
append using lend_BA
append using lend_MK
drop foravg*
ren Year year
encode industry, gen(sector)
order CountryCode country sector year lendcoeff_IO
sort country year sector

egen sumio = total(lendcoeff_IO), by(country year)
gen lendcoeff_IOb = lendcoeff_IO/sumio
drop lendcoeff_IO sumio
ren lendcoeff_IOb lendcoeff_IO

save lendcoeff3.dta, replace
