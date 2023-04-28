// CENTRAL BANK MEASURE //

cd "C:\Users\Startklaar\Desktop\Studies\MSc - Economic Development & Globalisation\Thesis\Lending data"

// CZECHIA LENDING //
import excel "CzechiaALL", cellrange(A4:Q33) firstrow case(preserve)

rename Date year
drop in 1
drop IND1
destring IND*, replace
gen CountryCode = "CZ"
gen country = "Czechia"
egen IND1415 = rowtotal(IND14 IND15), missing
drop IND14 IND15 IND16
egen IND810 = rowtotal(IND8 IND10), missing
drop IND8 IND10
egen IND1213 = rowtotal(IND12 IND13), missing
drop IND12 IND13

reshape long IND, i(CountryCode year) j(industry)
tostring industry, replace
replace industry = "A" if industry == "2"
replace industry = "B" if industry == "3"
replace industry = "C" if industry == "4"
replace industry = "D-E" if industry == "5"
replace industry = "F" if industry == "6"
replace industry = "G" if industry == "7"
replace industry = "H-J" if industry == "810"
replace industry = "I" if industry == "9"
replace industry = "K" if industry == "11"
replace industry = "L-M-N" if industry == "1213"
replace industry = "O-P-Q-R-S-U" if industry == "1415"

replace IND = . if industry == "K"
rename IND lending
label var lending "Commercial bank loan stock in CZK millions"
rename industry sector
label var sector "NACE Rev.2"
order CountryCode country year sector lending

egen yearsum = total(lending), by(year)
gen lendcoeff_cz = lending/yearsum
drop CountryCode country lending yearsum

save czechialoan.dta, replace
clear

// HUNGARY LENDING //
import excel "HungaryALLadj", cellrange(A7:V115) sheet(total loans) firstrow case(preserve)

drop in 1 
drop in 1
gen year = year(A)
keep if year != year[_n+1]
drop A B F G H I J K
destring IND5 IND9 IND13, replace force
gen CountryCode = "HU"
gen country = "Hungary"
egen IND45 = rowtotal(IND4 IND5), missing
drop IND4 IND5
egen IND810 = rowtotal(IND8 IND10), missing
drop IND8 IND10
egen IND1213 = rowtotal(IND12 IND13), missing
drop IND12 IND13

reshape long IND, i(CountryCode year) j(industry)
tostring industry, replace
replace industry = "A" if industry == "1"
replace industry = "B" if industry == "2"
replace industry = "C" if industry == "3"
replace industry = "D-E" if industry == "45"
replace industry = "F" if industry == "6"
replace industry = "G" if industry == "7"
replace industry = "H-J" if industry == "810"
replace industry = "I" if industry == "9"
replace industry = "K" if industry == "11"
replace industry = "L-M-N" if industry == "1213"
replace industry = "O-P-Q-R-S-U" if industry == "14"
sort year industry
replace IND = . if IND == 0

replace IND = . if industry == "K"
rename IND lending
label var lending "Commercial bank loan stock in Forint Billions"
rename industry sector
label var sector "NACE Rev.2"
order CountryCode country year sector lending

egen yearsum = total(lending), by(year)
gen lendcoeff_hu = lending/yearsum
drop CountryCode country lending yearsum

save hungaryloan.dta, replace
clear

// ESTONIA LENDING //
import excel "EstoniaALL", cellrange(A1:W25) sheet(Sheet1) firstrow case(preserve)

rename A year
drop B TOTAL
gen CountryCode = "EE"
gen country = "Estonia"
egen IND45 = rowtotal(IND4 IND5), missing
drop IND4 IND5
egen IND12 = rowtotal(IND12a IND12b), missing
drop IND12a IND12b
egen IND121314 = rowtotal(IND12 IND13 IND14), missing
drop IND12 IND13 IND14
egen IND1519 = rowtotal(IND15 IND16 IND17 IND18 IND19), missing
drop IND15 IND16 IND17 IND18 IND19
egen IND810 = rowtotal(IND8 IND10), missing
drop IND8 IND10

reshape long IND, i(CountryCode year) j(industry)
tostring industry, replace
replace industry = "A" if industry == "1"
replace industry = "B" if industry == "2"
replace industry = "C" if industry == "3"
replace industry = "D-E" if industry == "45"
replace industry = "F" if industry == "6"
replace industry = "G" if industry == "7"
replace industry = "H-J" if industry == "810"
replace industry = "I" if industry == "9"
replace industry = "K" if industry == "11"
replace industry = "L-M-N" if industry == "121314"
replace industry = "O-P-Q-R-S-U" if industry == "1519"
sort year industry

replace IND = . if industry == "K"
rename IND lending
label var lending "Commercial bank loan stock in EUR million"
rename industry sector
label var sector "NACE Rev.2"
order CountryCode country year sector lending

egen yearsum = total(lending), by(year)
gen lendcoeff_ee = lending/yearsum
drop CountryCode country lending yearsum

save estonialoan.dta, replace
clear

// BULGARIA LENDING // 
import excel "BulgariaALL", cellrange(A1:AM58) sheet(Sheet1) firstrow case(preserve)

keep A IND*
drop in 1
gen year = year(A)
drop A
keep if year != year[_n+1]
gen CountryCode = "BG"
gen country = "Bulgaria"
destring IND*, replace
egen IND45 = rowtotal(IND4 IND5), missing
drop IND4 IND5
egen IND111213 = rowtotal(IND11 IND12 IND13), missing
drop IND11 IND12 IND13
egen IND1417 = rowtotal(IND14 IND15 IND16 IND17), missing
drop IND14 IND15 IND16 IND17
egen IND810 = rowtotal(IND8 IND10), missing
drop IND8 IND10

reshape long IND, i(CountryCode year) j(industry)
tostring industry, replace
replace industry = "A" if industry == "1"
replace industry = "B" if industry == "2"
replace industry = "C" if industry == "3"
replace industry = "D-E" if industry == "45"
replace industry = "F" if industry == "6"
replace industry = "G" if industry == "7"
replace industry = "H-J" if industry == "810"
replace industry = "I" if industry == "9"
replace industry = "L-M-N" if industry == "111213"
replace industry = "O-P-Q-R-S-U" if industry == "1417"
sort year industry 

rename IND lending
label var lending "Commercial bank loan stock in BGR thousand"
rename industry sector
label var sector "NACE Rev.2"
order CountryCode country year sector lending

egen yearsum = total(lending), by(year)
gen lendcoeff_bg = lending/yearsum
drop CountryCode country lending yearsum

save bulgarialoan.dta, replace
clear

// ALBANIA LENDING // 
import excel "AlbaniaPrivate_NFC", cellrange(A1:W54) sheet(Sheet1) firstrow case(preserve)

drop in 1
drop B IND21
rename Code year
destring IND* year, replace
keep if year != year[_n+1]
gen CountryCode = "AL"
gen country = "Albania"
egen IND45 = rowtotal(IND4 IND5), missing
drop IND4 IND5
egen IND810 = rowtotal(IND8 IND10), missing
drop IND8 IND10
egen IND121314 = rowtotal(IND12 IND13 IND14), missing
drop IND12 IND13 IND14
egen IND1520 = rowtotal(IND15 IND16 IND17 IND18 IND19 IND20), missing
drop IND15 IND16 IND17 IND18 IND19 IND20

reshape long IND, i(CountryCode year) j(industry)
tostring industry, replace
save albpriv.dta, replace
clear

import excel "AlbaniaPublic_NFC", cellrange(A1:W54) sheet(Sheet1) firstrow case(preserve)

drop in 1
drop B IND21
rename Code year
destring IND* year, replace
keep if year != year[_n+1]
gen CountryCode = "AL"
gen country = "Albania"
egen IND45 = rowtotal(IND4 IND5), missing
drop IND4 IND5
egen IND810 = rowtotal(IND8 IND10), missing
drop IND8 IND10
egen IND121314 = rowtotal(IND12 IND13 IND14), missing
drop IND12 IND13 IND14
egen IND1520 = rowtotal(IND15 IND16 IND17 IND18 IND19 IND20), missing
drop IND15 IND16 IND17 IND18 IND19 IND20

reshape long IND, i(CountryCode year) j(industry)
tostring industry, replace
rename IND IND2

merge 1:1 country industry year using albpriv.dta, nogenerate

egen lending = rowtotal(IND IND2), missing
drop IND IND2
replace industry = "A" if industry == "1"
replace industry = "B" if industry == "2"
replace industry = "C" if industry == "3"
replace industry = "D-E" if industry == "45"
replace industry = "F" if industry == "6"
replace industry = "G" if industry == "7"
replace industry = "H-J" if industry == "810"
replace industry = "I" if industry == "9"
replace industry = "K" if industry == "11"
replace industry = "L-M-N" if industry == "121314"
replace industry = "O-P-Q-R-S-U" if industry == "1520"
sort year industry 

replace lending = . if industry == "K"
label var lending "Commercial bank loan stock in Lek million"
rename industry sector
label var sector "NACE Rev.2"
order CountryCode country year sector lending

egen yearsum = total(lending), by(year)
gen lendcoeff_al = lending/yearsum
drop CountryCode country lending yearsum
save albanialoan.dta, replace
clear

// SLOVAKIA LENDING //
import excel "SlovakiaALL", cellrange(A2:N15) sheet(Sheet1) firstrow case(preserve)

gen CountryCode = "SK"
gen country = "Slovakia"
egen IND79 = rowtotal(IND7 IND9), missing
drop IND7 IND9
egen IND1112 = rowtotal(IND11 IND12), missing
drop IND11 IND12

reshape long IND, i(CountryCode year) j(industry)
tostring industry, replace
replace industry = "A" if industry == "1"
replace industry = "B" if industry == "2"
replace industry = "C" if industry == "3"
replace industry = "D-E" if industry == "4"
replace industry = "F" if industry == "5"
replace industry = "G" if industry == "6"
replace industry = "H-J" if industry == "79"
replace industry = "I" if industry == "8"
replace industry = "K" if industry == "10"
replace industry = "L-M-N" if industry == "1112"
replace industry = "O-P-Q-R-S-U" if industry == "13"
sort year industry 

replace IND = . if industry == "K"
rename IND lending
label var lending "Commercial bank loan stock in EUR thousand"
rename industry sector
label var sector "NACE Rev.2"
order CountryCode country year sector lending

egen yearsum = total(lending), by(year)
gen lendcoeff_sk = lending/yearsum
drop CountryCode country lending yearsum

save slovakialoan.dta, replace
clear

// MERGING // 
use albanialoan.dta

merge 1:1 year sector using hungaryloan.dta, nogenerate
merge 1:1 year sector using estonialoan.dta, nogenerate
merge 1:1 year sector using slovakialoan.dta, nogenerate
merge 1:1 year sector using czechialoan.dta, nogenerate
merge 1:1 year sector using bulgarialoan.dta, nogenerate
sort year sector

keep if year > 1996 & year < 2021
replace lendcoeff_cz = . if year < 2000
egen lendcoeff_avg = rowmean(lendcoeff_al lendcoeff_bg lendcoeff_cz lendcoeff_ee lendcoeff_hu lendcoeff_sk)
label var lendcoeff_avg "Average share of commercial bank lending to NFCs"

replace sector = "A  Agriculture, forestry and fishing" if sector == "A"
replace sector = "B  Mining and quarrying" if sector == "B"
replace sector = "C  Manufacturing" if sector == "C"
replace sector = "D-E  Electricity, gas, water supply and other utilities" if sector == "D-E"
replace sector = "F  Construction" if sector == "F"
replace sector = "G  Wholesale, retail trade, repair of motor vehicles etc." if sector == "G"
replace sector = "H-J  Transportation, storage, information and communication" if sector == "H-J"
replace sector = "I  Accommodation and food service activities" if sector == "I"
replace sector = "K  Financial and insurance activities" if sector == "K"
replace sector = "L-M-N  Real estate, professional, scientific and business activities" if sector == "L-M-N"
replace sector = "O-P-Q-R-S-U  Other services" if sector == "O-P-Q-R-S-U"
sort sector
encode sector, gen(sector1)
drop sector lendcoeff_al lendcoeff_bg lendcoeff_cz lendcoeff_ee lendcoeff_hu lendcoeff_sk
rename sector1 sector
order sector year lendcoeff_avg
sort year sector

save lendcoeff1.dta, replace
clear



// GVA MEASURE //
cd "C:\Users\Startklaar\Desktop\Studies\MSc - Economic Development & Globalisation\RA\WiP"
use gvapanel.dta

drop GVAR1
drop if CountryCode == "BY" | CountryCode == "HR" | CountryCode == "KZ" | CountryCode == "MD" | CountryCode == "ME" | CountryCode == "RO" | CountryCode == "RS" | CountryCode == "RU" | CountryCode == "TR" | CountryCode == "UA" | CountryCode == "XK" | CountryCode == "YO"

egen sumgva = total(GVAR), by(country year)
gen lendcoeff_gva = GVAR2/sumgva
drop GVAR2 sumgva

save lendcoeff2.dta, replace
clear


