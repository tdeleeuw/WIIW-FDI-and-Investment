# WIIW-FDI-and-Investment
The do-files uploaded to this repository were all created for a Master thesis at the University of Groningen, namely: Financial sector FDI and domestic investment: a cross-sector analysis. 

The codes uploaded here are (hopefully) plug and play, allowing the user to create a sector-level FDI and GFCF database that combines the wiiw's Annual database and FDI database. It is essential to first run the individual component files (FDI, GFCF, GVA, etc.) before creating the final database.

Data utilised mainly stems from the Vienna Institute for International Economics (wiiw), but data is also obtained from Eurostat (currency conversions), The World Input-Output Database, and a handful of CEE central banks.

IMPORTANT BEFORE USE
1. DOWNLOAD THE CORRECT DATA
- FDI: FDI by activities from the wiiw FDI database: https://data.wiiw.ac.at/fdi-database.html#
- GFCF: Gross Fixed Capital Formation by activities from the wiiw Annual database: https://data.wiiw.ac.at/annual-database.html#
- GVA: Gross value added by activities: https://data.wiiw.ac.at/annual-database.html#
- IO: Financial service activities (sector K64) from WIOD's National Input-Output Tables: https://www.rug.nl/ggdc/valuechain/wiod/wiod-2016-release
- LEND: Stock of loans to non-financial corporations: 
  - Albania: https://www.bankofalbania.org/Statistics/Monetary_Financial_and_Banking_statistics/Credits.html
  - Bulgaria: https://www.bnb.bg/Statistics/StMonetaryInterestRate/StDepositsAndCredits/StDCCredits/StDCDataSeries/index.htm
  - Czechia: https://www.cnb.cz/cnb/STAT.ARADY_PKG.PARAMETRY_SESTAVY?p_sestuid=51031&p_strid=AABBAC&p_lang=EN
  - Estonia: https://statistika.eestipank.ee/#/en/p/650/r/1057/906
  - Hungary: https://www.mnb.hu/en/statistics/statistical-data-and-information/statistical-time-series/x-monetary-and-other-balance-sheet-statistics
  - Slovakia: https://nbs.sk/en/statistics/financial-institutions/banks/statistical-data-of-monetary-financial-institutions/loans/

2. IMPORT EXCEL COMMANDS
- Place the original excel files in the initial working directory for it to work, not in a path.
- Be aware that datasources might have been updated since writing this code, therefore the "sheet" and "cellrange" options may have to be adjusted.

3. NACE 1-LETTER CLASSIFICATION REVISIONS
- The FDI, GFCF and GVA code produce two different measures of each of these variables, one for the first revision of NACE (the industry classification framework) and for its second revision. At the 1-letter level of aggregation it is not fruitful to combine the two, the revisions are too dissimilar.

4. CONTACT ME
- If the codes do not seem to work, you are welcome to send me a message.
- Or if you are a Thesis student at the RUG, ask your supervisor for my contact info :).
