*************************************************************
*****************Summary Statistics**************************
*************************************************************
*This do file is aimed to provide a set of tables on summary statistics as presented in Figure 1, Table 2, and Table 4
********************************************************

********************************************************
********Table 2 + Figure 1 *****************************
********************************************************
********************************************************
********************************************************
//when generating Table 2 and Fig 1, we keep all microfinance crowdfunding models, whereas in other tables or regressions we remove them. The purpose of this is to provide a holistic overview of crowdfunding market  in Table 2 and Fig 1, without affecting the generalizability of the paper's conclusions.
//compared to crowdfunding_platform_level_2015_2020, crowdfunding_platform_level_2015_2020_keep_microfinance keeps platforms operating microfinance crowdfunding models
cd "your directory"
use crowdfunding_platform_level_2015_2020_keep_microfinance.dta,clear

********************************************************
*Platform is uniquely identified by "CompanyID"
********************************************************

label var CCAFCountry "Country"

drop if year < 2015

keep CCAFCountry year CompanyID *_plat Intl_market *Region_recip DevMktInd_recip *law_recip

**Number of domestic vs international platforms by year and by recipient country, distinguished by investor type (retail and institutional)
********************************************************

*************Both international and domestic
*both P2P and ECF and both retail and institutional
cap drop num_plat_both_total_all
bys CCAFCountry year: egen num_plat_both_total_all = nvals(CompanyID)  if total_vol_plat != .  & total_vol_plat != 0  & Intl_market != . 
label var num_plat_both_total_all "# of platforms"
bys CCAFCountry year (num_plat_both_total_all): replace num_plat_both_total_all= num_plat_both_total_all[1] 
replace num_plat_both_total_all = 0 if num_plat_both_total_all == .

cap drop vol_both_total_all
bys CCAFCountry year: egen vol_both_total_all = sum(total_vol_plat)  if total_vol_plat != .  & total_vol_plat != 0  & Intl_market != . 
label var vol_both_total_all "aggregate crowdfunding volume"
bys CCAFCountry year (vol_both_total_all): replace vol_both_total_all= vol_both_total_all[1] 
replace vol_both_total_all = 0 if vol_both_total_all == .

*Retail
cap drop vol_both_retail_all
bys CCAFCountry year: egen vol_both_retail_all = sum(retail_vol_plat)  if retail_vol_plat != .  & retail_vol_plat != 0  & Intl_market != . 
label var vol_both_retail_all "retail crowdfunding volume"
bys CCAFCountry year (vol_both_retail_all): replace vol_both_retail_all= vol_both_retail_all[1] 
replace vol_both_retail_all = 0 if vol_both_retail_all == .

gen ratio_both_retail_all = vol_both_retail_all/vol_both_total_all
label var ratio_both_retail_all "ratio of retail vol. over aggregate vol."

*Institutional
cap drop vol_both_inst_all
bys CCAFCountry year: egen vol_both_inst_all = sum(inst_vol_plat)  if inst_vol_plat != .  & inst_vol_plat != 0  & Intl_market != . 
label var vol_both_inst_all "institutional crowdfunding volume"
bys CCAFCountry year (vol_both_inst_all): replace vol_both_inst_all= vol_both_inst_all[1] 
replace vol_both_inst_all = 0 if vol_both_inst_all == .

gen ratio_both_inst_all = vol_both_inst_all/vol_both_total_all
label var ratio_both_inst_all "ratio of institutional vol. over aggregate vol."

*********************International
*both P2P and ECF and both retail and institutional
cap drop vol_int_total_all
bys CCAFCountry year: egen vol_int_total_all = sum(total_vol_plat)  if total_vol_plat != .  & total_vol_plat != 0  & Intl_market == 1
label var vol_int_total_all "international crowdfunding volume"
bys CCAFCountry year (vol_int_total_all): replace vol_int_total_all= vol_int_total_all[1]
replace vol_int_total_all = 0 if vol_int_total_all == .

gen ratio_int_total_all = vol_int_total_all/vol_both_total_all
label var ratio_int_total_all "ratio of international vol. over aggregate vol."

**************Domestic 
*both P2P and ECF and both retail and institutional
cap drop vol_dom_total_all
bys CCAFCountry year: egen vol_dom_total_all = sum(total_vol_plat)  if total_vol_plat != .  & total_vol_plat != 0  & Intl_market == 0
label var vol_dom_total_all "domestic crowdfunding volume"
bys CCAFCountry year (vol_dom_total_all): replace vol_dom_total_all= vol_dom_total_all[1]
replace vol_dom_total_all = 0 if vol_dom_total_all == .

gen ratio_dom_total_all = vol_dom_total_all/vol_both_total_all
label var ratio_dom_total_all "ratio of domestic vol. over aggregate vol."

**********distinguished by business models (P2P, ECF)
*ECF
cap drop vol_both_total_afeq
bys CCAFCountry year: egen vol_both_total_afeq = sum(total_afeq_plat)  if total_afeq_plat != .  & total_afeq_plat != 0  & Intl_market != .
label var vol_both_total_afeq "ECF volume"
bys CCAFCountry year (vol_both_total_afeq): replace vol_both_total_afeq= vol_both_total_afeq[1]
replace vol_both_total_afeq = 0 if vol_both_total_afeq == .

gen ratio_both_total_afeq = vol_both_total_afeq/vol_both_total_all
label var ratio_both_total_afeq "ratio of ECF vol. over aggregate vol."

*P2P
cap drop vol_both_total_afdebt
bys CCAFCountry year: egen vol_both_total_afdebt = sum(total_afdebt_plat)  if total_afdebt_plat != .  & total_afdebt_plat != 0  & Intl_market != .
label var vol_both_total_afdebt "P2P volume"
bys CCAFCountry year (vol_both_total_afdebt): replace vol_both_total_afdebt= vol_both_total_afdebt[1]
replace vol_both_total_afdebt = 0 if vol_both_total_afdebt == .

gen ratio_both_total_afdebt = vol_both_total_afdebt/vol_both_total_all
label var ratio_both_total_afdebt "ratio of P2P vol. over aggregate vol."

keep *Region_recip CCAFCountry year num_plat* vol* ratio* *law_recip DevMktInd_recip

order *Region_recip CCAFCountry year num_plat*  vol* ratio* *law_recip DevMktInd_recip

sort *Region_recip CCAFCountry year num_plat* vol* ratio* *law_recip DevMktInd_recip


foreach i of varlist vol* {
replace `i' = `i'/1000000
}


bys CCAFCountry year : keep if _n == _N

compress

ren CCAFCountry recipient_country
merge 1:1 year recipient_country using control_variables.dta, keepusing(GDPperCapita)
drop if _merge == 2
drop _merge

ren recipient_country CCAFCountry
label var GDPperCapita "GDP per capita in $"

*aggregate vol. over GDP per capita
gen ratio_both_total_all_gdpcapita = 1000000*vol_both_total_all/GDPperCapita
label var ratio_both_total_all_gdpcapita "ratio of aggregate vol. to GDP per capita"

preserve 
keep SubRegion_recip MajorRegion_recip CCAFCountry year num_plat_both_total_all ratio_both_total_all_gdpcapita 

collapse (mean) num_plat_both_total_all ratio_both_total_all_gdpcapita, by(CCAFCountry)

list 
***Fig 1 - Heat map:
cd "your directory"
export excel using "Fig 1 heat_map.xlsx", sheet("heat map") replace firstrow(varlabels) 
*fig 1 can then be generated using the built-in Map function in excel

restore

***Table 2:

foreach v of var * {
 	local l`v' : variable label `v'
       if `"`l`v''"' == "" {
 		local l`v' "`v'"
  	}
 }
 

foreach i of varlist num_plat* vol* ratio*  {
bys CCAFCountry (year): egen `i'1 = mean(`i')
drop `i'
ren `i'1  `i'
}



bys CCAFCountry: keep if _n == _N

order *Region_recip CCAFCountry *law_recip DevMktInd_recip num_plat* vol* ratio* 
drop year

drop ratio*

gen ratio_both_retail_all = vol_both_retail_all/vol_both_total_all
label var ratio_both_retail_all "ratio of retail vol. over aggregate vol."

gen ratio_both_inst_all = vol_both_inst_all/vol_both_total_all
label var ratio_both_inst_all "ratio of institutional vol. over aggregate vol."

gen ratio_int_total_all = vol_int_total_all/vol_both_total_all
label var ratio_int_total_all "ratio of international vol. over aggregate vol."

gen ratio_dom_total_all = vol_dom_total_all/vol_both_total_all
label var ratio_dom_total_all "ratio of domestic vol. over aggregate vol."

gen ratio_both_total_afeq = vol_both_total_afeq/vol_both_total_all
label var ratio_both_total_afeq "ratio of ECF vol. over aggregate vol."

gen ratio_both_total_afdebt = vol_both_total_afdebt/vol_both_total_all
label var ratio_both_total_afdebt "ratio of P2P vol. over aggregate vol."


 foreach v of var * {
 	label var `v' `"`l`v''"'
  }
  

gen num_countries = 1
label var num_countries "Number of countries"

preserve

foreach v of var * {
 	local l`v' : variable label `v'
       if `"`l`v''"' == "" {
 		local l`v' "`v'"
  	}
}


collapse (rawsum) num_countries  num_plat* vol* (mean)  ratio* 

foreach v of var * {
 	label var `v' `"`l`v''"'
}


save table2.dta,replace
restore



preserve

foreach v of var * {
 	local l`v' : variable label `v'
       if `"`l`v''"' == "" {
 		local l`v' "`v'"
  	}
 }
 
 
gen ExclChina = (CCAFCountry != "China")

gen Developed = 1 if DevMktInd_recip == 1 & ExclChina == 1
gen Developin_exlChina = 1 if DevMktInd_recip == 0 & ExclChina == 1

collapse (rawsum) num_countries num_plat* vol* (mean) ratio*, by(Develop*)

drop if Developed == . & Developin_exlChina == .


 foreach v of var * {
 	label var `v' `"`l`v''"'
  }

  
append using table2.dta
save table2.dta,replace
restore



preserve

foreach v of var * {
 	local l`v' : variable label `v'
       if `"`l`v''"' == "" {
 		local l`v' "`v'"
  	}
 }
 
 
gen ExclChina = (CCAFCountry != "China")

gen Developin = 1 if DevMktInd_recip == 0

collapse (rawsum) num_countries  num_plat* vol* (mean) ratio*, by(Develop*)

 foreach v of var * {
 	label var `v' `"`l`v''"'
  }

 
drop if Developin == .
 

append using table2.dta
save table2.dta,replace
restore


preserve

foreach v of var * {
 	local l`v' : variable label `v'
       if `"`l`v''"' == "" {
 		local l`v' "`v'"
  	}
}
 
collapse (rawsum) num_countries num_plat* vol* (mean) ratio*, by(civil_law_recip)

 foreach v of var * {
 	label var `v' `"`l`v''"'
  }
  
drop if civil_law_recip == . | civil_law_recip == 0
append using table2.dta
save table2.dta,replace


restore


preserve

foreach v of var * {
 	local l`v' : variable label `v'
       if `"`l`v''"' == "" {
 		local l`v' "`v'"
  	}
 }

collapse (rawsum) num_countries  num_plat* vol* (mean) ratio* , by(common_law_recip)


 foreach v of var * {
 	label var `v' `"`l`v''"'
  }
  
drop if common_law_recip == . | common_law_recip == 0

append using table2.dta
save table2.dta,replace
restore

preserve

foreach v of var * {
 	local l`v' : variable label `v'
       if `"`l`v''"' == "" {
 		local l`v' "`v'"
  	}
}
 
collapse (rawsum) num_countries  num_plat* vol* (mean) ratio*, by(islamic_law_recip)

 foreach v of var * {
 	label var `v' `"`l`v''"'
  }
  
drop if islamic_law_recip == . | islamic_law_recip == 0

append using table2.dta
save table2.dta,replace
restore

drop if islamic_law_recip == .

use table2.dta,clear

gen Markets = .

order Markets Develop* civil_law_recip common_law_recip islamic_law_recip 

replace Markets = 0 if Developin == . & Developed==. & Developin_exlChina ==. & civil_law ==. & common_law  == . & islamic_law ==. 
replace Markets = 1 if Developed == 1
replace Markets = 2 if Developin == 1 
replace Markets = 3 if Developin_exlChina == 1
replace Markets = 4 if common_law_recip == 1 
replace Markets = 5 if civil_law_recip == 1
replace Markets = 6 if islamic_law_recip == 1

label  define marketlabel 0 "All markets" 1 "All developed markets" 2 "All developing markets" 3 "All developing markets (excl. China)" 4 "All common law countries" 5 "All civil law countries" 6 "All Musilm law countries"
label values Markets marketlabel 

drop *law_recip Develop*

order Markets 
drop if Markets == .

sort Markets

compress

list 

cd "your directory"
export excel using "Summary Statistics.xlsx", sheet("Table 2",replace) firstrow(varlabels) 





*Table 4: summary statistics for all variables
cd "your directory"
use crowdfunding_country_level_2015_2020.dta,clear

merge 1:1 recipient_country year using regindex_country_level_2015_2020
drop if _merge == 2
drop _merge 

cd "your directory"
merge 1:1 recipient_country year using control_variables
drop if _merge == 2
drop _merge 

keep recipient_country year P2P_Binary_pub_recip  P2P_RegIndex_pub_recip  P2P_RegIndex_Adj_pub_recip total_afdebt_dom   retail_afdebt_dom  inst_afdebt_dom  RL_EST_recip GDP_currentUS_recip Time_startup_recip Cost_startup_recip Tax_income_pct_recip GC_LegalRights_recip GC_CreditInfo_recip RI_recip Bank_C2A_recip DomCredit_by_banks_recip BankBranch_per100k_recip Bank_NPL_recip MobilePhoneUsage_recip Switcher_P2P P2P_year

foreach i of varlist total* retail* inst* {
replace `i' = `i'/1000000
}

replace GDP_currentUS_recip =  GDP_currentUS_recip/1000000000


bys recipient_country (year): gen switching_year = (P2P_year == year)

bys recipient_country (switching_year):  gen NeverSwitcher_P2P = (P2P_year == 0)

bys recipient_country (switching_year):  gen AlwaysSwitcher_P2P = (P2P_year < 2015 & P2P_year > 0)


keep if year >= 2015

label var total_afdebt_dom "Debt crowdfunding volume (domestic; retail + institutional) ($ mil)"

label var retail_afdebt_dom "Debt crowdfunding volume (domestic; retail) ($ mil)"

label var inst_afdebt_dom "Debt crowdfunding volume (domestic; institutional) ($ mil)"


label var RL_EST_recip "Rule of Law"

label var GDP_currentUS_recip "GDP ($ bil)"

label var Time_startup_recip "Time required to start a business (days)"

label var Cost_startup_recip "Cost of business start-up procedures (% of GNI per capita)"

label var Tax_income_pct_recip "Taxes on income, profits and capital gains (% of revenue)"

label var GC_LegalRights_recip "Strength of legal rights index (0-12)"

label var GC_CreditInfo_recip "Depth of credit information index (0-8)"

label var RI_recip "Resolving insolvency"

label var Bank_C2A_recip "Bank capital to assets ratio (%)"

label var DomCredit_by_banks_recip "Domestic credit to private sector by banks (% of GDP)"

label var BankBranch_per100k_recip "Commercial bank branches (per 100k adults)"

label var Bank_NPL_recip "Bank bad-debt ratio (%)"

label var MobilePhoneUsage_recip "Mobile cellular subscriptions (per 100 people)"


gen num_countries = 1
label var num_countries "Number of countries"


compress


preserve


foreach v of var * {
 	local l`v' : variable label `v'
       if `"`l`v''"' == "" {
 		local l`v' "`v'"
  	}
}

foreach i of varlist total_afdebt_dom P2P_RegIndex_pub_recip  P2P_RegIndex_Adj_pub_recip  retail_afdebt_dom  inst_afdebt_dom  RL_EST_recip GDP_currentUS_recip Time_startup_recip Cost_startup_recip Tax_income_pct_recip GC_LegalRights_recip GC_CreditInfo_recip RI_recip Bank_C2A_recip DomCredit_by_banks_recip BankBranch_per100k_recip Bank_NPL_recip MobilePhoneUsage_recip {
bys recipient_country (year): egen `i'1 = mean(`i')
drop `i'
ren `i'1  `i'
}


bys recipient_country: keep if _n == _N

drop if switching_year == 1

drop if NeverSwitcher_P2P == 0 & AlwaysSwitcher_P2P == 0 


collapse (sum) num_countries (mean) P2P_RegIndex_pub_recip  P2P_RegIndex_Adj_pub_recip  total_afdebt_dom   retail_afdebt_dom  inst_afdebt_dom  RL_EST_recip GDP_currentUS_recip Time_startup_recip Cost_startup_recip Tax_income_pct_recip GC_LegalRights_recip GC_CreditInfo_recip RI_recip Bank_C2A_recip DomCredit_by_banks_recip BankBranch_per100k_recip Bank_NPL_recip MobilePhoneUsage_recip , by(NeverSwitcher_P2P AlwaysSwitcher_P2P)

foreach v of var * {
 	label var `v' `"`l`v''"'
}


gen countries = 3  if AlwaysSwitcher_P2P == 1
replace countries = 4 if NeverSwitcher_P2P == 1

save table4_means.dta,replace

restore


preserve

foreach v of var * {
 	local l`v' : variable label `v'
       if `"`l`v''"' == "" {
 		local l`v' "`v'"
  	}
}

foreach i of varlist total_afdebt_dom P2P_RegIndex_pub_recip  P2P_RegIndex_Adj_pub_recip   retail_afdebt_dom  inst_afdebt_dom  RL_EST_recip GDP_currentUS_recip Time_startup_recip Cost_startup_recip Tax_income_pct_recip GC_LegalRights_recip GC_CreditInfo_recip RI_recip Bank_C2A_recip DomCredit_by_banks_recip BankBranch_per100k_recip Bank_NPL_recip MobilePhoneUsage_recip {
bys recipient_country (year): egen `i'1 = mean(`i')
drop `i'
ren `i'1  `i'
}

 


bys recipient_country: keep if _n == _N

collapse (sum) num_countries (mean) P2P_RegIndex_pub_recip  P2P_RegIndex_Adj_pub_recip  total_afdebt_dom   retail_afdebt_dom  inst_afdebt_dom  RL_EST_recip GDP_currentUS_recip Time_startup_recip Cost_startup_recip Tax_income_pct_recip GC_LegalRights_recip GC_CreditInfo_recip RI_recip Bank_C2A_recip DomCredit_by_banks_recip BankBranch_per100k_recip Bank_NPL_recip MobilePhoneUsage_recip

foreach v of var * {
 	label var `v' `"`l`v''"'
}

gen countries = 1 

append using table4_means.dta

save table4_means.dta,replace



restore 

keep if switching_year == 1

foreach v of var * {
 	local l`v' : variable label `v'
       if `"`l`v''"' == "" {
 		local l`v' "`v'"
  	}
}

collapse (sum) num_countries (mean) P2P_RegIndex_pub_recip  P2P_RegIndex_Adj_pub_recip  total_afdebt_dom   retail_afdebt_dom  inst_afdebt_dom  RL_EST_recip GDP_currentUS_recip Time_startup_recip Cost_startup_recip Tax_income_pct_recip GC_LegalRights_recip GC_CreditInfo_recip RI_recip Bank_C2A_recip DomCredit_by_banks_recip BankBranch_per100k_recip Bank_NPL_recip MobilePhoneUsage_recip

foreach v of var * {
 	label var `v' `"`l`v''"'
}


gen countries = 2

append using table4_means.dta

save table4_means.dta,replace

use table4_means.dta,clear

label  define countrieslabel 1 "All countries" 2 "Countries that added regulation after 2015" 3 "Countries that added regulation before 2015" 4 "Countries that never had regulation" 


label values countries countrieslabel 

sort countries

drop *Switcher* 

order countries num_countries

save table4_means.dta,replace

list 

cd "your directory"
export excel using "Summary Statistics.xlsx", sheet("Table 4 Means", replace)  firstrow(varlabels) 



***Table 4: ANOVA
cd "your directory"
use crowdfunding_country_level_2015_2020.dta,clear

merge 1:1 recipient_country year using regindex_country_level_2015_2020
drop if _merge == 2
drop _merge 

cd "your directory"
merge 1:1 recipient_country year using control_variables
drop if _merge == 2
drop _merge 

keep recipient_country year P2P_Binary_pub_recip  P2P_RegIndex_pub_recip  P2P_RegIndex_Adj_pub_recip total_afdebt_dom   retail_afdebt_dom  inst_afdebt_dom  RL_EST_recip GDP_currentUS_recip Time_startup_recip Cost_startup_recip Tax_income_pct_recip GC_LegalRights_recip GC_CreditInfo_recip RI_recip Bank_C2A_recip DomCredit_by_banks_recip BankBranch_per100k_recip Bank_NPL_recip MobilePhoneUsage_recip Switcher_P2P P2P_year

foreach i of varlist total* retail* inst* {
replace `i' = `i'/1000000
}

replace GDP_currentUS_recip =  GDP_currentUS_recip/1000000000

bys recipient_country (year): gen switching_year = (year == P2P_year)
bys recipient_country (switching_year): gen NeverSwitcher_P2P = (P2P_year == 0)

bys recipient_country (switching_year): gen AlwaysSwitcher_P2P = (P2P_year < 2015 & P2P_year > 0)

keep if year >= 2015

label var total_afdebt_dom "Debt crowdfunding volume (domestic; retail + institutional) ($ mil)"

label var retail_afdebt_dom "Debt crowdfunding volume (domestic; retail) ($ mil)"

label var inst_afdebt_dom "Debt crowdfunding volume (domestic; institutional) ($ mil)"


label var RL_EST_recip "Rule of Law"

label var GDP_currentUS_recip "GDP ($ bil)"

label var Time_startup_recip "Time required to start a business (days)"

label var Cost_startup_recip "Cost of business start-up procedures (% of GNI per capita)"

label var Tax_income_pct_recip "Taxes on income, profits and capital gains (% of revenue)"

label var GC_LegalRights_recip "Strength of legal rights index (0-12)"

label var GC_CreditInfo_recip "Depth of credit information index (0-8)"

label var RI_recip "Resolving insolvency"

label var Bank_C2A_recip "Bank capital to assets ratio (%)"

label var DomCredit_by_banks_recip "Domestic credit to private sector by banks (% of GDP)"

label var BankBranch_per100k_recip "Commercial bank branches (per 100k adults)"

label var Bank_NPL_recip "Bank bad-debt ratio (%)"

label var MobilePhoneUsage_recip "Mobile cellular subscriptions (per 100 people)"


gen num_countries = 1
label var num_countries "Number of countries"


compress



foreach v of var * {
 	local l`v' : variable label `v'
       if `"`l`v''"' == "" {
 		local l`v' "`v'"
  	}
}

//replace NeverSwitcher_P2P = 0 if switching_year == 1 

keep if switching_year == 1 | AlwaysSwitcher_P2P == 1 |  NeverSwitcher_P2P == 1


foreach i of varlist total_afdebt_dom P2P_RegIndex_pub_recip  P2P_RegIndex_Adj_pub_recip  retail_afdebt_dom  inst_afdebt_dom  RL_EST_recip GDP_currentUS_recip Time_startup_recip Cost_startup_recip Tax_income_pct_recip GC_LegalRights_recip GC_CreditInfo_recip RI_recip Bank_C2A_recip DomCredit_by_banks_recip BankBranch_per100k_recip Bank_NPL_recip MobilePhoneUsage_recip {
bys recipient_country (year): egen `i'1 = mean(`i')
drop `i'
ren `i'1  `i'
}

bys recipient_country: keep if _n == _N

keep num_countries AlwaysSwitcher_P2P NeverSwitcher_P2P switching_year total_afdebt_dom P2P_RegIndex_pub_recip  P2P_RegIndex_Adj_pub_recip  retail_afdebt_dom  inst_afdebt_dom  RL_EST_recip GDP_currentUS_recip Time_startup_recip Cost_startup_recip Tax_income_pct_recip GC_LegalRights_recip GC_CreditInfo_recip RI_recip Bank_C2A_recip DomCredit_by_banks_recip BankBranch_per100k_recip Bank_NPL_recip MobilePhoneUsage_recip 

preserve 

collapse (sum) num_countries (mean) P2P_RegIndex_pub_recip  P2P_RegIndex_Adj_pub_recip total_afdebt_dom retail_afdebt_dom  inst_afdebt_dom   RL_EST_recip GDP_currentUS_recip Time_startup_recip Cost_startup_recip Tax_income_pct_recip GC_LegalRights_recip GC_CreditInfo_recip RI_recip Bank_C2A_recip DomCredit_by_banks_recip BankBranch_per100k_recip Bank_NPL_recip MobilePhoneUsage_recip, by(NeverSwitcher_P2P AlwaysSwitcher_P2P)
foreach v of var * {
 	label var `v' `"`l`v''"'
}

save table4_anova.dta,replace


restore 

preserve 

drop if NeverSwitcher_P2P == 1

foreach i of varlist P2P_RegIndex_pub_recip  P2P_RegIndex_Adj_pub_recip total_afdebt_dom   retail_afdebt_dom  inst_afdebt_dom  RL_EST_recip GDP_currentUS_recip Time_startup_recip Cost_startup_recip Tax_income_pct_recip GC_LegalRights_recip GC_CreditInfo_recip RI_recip Bank_C2A_recip DomCredit_by_banks_recip BankBranch_per100k_recip Bank_NPL_recip MobilePhoneUsage_recip {
anova `i' switching_year
replace  `i' =  Ftail(e(df_m), e(df_r), e(F))
}

collapse (sum) num_countries (mean) P2P_RegIndex_pub_recip  P2P_RegIndex_Adj_pub_recip total_afdebt_dom retail_afdebt_dom  inst_afdebt_dom   RL_EST_recip GDP_currentUS_recip Time_startup_recip Cost_startup_recip Tax_income_pct_recip GC_LegalRights_recip GC_CreditInfo_recip RI_recip Bank_C2A_recip DomCredit_by_banks_recip BankBranch_per100k_recip Bank_NPL_recip MobilePhoneUsage_recip
foreach v of var * {
 	label var `v' `"`l`v''"'
}
append using table4_anova.dta
save table4_anova.dta,replace
restore  

drop if AlwaysSwitcher_P2P == 1

foreach i of varlist P2P_RegIndex_pub_recip  P2P_RegIndex_Adj_pub_recip total_afdebt_dom   retail_afdebt_dom  inst_afdebt_dom  RL_EST_recip GDP_currentUS_recip Time_startup_recip Cost_startup_recip Tax_income_pct_recip GC_LegalRights_recip GC_CreditInfo_recip RI_recip Bank_C2A_recip DomCredit_by_banks_recip BankBranch_per100k_recip Bank_NPL_recip MobilePhoneUsage_recip {
anova `i' switching_year
replace  `i' =  Ftail(e(df_m), e(df_r), e(F))
}

collapse (sum) num_countries (mean) P2P_RegIndex_pub_recip  P2P_RegIndex_Adj_pub_recip total_afdebt_dom retail_afdebt_dom  inst_afdebt_dom   RL_EST_recip GDP_currentUS_recip Time_startup_recip Cost_startup_recip Tax_income_pct_recip GC_LegalRights_recip GC_CreditInfo_recip RI_recip Bank_C2A_recip DomCredit_by_banks_recip BankBranch_per100k_recip Bank_NPL_recip MobilePhoneUsage_recip

foreach v of var * {
 	label var `v' `"`l`v''"'
}
append using table4_anova.dta
save table4_anova.dta,replace

list 

cd "your directory"
export excel using "Summary Statistics.xlsx", sheet("Table 4 anova", replace)  firstrow(varlabels) 