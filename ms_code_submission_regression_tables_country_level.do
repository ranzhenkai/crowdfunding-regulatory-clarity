*This do file aims to provide a set of main regression tables included in the manuscript
*Only tables based on country-level data are described in this code:
*Table 5, 6, 7, 9, 10, 11 (except Panel C Part II), 12
*Other tables are based on platform-level data, and are described in another code 

*At the bottom of this code, we show how to produce Figure 1， 2，and Table 4.

//merge with control variables, so that the final data is ready for generating all regressions
cd "your directory"
use crowdfunding_country_level_2015_2020, clear

merge 1:1 recipient_country year using regindex_country_level_2015_2020
drop if _merge == 2
drop _merge 

merge 1:1 recipient_country year using control_variables
drop if _merge == 2
drop _merge 

cd "your directory"
save country_panel_data_final, replace


*****************All Main Tables************************
********************************************************
cd "your directory"
use country_panel_data_final,clear

bys Recipient_country (year): egen switcher_ECF_RegIndex = mean(ECF_RegIndex_pub_L_recip) if Switcher_ECF_recip == 1 & year >= ECF_year_recip + 1  & year >= 2015 & year <= 2020 & ECF_year_recip != 0

bys Recipient_country (year): egen switcher_ECF_RegIndex_Adj = mean(ECF_RegIndex_Adj_pub_L_recip)  if Switcher_ECF_recip == 1 & year >= ECF_year_recip + 1 & year >= 2015 & year <= 2020 & ECF_year_recip != 0

bys Recipient_country (year): egen switcher_P2P_RegIndex = mean(P2P_RegIndex_pub_L_recip)  if Switcher_P2P_recip == 1 & year >= P2P_year_recip + 1 & year >= 2015 & year <= 2020 & P2P_year_recip!= 0

bys Recipient_country (year): egen switcher_P2P_RegIndex_Adj = mean(P2P_RegIndex_Adj_pub_L_recip)  if Switcher_P2P_recip == 1 & year >= P2P_year_recip + 1 & year >= 2015 & year <= 2020 & P2P_year_recip!= 0

bys Recipient_country (year): replace switcher_ECF_RegIndex = . if year != ECF_year_recip + 1

bys Recipient_country (year): replace switcher_ECF_RegIndex_Adj =. if year != ECF_year_recip + 1

bys Recipient_country (year): replace switcher_P2P_RegIndex = . if year != P2P_year_recip + 1

bys Recipient_country (year): replace switcher_P2P_RegIndex_Adj =. if year != P2P_year_recip + 1

bys Recipient_country (year): egen always_ECF_RegIndex_after = mean(ECF_RegIndex_pub_L_recip) if Switcher_ECF_recip == 0 & year >= ECF_year_recip + 1  & year >= 2016 & year <= 2020 & ECF_year_recip != 0

bys Recipient_country (year): egen always_ECF_RegIndex_Adj_after = mean(ECF_RegIndex_Adj_pub_L_recip)  if Switcher_ECF_recip == 0 & year >= ECF_year_recip + 1 & year >= 2016 & year <= 2020 & ECF_year_recip != 0

bys Recipient_country (year): egen always_P2P_RegIndex_after = mean(P2P_RegIndex_pub_L_recip)  if Switcher_P2P_recip == 0 & year >= P2P_year_recip + 1 & year >= 2016 & year <= 2020 & P2P_year_recip!= 0

bys Recipient_country (year): egen always_P2P_RegIndex_Adj_after = mean(P2P_RegIndex_Adj_pub_L_recip)  if Switcher_P2P_recip == 0 & year >= P2P_year_recip + 1 & year >= 2016 & year <= 2020 & P2P_year_recip!=0



bys Recipient_country (always_ECF_RegIndex_after): replace  always_ECF_RegIndex_after = always_ECF_RegIndex_after[1]

bys Recipient_country (always_ECF_RegIndex_Adj_after): replace always_ECF_RegIndex_Adj_after = always_ECF_RegIndex_Adj_after[1]

bys Recipient_country (always_P2P_RegIndex_after): replace always_P2P_RegIndex_after = always_P2P_RegIndex_after[1]

bys Recipient_country (always_P2P_RegIndex_Adj_after): replace always_P2P_RegIndex_Adj_after = always_P2P_RegIndex_Adj_after[1]


bys Recipient_country (year): egen always_ECF_RegIndex_before = mean(ECF_RegIndex_pub_L_recip) if Switcher_ECF_recip == 0 & year >= ECF_year_recip + 1  & year <= 2015 & ECF_year_recip != 0

bys Recipient_country (year): egen always_ECF_RegIndex_Adj_before = mean(ECF_RegIndex_Adj_pub_L_recip)  if Switcher_ECF_recip == 0 & year >= ECF_year_recip + 1 &  year <= 2015 & ECF_year_recip != 0

bys Recipient_country (year): egen always_P2P_RegIndex_before = mean(P2P_RegIndex_pub_L_recip)  if Switcher_P2P_recip == 0 & year >= P2P_year_recip + 1 & year <= 2015 & P2P_year_recip!= 0

bys Recipient_country (year): egen always_P2P_RegIndex_Adj_before = mean(P2P_RegIndex_Adj_pub_L_recip)  if Switcher_P2P_recip == 0 & year >= P2P_year_recip + 1 &  year <= 2015 & P2P_year_recip!=0




bys Recipient_country (always_ECF_RegIndex_before): replace  always_ECF_RegIndex_before = always_ECF_RegIndex_before[1]

bys Recipient_country (always_ECF_RegIndex_Adj_before): replace always_ECF_RegIndex_Adj_before = always_ECF_RegIndex_Adj_before[1]

bys Recipient_country (always_P2P_RegIndex_before): replace always_P2P_RegIndex_before = always_P2P_RegIndex_before[1]

bys Recipient_country (always_P2P_RegIndex_Adj_before): replace always_P2P_RegIndex_Adj_before = always_P2P_RegIndex_Adj_before[1]




bys Recipient_country (year): gen always_ECF_RegIndex = always_ECF_RegIndex_after - always_ECF_RegIndex_before

bys Recipient_country (year): gen always_ECF_RegIndex_Adj = always_ECF_RegIndex_Adj_after - always_ECF_RegIndex_Adj_before

bys Recipient_country (year): gen always_P2P_RegIndex = always_P2P_RegIndex_after - always_P2P_RegIndex_before

bys Recipient_country (year): gen always_P2P_RegIndex_Adj = always_P2P_RegIndex_Adj_after - always_P2P_RegIndex_Adj_before




bys Recipient_country (year): replace always_ECF_RegIndex = . if year != 2015

bys Recipient_country (year): replace always_ECF_RegIndex_Adj =. if year != 2015

bys Recipient_country (year): replace always_P2P_RegIndex = . if year != 2015

bys Recipient_country (year): replace always_P2P_RegIndex_Adj =. if year != 2015


sum switcher_ECF_RegIndex 
local switcher_ECF_RegIndex = r(mean)

sum switcher_ECF_RegIndex_Adj
local switcher_ECF_RegIndex_Adj = r(mean)

sum switcher_P2P_RegIndex 
local switcher_P2P_RegIndex = r(mean)

sum switcher_P2P_RegIndex_Adj
local switcher_P2P_RegIndex_Adj = r(mean)

sum always_ECF_RegIndex 
local always_ECF_RegIndex = r(mean)

sum always_ECF_RegIndex_Adj
local always_ECF_RegIndex_Adj = r(mean)

sum always_P2P_RegIndex
local always_P2P_RegIndex = r(mean)

sum always_P2P_RegIndex_Adj
local always_P2P_RegIndex_Adj = r(mean)
 
sum always_ECF_RegIndex_after 
local always_ECF_RegIndex_after = r(mean)

sum always_ECF_RegIndex_Adj_after
local always_ECF_RegIndex_Adj_after = r(mean)

sum always_P2P_RegIndex_after
local always_P2P_RegIndex_after = r(mean)

sum always_P2P_RegIndex_Adj_after
local always_P2P_RegIndex_Adj_after = r(mean)
  

 

***************************************************
***************Regression Analysis*****************
***************************************************


***************************************************
*Table 5*******************************************
***************************************************
*Panel A:******************************************
***************************************************
***************************************************
cd "your directory"
use country_panel_data_final,clear

reghdfe lntotal_adfin_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
                 lngdp_L_recip /// 
  if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
			
est save t5Am1,replace
indeplist
outreg2 t5Am1  using regression_submission_Table5A, replace  st(coef tstat) auto(3) nonotes dta  title("Table 5A: Impact of Regulation on Domestic Debt Crowdfunding Contributed by Both Retail and Institutional Investors. This table reports DiD tests to examine how domestic debt crowdfunding volume is impacted by changes in regulation. The dependent variable is the log of debt crowdfunding volume (contributed by both retail and institutional investors) for domestic platforms scaled by GDP per capita by country. The independent variables, Regulation index and Adjusted Regulation Index, are, respectively, the raw and normalised measures of the regulatory clarity in the country using indicator variables for different regulation provisions. The independent variable, Switcher, is 1 if the country introduces its first regulation between 2015-2020, and 0 otherwise. All independent variables are described in the Appendix and are lagged by a year. All data is aggregated by country and year separately from the 2015-2020 global surveys of crowdfunding. Heteroscedasticity-consistent robust standard errors are clustered by country and year, following Thompson (2011). T-statistics are reported in parentheses. *** p<0.01, ** p<0.05, * p<0.1") addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip  P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip)  label keep(`r(X)') ctitle("Raw")


***Table 5A: Model (2)***************
reghdfe lntotal_adfin_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
			
est save t5Am2,replace
indeplist
outreg2 t5Am2 using regression_submission_Table5A, append  st(coef tstat) auto(3) nonotes dta  addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip  P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label keep(`r(X)') ctitle("Raw")

reghdfe lntotal_adfin_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
			
est save t5Am3,replace
indeplist
outreg2 t5Am3 using regression_submission_Table5A, append  st(coef tstat) auto(3) nonotes dta  addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip  P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label keep(`r(X)') ctitle("Raw")


reghdfe lntotal_adfin_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t5Am4,replace
indeplist
outreg2 t5Am4 using regression_submission_Table5A, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip  P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label keep(`r(X)') ctitle("Raw")

reghdfe lntotal_adfin_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
			

est save t5Am5,replace
indeplist
outreg2 t5Am5 using regression_submission_Table5A, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip  P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label keep(`r(X)') ctitle("Raw")


replace P2P_RegIndex_pub_L_recip = P2P_RegIndex_Adj_pub_L_recip
replace P2P_RegIndex_Switcher_recip = P2P_RegIndex_Adj_Switcher_recip
 

reghdfe lntotal_adfin_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
                 lngdp_L_recip /// 
  if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex_Adj',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex_Adj' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
				
est save t5Am6,replace
indeplist
outreg2 t5Am6 using regression_submission_Table5A, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip     )  label keep(`r(X)')  ctitle("Adj")


reghdfe lntotal_adfin_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex_Adj',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex_Adj' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t5Am7,replace
indeplist
outreg2 t5Am7 using regression_submission_Table5A, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip     )  label keep(`r(X)') ctitle("Adj")

reghdfe lntotal_adfin_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex_Adj',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex_Adj' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t5Am8,replace
indeplist
outreg2 t5Am8 using regression_submission_Table5A, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip     )  label keep(`r(X)') ctitle("Adj")


reghdfe lntotal_adfin_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex_Adj',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex_Adj' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t5Am9,replace
indeplist
outreg2 t5Am9 using regression_submission_Table5A, append  st(coef tstat) auto(3) nonotes dta  addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip     )  label keep(`r(X)') ctitle("Adj")

reghdfe lntotal_adfin_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex_Adj',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex_Adj' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t5Am10,replace
indeplist
outreg2 t5Am10 using regression_submission_Table5A, append  st(coef tstat) auto(3) nonotes dta  addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip     )  label keep(`r(X)') ctitle("Adj")







***************************************************
*Table 5*******************************************
***************************************************
*Panel B:******************************************
***************************************************
***************************************************

cd "your directory"
use country_panel_data_final,clear

reghdfe lnretail_adfin_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
                 lngdp_L_recip /// 
  if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
			
			
est save t5Bm1,replace
indeplist
outreg2 t5Bm1  using regression_submission_Table5B, replace  st(coef tstat) auto(3) nonotes dta  title("Table 2B: Impact of Regulation on Domestic Debt Crowdfunding Contributed by Retail and International Investors. This table reports DiD tests to examine how domestic debt crowdfunding volume is impacted by changes in regulation. The dependent variable is the log of debt crowdfunding volume (contributed by retail investors and interntaion investors) for domestic platforms scaled by GDP per capita by country. The independent variables, Regulation index and Adjusted Regulation Index, are, respectively, the raw and normalised measures of the regulatory clarity in the country using indicator variables for different regulation provisions. The independent variable, Switcher, is 1 if the country introduces its first regulation between 2015-2020, and 0 otherwise. All independent variables are described in the Appendix and are lagged by a year. All data is aggregated by country and year separately from the 2015-2020 global surveys of crowdfunding. Heteroscedasticity-consistent robust standard errors are clustered by country and year, following Thompson (2011). T-statistics are reported in parentheses. *** p<0.01, ** p<0.05, * p<0.1") addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip  P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label keep(`r(X)') ctitle("Raw-Retail")


reghdfe lnretail_adfin_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 

local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
			
		
est save t5Bm2,replace
indeplist
outreg2 t5Bm2 using regression_submission_Table5B, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip  P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label keep(`r(X)') ctitle("Raw-Retail")



reghdfe lninst_adfin_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
                 lngdp_L_recip /// 
  if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
					
est save t5Bm3,replace
indeplist
outreg2 t5Bm3 using regression_submission_Table5B, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip  P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label keep(`r(X)') ctitle("Raw-Inst")


reghdfe lninst_adfin_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
			
			
est save t5Bm4,replace
indeplist
outreg2 t5Bm4 using regression_submission_Table5B, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip  P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label keep(`r(X)') ctitle("Raw-Inst")


replace P2P_RegIndex_pub_L_recip = P2P_RegIndex_Adj_pub_L_recip
replace P2P_RegIndex_Switcher_recip = P2P_RegIndex_Adj_Switcher_recip


reghdfe lnretail_adfin_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
                 lngdp_L_recip /// 
  if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
			
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )


est save t5Bm5,replace
indeplist
outreg2 t5Bm5 using regression_submission_Table5B, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip     )  label keep(`r(X)') ctitle("Adj-Retail")


reghdfe lnretail_adfin_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t5Bm6,replace
indeplist
outreg2 t5Bm6 using regression_submission_Table5B, append  st(coef tstat) auto(3) nonotes dta  addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip     )  label keep(`r(X)') ctitle("Adj-Retail")

reghdfe lninst_adfin_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
                 lngdp_L_recip /// 
  if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
				
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t5Bm7,replace
indeplist
outreg2 t5Bm7 using regression_submission_Table5B, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip     )  label keep(`r(X)') ctitle("Adj-Inst")


reghdfe lninst_adfin_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
   if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )


est save t5Bm8,replace
indeplist
outreg2 t5Bm8 using regression_submission_Table5B, append  st(coef tstat) auto(3) nonotes dta  addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip     )  label keep(`r(X)')  ctitle("Adj-Inst")































***************************************************
*Table 6*******************************************
***************************************************
*Panel A:******************************************
***************************************************
***************************************************
cd "your directory"
use country_panel_data_final,clear

reghdfe lntotal_aefin_dom ECF_RegIndex_pub_L_recip Switcher_ECF_recip ECF_RegIndex_Switcher_recip /// 
                RL_EST_L_recip ///
                lngdp_L_recip ///  
             if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[ECF_RegIndex_pub_L_recip] + _b[ECF_RegIndex_Switcher_recip])*`switcher_ECF_RegIndex',0.001)
local m2 = round(_b[ECF_RegIndex_pub_L_recip]*`always_ECF_RegIndex',0.001)
local m3 = round(_b[ECF_RegIndex_pub_L_recip]*(`switcher_ECF_RegIndex' - `always_ECF_RegIndex') + _b[ECF_RegIndex_Switcher_recip]*`switcher_ECF_RegIndex',0.001)

test (ECF_RegIndex_pub_L_recip + ECF_RegIndex_Switcher_recip)*`switcher_ECF_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test  ECF_RegIndex_pub_L_recip*`always_ECF_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test ECF_RegIndex_pub_L_recip*(`switcher_ECF_RegIndex' - `always_ECF_RegIndex') + ECF_RegIndex_Switcher_recip*`switcher_ECF_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t6am1,replace
indeplist
outreg2 t6am1 using regression_submission_Table6A, replace  st(coef tstat) auto(3) nonotes dta  title("Table 1A: Impact of Regulation on Domestic and International Equity Crowdfunding Contributed by Investors. This table reports DiD tests to examine how domestic equity crowdfunding volume is impacted by changes in regulation. The dependent variable is the log of equity crowdfunding volume (contributed by both retail and institutional investors) for domestic platforms scaled by GDP per capita by country.  The independent variables, Regulation index and Adjusted Regulation Index, are, respectively, the raw and normalised measures of the regulatory clarity in the country using indicator variables for different regulation provisions. The independent variable, Switcher, is 1 if the country introduces its first regulation between 2015-2020, and 0 otherwise. All independent variables are described in the Appendix and are lagged by a year. All data is aggregated by country and year separately from the 2015-2020 global surveys of crowdfunding. Heteroscedasticity-consistent robust standard errors are clustered by country and year, following Thompson (2011). T-statistics are reported in parentheses. *** p<0.01, ** p<0.05, * p<0.1") addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(ECF_Binary_pub_L_recip Switcher_ECF_recip ECF_Binary_Switcher_recip ECF_RegIndex_pub_L_recip Switcher_ECF_recip ECF_RegIndex_Switcher_recip  ECF_RegIndex_Adj_pub_L_recip Switcher_ECF_recip ECF_RegIndex_Adj_Switcher_recip)  label keep(`r(X)') ctitle("Raw-Domestic")

reghdfe lntotal_aefin_dom ECF_RegIndex_pub_L_recip Switcher_ECF_recip ECF_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
				///
                lngdp_L_recip /// 
				 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
                PMI_CorpTransp_L_recip PMI_Disclosure_L_recip ///
				PMI_DL_L_recip ///
				PMI_ShareholderLawsuits_L_recip ///
				/// 
			    StockTradedPct_L_recip ///
				StockTradedTurn_L_recip ///
				lnStockTradedVal_L_recip ///
				lnNum_listed_L_recip ///
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 

local m1 = round((_b[ECF_RegIndex_pub_L_recip] + _b[ECF_RegIndex_Switcher_recip])*`switcher_ECF_RegIndex',0.001)
local m2 = round(_b[ECF_RegIndex_pub_L_recip]*`always_ECF_RegIndex',0.001)
local m3 = round(_b[ECF_RegIndex_pub_L_recip]*(`switcher_ECF_RegIndex' - `always_ECF_RegIndex') + _b[ECF_RegIndex_Switcher_recip]*`switcher_ECF_RegIndex',0.001)

test (ECF_RegIndex_pub_L_recip + ECF_RegIndex_Switcher_recip)*`switcher_ECF_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test  ECF_RegIndex_pub_L_recip*`always_ECF_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test ECF_RegIndex_pub_L_recip*(`switcher_ECF_RegIndex' - `always_ECF_RegIndex') + ECF_RegIndex_Switcher_recip*`switcher_ECF_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )



est save t6Am2,replace
indeplist
outreg2 t6Am2 using regression_submission_Table6A, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(ECF_Binary_pub_L_recip Switcher_ECF_recip ECF_Binary_Switcher_recip ECF_RegIndex_pub_L_recip Switcher_ECF_recip ECF_RegIndex_Switcher_recip  ECF_RegIndex_Adj_pub_L_recip Switcher_ECF_recip ECF_RegIndex_Adj_Switcher_recip        )  label keep(`r(X)') ctitle("Raw-Domestic")



reghdfe lntotal_aefin_in ECF_RegIndex_pub_L_recip Switcher_ECF_recip ECF_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
             if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
			 

local m1 = round((_b[ECF_RegIndex_pub_L_recip] + _b[ECF_RegIndex_Switcher_recip])*`switcher_ECF_RegIndex',0.001)
local m2 = round(_b[ECF_RegIndex_pub_L_recip]*`always_ECF_RegIndex',0.001)
local m3 = round(_b[ECF_RegIndex_pub_L_recip]*(`switcher_ECF_RegIndex' - `always_ECF_RegIndex') + _b[ECF_RegIndex_Switcher_recip]*`switcher_ECF_RegIndex',0.001)

test (ECF_RegIndex_pub_L_recip + ECF_RegIndex_Switcher_recip)*`switcher_ECF_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test  ECF_RegIndex_pub_L_recip*`always_ECF_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test ECF_RegIndex_pub_L_recip*(`switcher_ECF_RegIndex' - `always_ECF_RegIndex') + ECF_RegIndex_Switcher_recip*`switcher_ECF_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )


est save t6Am3,replace
indeplist
outreg2 t6Am2 using regression_submission_Table6A, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(ECF_Binary_pub_L_recip Switcher_ECF_recip ECF_Binary_Switcher_recip ECF_RegIndex_pub_L_recip Switcher_ECF_recip ECF_RegIndex_Switcher_recip  ECF_RegIndex_Adj_pub_L_recip Switcher_ECF_recip ECF_RegIndex_Adj_Switcher_recip        )  label keep(`r(X)') ctitle("Raw-Foreign")

reghdfe lntotal_aefin_in ECF_RegIndex_pub_L_recip Switcher_ECF_recip ECF_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
				///
                lngdp_L_recip /// 
				 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
                PMI_CorpTransp_L_recip PMI_Disclosure_L_recip ///
				PMI_DL_L_recip ///
				PMI_ShareholderLawsuits_L_recip ///
				/// 
			    StockTradedPct_L_recip ///
				StockTradedTurn_L_recip ///
				lnStockTradedVal_L_recip ///
				lnNum_listed_L_recip ///
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 

local m1 = round((_b[ECF_RegIndex_pub_L_recip] + _b[ECF_RegIndex_Switcher_recip])*`switcher_ECF_RegIndex',0.001)
local m2 = round(_b[ECF_RegIndex_pub_L_recip]*`always_ECF_RegIndex',0.001)
local m3 = round(_b[ECF_RegIndex_pub_L_recip]*(`switcher_ECF_RegIndex' - `always_ECF_RegIndex') + _b[ECF_RegIndex_Switcher_recip]*`switcher_ECF_RegIndex',0.001)

test (ECF_RegIndex_pub_L_recip + ECF_RegIndex_Switcher_recip)*`switcher_ECF_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test  ECF_RegIndex_pub_L_recip*`always_ECF_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test ECF_RegIndex_pub_L_recip*(`switcher_ECF_RegIndex' - `always_ECF_RegIndex') + ECF_RegIndex_Switcher_recip*`switcher_ECF_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )


est save t6Am4,replace
indeplist
outreg2 t6Am4 using regression_submission_Table6A, append  st(coef tstat) auto(3) nonotes dta  addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(ECF_Binary_pub_L_recip Switcher_ECF_recip ECF_Binary_Switcher_recip ECF_RegIndex_pub_L_recip Switcher_ECF_recip ECF_RegIndex_Switcher_recip  ECF_RegIndex_Adj_pub_L_recip Switcher_ECF_recip ECF_RegIndex_Adj_Switcher_recip        )  label keep(`r(X)') ctitle("Raw-Foreign")



replace ECF_RegIndex_pub_L_recip = ECF_RegIndex_Adj_pub_L_recip
replace ECF_RegIndex_Switcher_recip = ECF_RegIndex_Adj_Switcher_recip 


reghdfe lntotal_aefin_dom ECF_RegIndex_pub_L_recip Switcher_ECF_recip  ECF_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
             if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
				
local m1 = round((_b[ECF_RegIndex_pub_L_recip] + _b[ECF_RegIndex_Switcher_recip])*`switcher_ECF_RegIndex_Adj',0.001)
local m2 = round(_b[ECF_RegIndex_pub_L_recip]*`always_ECF_RegIndex_Adj',0.001)
local m3 = round(_b[ECF_RegIndex_pub_L_recip]*(`switcher_ECF_RegIndex_Adj' - `always_ECF_RegIndex_Adj') + _b[ECF_RegIndex_Switcher_recip]*`switcher_ECF_RegIndex_Adj',0.001)

test (ECF_RegIndex_pub_L_recip + ECF_RegIndex_Switcher_recip)*`switcher_ECF_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test  ECF_RegIndex_pub_L_recip*`always_ECF_RegIndex_Adj' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test ECF_RegIndex_pub_L_recip*(`switcher_ECF_RegIndex_Adj' - `always_ECF_RegIndex_Adj') + ECF_RegIndex_Switcher_recip*`switcher_ECF_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )


				
est save t6Am5,replace
indeplist
outreg2 t6Am5 using regression_submission_Table6A, append  st(coef tstat) auto(3) nonotes dta  addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(ECF_Binary_pub_L_recip Switcher_ECF_recip ECF_Binary_Switcher_recip ECF_RegIndex_pub_L_recip Switcher_ECF_recip ECF_RegIndex_Switcher_recip  ECF_RegIndex_pub_L_recip Switcher_ECF_recip ECF_RegIndex_Switcher_recip        )  label keep(`r(X)') ctitle("Adj-Domestic")


reghdfe lntotal_aefin_dom ECF_RegIndex_pub_L_recip Switcher_ECF_recip  ECF_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
				///
                lngdp_L_recip /// 
				 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
                PMI_CorpTransp_L_recip PMI_Disclosure_L_recip ///
				PMI_DL_L_recip ///
				PMI_ShareholderLawsuits_L_recip ///
				/// 
			    StockTradedPct_L_recip ///
				StockTradedTurn_L_recip ///
				lnStockTradedVal_L_recip ///
				lnNum_listed_L_recip ///
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 

local m1 = round((_b[ECF_RegIndex_pub_L_recip] + _b[ECF_RegIndex_Switcher_recip])*`switcher_ECF_RegIndex_Adj',0.001)
local m2 = round(_b[ECF_RegIndex_pub_L_recip]*`always_ECF_RegIndex_Adj',0.001)
local m3 = round(_b[ECF_RegIndex_pub_L_recip]*(`switcher_ECF_RegIndex_Adj' - `always_ECF_RegIndex_Adj') + _b[ECF_RegIndex_Switcher_recip]*`switcher_ECF_RegIndex_Adj',0.001)

test (ECF_RegIndex_pub_L_recip + ECF_RegIndex_Switcher_recip)*`switcher_ECF_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test  ECF_RegIndex_pub_L_recip*`always_ECF_RegIndex_Adj' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test ECF_RegIndex_pub_L_recip*(`switcher_ECF_RegIndex_Adj' - `always_ECF_RegIndex_Adj') + ECF_RegIndex_Switcher_recip*`switcher_ECF_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )




est save t6Am6,replace
indeplist
outreg2 t6Am6 using regression_submission_Table6A, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(ECF_Binary_pub_L_recip Switcher_ECF_recip ECF_Binary_Switcher_recip ECF_RegIndex_pub_L_recip Switcher_ECF_recip ECF_RegIndex_Switcher_recip  ECF_RegIndex_pub_L_recip Switcher_ECF_recip ECF_RegIndex_Switcher_recip        )  label keep(`r(X)') ctitle("Adj-Domestic")



reghdfe lntotal_aefin_in ECF_RegIndex_pub_L_recip Switcher_ECF_recip  ECF_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
             if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
				
local m1 = round((_b[ECF_RegIndex_pub_L_recip] + _b[ECF_RegIndex_Switcher_recip])*`switcher_ECF_RegIndex_Adj',0.001)
local m2 = round(_b[ECF_RegIndex_pub_L_recip]*`always_ECF_RegIndex_Adj',0.001)
local m3 = round(_b[ECF_RegIndex_pub_L_recip]*(`switcher_ECF_RegIndex_Adj' - `always_ECF_RegIndex_Adj') + _b[ECF_RegIndex_Switcher_recip]*`switcher_ECF_RegIndex_Adj',0.001)

test (ECF_RegIndex_pub_L_recip + ECF_RegIndex_Switcher_recip)*`switcher_ECF_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test  ECF_RegIndex_pub_L_recip*`always_ECF_RegIndex_Adj' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test ECF_RegIndex_pub_L_recip*(`switcher_ECF_RegIndex_Adj' - `always_ECF_RegIndex_Adj') + ECF_RegIndex_Switcher_recip*`switcher_ECF_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

				
est save t6Am7,replace
indeplist
outreg2 t6Am7 using regression_submission_Table6A, append  st(coef tstat) auto(3) nonotes dta  addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(ECF_Binary_pub_L_recip Switcher_ECF_recip ECF_Binary_Switcher_recip ECF_RegIndex_pub_L_recip Switcher_ECF_recip ECF_RegIndex_Switcher_recip  ECF_RegIndex_pub_L_recip Switcher_ECF_recip ECF_RegIndex_Switcher_recip        )  label keep(`r(X)') ctitle("Adj-Foreign")


reghdfe lntotal_aefin_in ECF_RegIndex_pub_L_recip Switcher_ECF_recip  ECF_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
				///
                lngdp_L_recip /// 
				 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
                PMI_CorpTransp_L_recip PMI_Disclosure_L_recip ///
				PMI_DL_L_recip ///
				PMI_ShareholderLawsuits_L_recip ///
				/// 
			    StockTradedPct_L_recip ///
				StockTradedTurn_L_recip ///
				lnStockTradedVal_L_recip ///
				lnNum_listed_L_recip ///
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[ECF_RegIndex_pub_L_recip] + _b[ECF_RegIndex_Switcher_recip])*`switcher_ECF_RegIndex_Adj',0.001)
local m2 = round(_b[ECF_RegIndex_pub_L_recip]*`always_ECF_RegIndex_Adj',0.001)
local m3 = round(_b[ECF_RegIndex_pub_L_recip]*(`switcher_ECF_RegIndex_Adj' - `always_ECF_RegIndex_Adj') + _b[ECF_RegIndex_Switcher_recip]*`switcher_ECF_RegIndex_Adj',0.001)

test (ECF_RegIndex_pub_L_recip + ECF_RegIndex_Switcher_recip)*`switcher_ECF_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test  ECF_RegIndex_pub_L_recip*`always_ECF_RegIndex_Adj' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test ECF_RegIndex_pub_L_recip*(`switcher_ECF_RegIndex_Adj' - `always_ECF_RegIndex_Adj') + ECF_RegIndex_Switcher_recip*`switcher_ECF_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )


est save t6Am8,replace
indeplist
outreg2 t6Am8 using regression_submission_Table6A, append  st(coef tstat) auto(3) nonotes dta  addtext("Recipient Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(ECF_Binary_pub_L_recip Switcher_ECF_recip ECF_Binary_Switcher_recip ECF_RegIndex_pub_L_recip Switcher_ECF_recip ECF_RegIndex_Switcher_recip  ECF_RegIndex_pub_L_recip Switcher_ECF_recip ECF_RegIndex_Switcher_recip        )  label keep(`r(X)') ctitle("Adj-Foreign")





*************************************************************
*Mechanism Analysis: Potential drivers***********************
**1) # of platforms******************************************
**2) HHI*****************************************************
**3) platform-level volume***********************************
*************************************************************

*************************************************************
********1) # of platforms************************************
*************************************************************

***************************************************
***************************************************
*Table 7*******************************************
***************************************************
***************************************************
***************************************************
*Panel A*******************************************
***************************************************

cd "your directory"
use country_panel_data_final,clear

reghdfe lntotal_adnum_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip ///  
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
				  if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t7Am1,replace
indeplist
outreg2 t7Am1 using regression_submission_Table7A, replace  st(coef tstat) auto(3) nonotes dta  adjr2 title("Table 7A: Impact of Regulation on Number of Domestic Debt Crowdfunding Platforms with Funding Contributed by Both Retail and Institutional Investors. This table reports DiD tests to examine how the number of domestic debt crowdfunding platforms is impacted by changes in regulation. The dependent variable is the log of number of domestic debt crowdfunding platforms (with funding contributed by both retail and institutional investors). The independent variables, Regulation index and Adjusted Regulation Index, are, respectively, the raw and normalised measures of the regulatory clarity in the country using indicator variables for different regulation provisions. The independent variable, Switcher, is 1 if the country introduces its first regulation between 2015-2020, and 0 otherwise. All independent variables are described in the Appendix and are lagged by a year. All data is aggregated by country and year separately from the 2015-2020 global surveys of crowdfunding. Heteroscedasticity-consistent robust standard errors are clustered by country and year, following Thompson (2011). T-statistics are reported in parentheses. *** p<0.01, ** p<0.05, * p<0.1") addtext("Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')")   sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/)  ctitle("Raw-Total")


reghdfe lnretail_adnum_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip ///  
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
				  if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

				  
est save t7Am2,replace
indeplist
outreg2 t7Am2 using regression_submission_Table7A, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')")    sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/)  ctitle("Raw-Retail")



reghdfe lninst_adnum_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip ///  
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
				  if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

				  
est save t7Am3,replace
indeplist
outreg2 t7Am3 using regression_submission_Table7A, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')")    sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/)  ctitle("Raw-Inst")





replace P2P_RegIndex_pub_L_recip = P2P_RegIndex_Adj_pub_L_recip
replace P2P_RegIndex_Switcher_recip = P2P_RegIndex_Adj_Switcher_recip


reghdfe lntotal_adnum_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip ///  
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
				  if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex_Adj',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex_Adj' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
				  
est save t7Am4,replace
indeplist
outreg2 t7Am4 using regression_submission_Table7A, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')")  sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/) ctitle("Adj-Total")




reghdfe lnretail_adnum_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip ///  
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
				  if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 

local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex_Adj',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex_Adj' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

				  
est save t7Am5,replace
indeplist
outreg2 t7Am5 using regression_submission_Table7A, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')")    sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/) ctitle("Adj-Retail")



reghdfe lninst_adnum_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip ///  
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
				  if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex_Adj',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex_Adj' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

				  
est save t7Am6,replace
indeplist
outreg2 t7Am6 using regression_submission_Table7A, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')")    sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/)  ctitle("Adj-Inst")



***************************************************
***************************************************
*Table 7*******************************************
***************************************************
***************************************************
***************************************************
*Panel B*******************************************
***************************************************

cd "your directory"
use country_panel_data_final,clear

reghdfe lntotal_adnum_in P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip ///  
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
				  if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
				  
				  
est save t7Bm1,replace
indeplist
outreg2 t7Bm1 using regression_submission_Table7B, replace  st(coef tstat) auto(3) nonotes dta  adjr2 title("Table 7A: Impact of Regulation on Number of International Debt Crowdfunding Platforms with Funding Contributed by Both Retail and Institutional Investors. This table reports DiD tests to examine how the number of international debt crowdfunding platforms is impacted by changes in regulation. The dependent variable is the log of number of domestic debt crowdfunding platforms (with funding contributed by both retail and institutional investors). The independent variables, Regulation index and Adjusted Regulation Index, are, respectively, the raw and normalised measures of the regulatory clarity in the country using indicator variables for different regulation provisions. The independent variable, Switcher, is 1 if the country introduces its first regulation between 2015-2020, and 0 otherwise. All independent variables are described in the Appendix and are lagged by a year. All data is aggregated by country and year separately from the 2015-2020 global surveys of crowdfunding. Heteroscedasticity-consistent robust standard errors are clustered by country and year, following Thompson (2011). T-statistics are reported in parentheses. *** p<0.01, ** p<0.05, * p<0.1") addtext("Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')")   sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/)  ctitle("Raw-Total")





reghdfe lnretail_adnum_in P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip ///  
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
				  if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

				  
est save t7Bm2,replace
indeplist
outreg2 t7Bm2 using regression_submission_Table7B, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')")    sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/)  ctitle("Raw-Retail")


reghdfe lninst_adnum_in P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip ///  
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
				  if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
				  
est save t7Bm3,replace
indeplist
outreg2 t7Bm3 using regression_submission_Table7B, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')")    sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/)  ctitle("Raw-Inst")


replace P2P_RegIndex_pub_L_recip = P2P_RegIndex_Adj_pub_L_recip
replace P2P_RegIndex_Switcher_recip = P2P_RegIndex_Adj_Switcher_recip


reghdfe lntotal_adnum_in P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip ///  
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
				  if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex_Adj',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex_Adj' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
				  
est save t7Bm4,replace
indeplist
outreg2 t7Bm4 using regression_submission_Table7B, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')")    sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/) ctitle("Adj-Total")


reghdfe lnretail_adnum_in P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip ///  
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
				  if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 

local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex_Adj',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex_Adj' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
				  
est save t7Bm5,replace
indeplist
outreg2 t7Bm5 using regression_submission_Table7B, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')")    sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/) ctitle("Adj-Retail")

reghdfe lninst_adnum_in P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip ///  
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
				  if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex_Adj',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex_Adj' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

				  
est save t7Bm6,replace
indeplist
outreg2 t7Bm6 using regression_submission_Table7B, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')")    sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/) ctitle("Adj-Inst")












*******************************
*********HHI*******************
*******************************

***************************************************
***************************************************
*Table 9*******************************************
***************************************************
***************************************************
cd "your directory"
use country_panel_data_final,clear

fracreg probit hhind_debfin_total P2P_RegIndex_pub_L_recip   P2P_RegIndex_Switcher_recip ///  
                RL_EST_L_recip /// 
                 lngdp_L_recip /// 
				i.year i.Recipient_country if year >= 2015 ,iterate(200)
				
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t9Am1,replace
indeplist
outreg2 t9Am1  using regression_submission_Table9A, replace  st(coef tstat) auto(3) nonotes dta  title("Table 9A: Impact of Regulation on Debt Crowdfunding Market Competitiveness with Funding Contributed by Both Retail and Institutional Investors. This table reports DiD tests to examine how the debt crowdfunding market competitiveness is impacted by changes in regulation in the recipient country. The dependent variable is Herfindahl–Hirschman Index (HHI) of the recipient country's debt crowdfunding market (with funding contributed by both retail and institutional investors). The independent variables, Regulation index and Adjusted Regulation Index, are, respectively, the raw and normalised measures of the regulatory clarity in the recipient country using indicator variables for different regulation provisions. The independent variable, Switcher, is 1 if the recipient country introduces its first regulation between 2015-2020, and 0 otherwise. All independent variables are described in the Appendix and are lagged by a year. All data is aggregated by recipient country and year separately from the 2015-2020 global surveys of crowdfunding. T-statistics are reported in parentheses. *** p<0.01, ** p<0.05, * p<0.1") addtext("Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')")   drop(i.Recipient_country i.year hhind_debfin_total) sortvar(P2P_Binary_pub_L_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip P2P_RegIndex_Adj_Switcher_recip     )  label  ctitle("Raw")
 

fracreg probit hhind_debfin_total P2P_RegIndex_pub_L_recip   P2P_RegIndex_Switcher_recip ///  
                RL_EST_L_recip /// 
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				i.year i.Recipient_country if year >= 2015 ,iterate(200)
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t9Am2,replace
indeplist
outreg2 t9Am2 using regression_submission_Table9A, append  st(coef tstat) auto(3) nonotes dta   addtext("Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')")   drop(i.Recipient_country i.year hhind_debfin_total) sortvar(P2P_Binary_pub_L_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip P2P_RegIndex_Adj_Switcher_recip     )  label   ctitle("Raw")


fracreg probit hhind_debfin_total P2P_RegIndex_pub_L_recip   P2P_RegIndex_Switcher_recip ///  
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
				i.year i.Recipient_country if year >= 2015 ,iterate(200)
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )		

est save t9Am3,replace
indeplist
outreg2 t9Am3 using regression_submission_Table9A, append  st(coef tstat) auto(3) nonotes dta   addtext("Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')")   drop(i.Recipient_country i.year hhind_debfin_total) sortvar(P2P_Binary_pub_L_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip P2P_RegIndex_Adj_Switcher_recip     )  label   ctitle("Raw")


fracreg probit hhind_debfin_total P2P_RegIndex_pub_L_recip   P2P_RegIndex_Switcher_recip ///  
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
				i.year i.Recipient_country if year >= 2015 ,iterate(200)
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex' - `always_P2P_RegIndex') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t9Am4,replace
indeplist
outreg2 t9Am4 using regression_submission_Table9A, append  st(coef tstat) auto(3) nonotes dta   addtext("Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')")   drop(i.Recipient_country i.year hhind_debfin_total) sortvar(P2P_Binary_pub_L_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip P2P_RegIndex_Adj_Switcher_recip     )  label   ctitle("Raw")

replace P2P_RegIndex_pub_L_recip = P2P_RegIndex_Adj_pub_L_recip
replace P2P_RegIndex_Switcher_recip = P2P_RegIndex_Adj_Switcher_recip

fracreg probit hhind_debfin_total P2P_RegIndex_pub_L_recip   P2P_RegIndex_Switcher_recip ///  
                RL_EST_L_recip /// 
                 lngdp_L_recip /// 
				i.year i.Recipient_country if year >= 2015 ,iterate(200)
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex_Adj',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex_Adj' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t9Am5,replace
indeplist
outreg2 t9Am5 using regression_submission_Table9A, append  st(coef tstat) auto(3) nonotes dta   addtext("Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')")   drop(i.Recipient_country i.year hhind_debfin_total) sortvar(P2P_Binary_pub_L_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip     )  label    ctitle("Adj")


fracreg probit hhind_debfin_total P2P_RegIndex_pub_L_recip   P2P_RegIndex_Switcher_recip ///  
                RL_EST_L_recip /// 
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				i.year i.Recipient_country if year >= 2015 ,iterate(200)
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex_Adj',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex_Adj' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t9Am6,replace
indeplist
outreg2 t9Am6 using regression_submission_Table9A, append  st(coef tstat) auto(3) nonotes dta   addtext("Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')")   drop(i.Recipient_country i.year hhind_debfin_total) sortvar(P2P_Binary_pub_L_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip     )  label    ctitle("Adj")


fracreg probit hhind_debfin_total P2P_RegIndex_pub_L_recip   P2P_RegIndex_Switcher_recip ///  
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
				i.year i.Recipient_country if year >= 2015 ,iterate(200)
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex_Adj',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex_Adj' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t9Am7,replace
indeplist
outreg2 t9Am7 using regression_submission_Table9A, append  st(coef tstat) auto(3) nonotes dta   addtext("Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')")   drop(i.Recipient_country i.year hhind_debfin_total) sortvar(P2P_Binary_pub_L_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip     )  label    ctitle("Adj")


fracreg probit hhind_debfin_total P2P_RegIndex_pub_L_recip   P2P_RegIndex_Switcher_recip ///  
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
				i.year i.Recipient_country if year >= 2015 ,iterate(200)
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex_Adj',0.001)
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex_Adj' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t9Am8,replace
indeplist
outreg2 t9Am8 using regression_submission_Table9A, append  st(coef tstat) auto(3) nonotes dta   addtext("Country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')")   drop(i.Recipient_country i.year hhind_debfin_total) sortvar(P2P_Binary_pub_L_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip     )  label    ctitle("Adj")
















***************************************************
***************************************************
*Table 10******************************************
***************************************************
***************************************************
***************************************************
cd "your directory"
use country_panel_data_final,clear

replace CC_PER_RNK_L_recip = 1 - CC_PER_RNK_L_recip/100
gen bank_power1_proxy_L = Bank_Spread_L_recip

bys Recipient_country (year): egen switcher_cc = mean(CC_PER_RNK_L_recip)  if Switcher_P2P_recip == 1 & year >= P2P_year_recip + 1 & year >= 2015 & year <= 2020 & P2P_year_recip!= 0
bys Recipient_country (year): replace switcher_cc = . if year != P2P_year_recip + 1


bys Recipient_country (year): egen switcher_sp = mean(bank_power1_proxy_L)  if Switcher_P2P_recip == 1 & year >= P2P_year_recip + 1 & year >= 2015 & year <= 2020 & P2P_year_recip!= 0
bys Recipient_country (year): replace switcher_sp = . if year != P2P_year_recip + 1


bys Recipient_country (year): egen switcher_procedure = mean(Proc_startup_pct_L_recip)  if Switcher_P2P_recip == 1 & year >= P2P_year_recip + 1 & year >= 2015 & year <= 2020 & P2P_year_recip!= 0

bys Recipient_country (year): replace switcher_procedure = . if year != P2P_year_recip + 1


bys Recipient_country (year): egen switcher_time = mean(Time_startup_pct_L_recip)  if Switcher_P2P_recip == 1 & year >= P2P_year_recip + 1 & year >= 2015 & year <= 2020 & P2P_year_recip!= 0

bys Recipient_country (year): replace switcher_time = . if year != P2P_year_recip + 1


bys Recipient_country (year): egen switcher_cost = mean(Cost_startup_pct_L_recip)  if Switcher_P2P_recip == 1 & year >= P2P_year_recip + 1 & year >= 2015 & year <= 2020 & P2P_year_recip!= 0

bys Recipient_country (year): replace switcher_cost = . if year != P2P_year_recip + 1

sum switcher_cc,detail
local switcher_cc_25th = r(p25)
local switcher_cc_75th = r(p75)

sum switcher_sp,detail
local switcher_sp_25th = r(p25)
local switcher_sp_75th = r(p75)

sum switcher_procedure, detail
local switcher_procedure_25th = r(p25)
local switcher_procedure_75th = r(p75)

sum switcher_time, detail
local switcher_time_25th = r(p25)
local switcher_time_75th = r(p75)

sum switcher_cost, detail
local switcher_cost_25th = r(p25)
local switcher_cost_75th = r(p75)

bys Recipient_country (year): egen switcher_P2P_RegIndex = mean(P2P_RegIndex_pub_L_recip)  if Switcher_P2P_recip == 1 & year >= P2P_year_recip + 1 & year >= 2015 & year <= 2020 & P2P_year_recip!= 0

bys Recipient_country (year): egen switcher_P2P_RegIndex_Adj = mean(P2P_RegIndex_Adj_pub_L_recip)  if Switcher_P2P_recip == 1 & year >= P2P_year_recip + 1 & year >= 2015 & year <= 2020 & P2P_year_recip!= 0


bys Recipient_country (year): replace switcher_P2P_RegIndex = . if year != P2P_year_recip + 1

bys Recipient_country (year): replace switcher_P2P_RegIndex_Adj =. if year != P2P_year_recip + 1


sum switcher_P2P_RegIndex 
local switcher_P2P_RegIndex = r(mean)

sum switcher_P2P_RegIndex_Adj
local switcher_P2P_RegIndex_Adj = r(mean)


*******************************************
*******************************************
*******************************************
*******************************************
*******************************************
*******************************************
*******************************************
*******************************************

 cd "your directory"
use country_panel_data_final,clear

replace PV_PER_RNK_L_recip = 1 - PV_PER_RNK_L_recip/100
gen P2P_RegIndex_pv = P2P_RegIndex_pub_L_recip*PV_PER_RNK_L_recip
gen P2P_RegIndex_Adj_pv = P2P_RegIndex_Adj_pub_L_recip*PV_PER_RNK_L_recip
label var P2P_RegIndex_pv "Regulation index (debt) X Politcal Instability"
label var P2P_RegIndex_Adj_pv "Regulation index (debt) X Politcal Instability"
label var PV_PER_RNK_L_recip "Politcal Instability"

replace CC_PER_RNK_L_recip = 1 - CC_PER_RNK_L_recip/100

gen bank_power1_proxy_L = Bank_Spread_L_recip

gen CC_PER_bank_power1_L = CC_PER_RNK_L_recip*bank_power1_proxy_L
label var CC_PER_bank_power1_L "Control of Corruption X Bank Spread"


gen P2P_RegIndex_cc = P2P_RegIndex_pub_L_recip*CC_PER_RNK_L_recip
gen P2P_RegIndex_Adj_cc = P2P_RegIndex_Adj_pub_L_recip*CC_PER_RNK_L_recip
label var P2P_RegIndex_cc "Regulation index (debt) X Control of Corruption"
label var P2P_RegIndex_Adj_cc "Regulation index (debt) X Control of Corruption"
label var CC_PER_RNK_L_recip "Control of Corruption"


gen P2P_RegIndex_sp = P2P_RegIndex_pub_L_recip*bank_power1_proxy_L
gen P2P_RegIndex_Adj_sp = P2P_RegIndex_Adj_pub_L_recip*bank_power1_proxy_L
label var P2P_RegIndex_sp "Regulation index (debt) X Bank Spread"
label var P2P_RegIndex_Adj_sp "Regulation index (debt) X Bank Spread"
label var bank_power1_proxy_L "Bank Spread"





gen P2P_RegIndex_ccsp = P2P_RegIndex_pub_L_recip*CC_PER_RNK_L_recip*bank_power1_proxy_L
gen P2P_RegIndex_Adj_ccsp = P2P_RegIndex_Adj_pub_L_recip*CC_PER_RNK_L_recip*bank_power1_proxy_L
label var P2P_RegIndex_ccsp "Regulation index (debt) X Control of Corruption X Bank Spread"
label var P2P_RegIndex_Adj_ccsp "Regulation index (debt) X Control of Corruption X Bank Spread"



gen P2P_RegIndex_proc = P2P_RegIndex_pub_L_recip*Proc_startup_pct_L_recip
gen P2P_RegIndex_Adj_proc = P2P_RegIndex_Adj_pub_L_recip*Proc_startup_pct_L_recip
label var P2P_RegIndex_proc "Regulation index (debt) X Proceudres required to start a business"
label var P2P_RegIndex_Adj_proc "Regulation index (debt) X Proceudres required to start a business"
label var Proc_startup_pct_L_recip "Proceudres required to start a business"


gen P2P_RegIndex_time = P2P_RegIndex_pub_L_recip*Time_startup_pct_L_recip
gen P2P_RegIndex_Adj_time = P2P_RegIndex_Adj_pub_L_recip*Time_startup_pct_L_recip
label var P2P_RegIndex_time "Regulation index (debt) X Time required to start a business"
label var P2P_RegIndex_Adj_time "Regulation index (debt) X Time required to start a business"
label var Time_startup_pct_L_recip "Time required to start a business"


gen P2P_RegIndex_cost = P2P_RegIndex_pub_L_recip*Cost_startup_pct_L_recip
gen P2P_RegIndex_Adj_cost = P2P_RegIndex_Adj_pub_L_recip*Cost_startup_pct_L_recip
label var P2P_RegIndex_cost "Regulation index (debt) X Cost required to start a business"
label var P2P_RegIndex_Adj_cost "Regulation index (debt) X Cost required to start a business"
label var Cost_startup_pct_L_recip "Cost required to start a business"

gen regulated = (P2P_RegIndex_pub_L_recip > 0)

label var regulated "Regulated (debt)"


forvalues i = 1/2 {
gen P2P_RegIndex_Switcher_peer`i' = P2P_RegIndex_pub_L_peer`i'*Switcher_P2P_recip
gen P2P_RegIndex_Adj_Switcher_peer`i' = P2P_RegIndex_Adj_pub_L_peer`i'*Switcher_P2P_recip
}


forvalues i = 1/2 {
gen P2P_RegIndex_peer`i'_pv = P2P_RegIndex_pub_L_peer`i'*PV_PER_RNK_L_recip
gen P2P_RegIndex_Adj_peer`i'_pv = P2P_RegIndex_Adj_pub_L_peer`i'*PV_PER_RNK_L_recip

gen P2P_RegIndex_peer`i'_cc = P2P_RegIndex_pub_L_peer`i'*CC_PER_RNK_L_recip
gen P2P_RegIndex_Adj_peer`i'_cc = P2P_RegIndex_Adj_pub_L_peer`i'*CC_PER_RNK_L_recip

gen P2P_RegIndex_peer`i'_sp = P2P_RegIndex_pub_L_peer`i'*bank_power1_proxy_L
gen P2P_RegIndex_Adj_peer`i'_sp = P2P_RegIndex_Adj_pub_L_peer`i'*bank_power1_proxy_L

gen P2P_RegIndex_peer`i'_ccsp = P2P_RegIndex_pub_L_peer`i'*CC_PER_RNK_L_recip*bank_power1_proxy_L
gen P2P_RegIndex_Adj_peer`i'_ccsp = P2P_RegIndex_Adj_pub_L_peer`i'*CC_PER_RNK_L_recip*bank_power1_proxy_L

gen P2P_RegIndex_peer`i'_proc = P2P_RegIndex_pub_L_peer`i'*Proc_startup_pct_L_recip
gen P2P_RegIndex_Adj_peer`i'_proc = P2P_RegIndex_Adj_pub_L_peer`i'*Proc_startup_pct_L_recip

gen P2P_RegIndex_peer`i'_time = P2P_RegIndex_pub_L_peer`i'*Time_startup_pct_L_recip
gen P2P_RegIndex_Adj_peer`i'_time = P2P_RegIndex_Adj_pub_L_peer`i'*Time_startup_pct_L_recip

gen P2P_RegIndex_peer`i'_cost = P2P_RegIndex_pub_L_peer`i'*Cost_startup_pct_L_recip
gen P2P_RegIndex_Adj_peer`i'_cost = P2P_RegIndex_Adj_pub_L_peer`i'*Cost_startup_pct_L_recip
}



label var regulated "Regulated (debt)"

label var P2P_RegIndex_pub_L_peer1 "Average Regulatory Index (debt) of Countries Located in the Same Sub-Region"
label var P2P_RegIndex_pub_L_peer2 "Average Regulatory Index (debt) of Countries within (-10,+10) Rule-of-Law Percentiles"


drop if year < 2015 | year > 2020
 
tabulate year, generate(year_dum)

drop year_dum3

**
drop Recipient_country

encode recipient_country, gen(Recipient_country)
xtset Recipient_country year


global main_ind P2P_RegIndex_pub_L_recip 

global main_ind1 $main_ind P2P_RegIndex_pv //model 4

global main_ind3 $main_ind P2P_RegIndex_proc //model 1

global main_ind4 $main_ind P2P_RegIndex_time //model 2

global main_ind5 $main_ind P2P_RegIndex_cost //model 3

global main_ind7 $main_ind P2P_RegIndex_cc P2P_RegIndex_sp P2P_RegIndex_ccsp //model 5

global ivs P2P_RegIndex_pub_L_peer1 P2P_RegIndex_pub_L_peer2

global ivs1 P2P_RegIndex_pub_L_peer1 P2P_RegIndex_pub_L_peer2 P2P_RegIndex_peer1_pv P2P_RegIndex_peer2_pv

global ivs3 P2P_RegIndex_pub_L_peer1 P2P_RegIndex_pub_L_peer2 P2P_RegIndex_peer1_proc P2P_RegIndex_peer2_proc

global ivs4 P2P_RegIndex_pub_L_peer1 P2P_RegIndex_pub_L_peer2 P2P_RegIndex_peer1_time P2P_RegIndex_peer2_time

global ivs5 P2P_RegIndex_pub_L_peer1 P2P_RegIndex_pub_L_peer2 P2P_RegIndex_peer1_cost P2P_RegIndex_peer2_cost

global ivs7 P2P_RegIndex_pub_L_peer1 P2P_RegIndex_pub_L_peer2 P2P_RegIndex_peer1_cc P2P_RegIndex_peer2_cc P2P_RegIndex_peer1_sp P2P_RegIndex_peer2_sp P2P_RegIndex_peer1_ccsp P2P_RegIndex_peer2_ccsp


global cov_2sls RL_EST_L_recip lngdp_L_recip  Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip  GC_LegalRights_L_recip GC_CreditInfo_L_recip RI_L_recip  Bank_C2A_L_recip  DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip Bank_NPL_L_recip lnMobilePhoneUsage_L_recip 

global cov_2sls1 RL_EST_L_recip lngdp_L_recip  Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip  GC_LegalRights_L_recip GC_CreditInfo_L_recip RI_L_recip  Bank_C2A_L_recip  DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip Bank_NPL_L_recip lnMobilePhoneUsage_L_recip  PV_PER_RNK_L_recip

global cov_2sls3 RL_EST_L_recip lngdp_L_recip  Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip  GC_LegalRights_L_recip GC_CreditInfo_L_recip RI_L_recip  Bank_C2A_L_recip  DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip Bank_NPL_L_recip lnMobilePhoneUsage_L_recip  Proc_startup_pct_L_recip

global cov_2sls4 RL_EST_L_recip lngdp_L_recip  Time_startup_pct_L_recip Cost_startup_L_recip Tax_income_pct_L_recip  GC_LegalRights_L_recip GC_CreditInfo_L_recip RI_L_recip  Bank_C2A_L_recip  DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip Bank_NPL_L_recip lnMobilePhoneUsage_L_recip  

global cov_2sls5 RL_EST_L_recip lngdp_L_recip  Time_startup_L_recip Cost_startup_pct_L_recip Tax_income_pct_L_recip  GC_LegalRights_L_recip GC_CreditInfo_L_recip RI_L_recip  Bank_C2A_L_recip  DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip Bank_NPL_L_recip lnMobilePhoneUsage_L_recip  

global cov_2sls7 RL_EST_L_recip lngdp_L_recip  Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip  GC_LegalRights_L_recip GC_CreditInfo_L_recip RI_L_recip  Bank_C2A_L_recip  DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip Bank_NPL_L_recip lnMobilePhoneUsage_L_recip  CC_PER_RNK_L_recip bank_power1_proxy_L CC_PER_bank_power1_L


global cov_ivs   total_afdebt_growth_peer1 total_npdebt_growth_peer1 total_afdebt_growth_peer2 total_npdebt_growth_peer2  lntotal_afdebt_level_peer1  lntotal_npdebt_level_peer1       lntotal_afdebt_level_peer2    lntotal_npdebt_level_peer2 


***********************
***********************
***********************

global baseline $main_ind $cov_2sls

global model1 $main_ind1 $cov_2sls1

global model3 $main_ind3 $cov_2sls3

global model4 $main_ind4 $cov_2sls4

global model5 $main_ind5 $cov_2sls5

global model7 $main_ind7 $cov_2sls7

cap drop cluster_group 
egen cluster_group = group(MajorRegion_recip year)


encode MajorRegion_recip, gen(MajorRegion_recip_encode)
encode SubRegion_recip, gen(SubRegion_recip_encode)

***********************
***********************
***********************
***********************
***********************

***********************
****Panel A************
***********************
***********************

reghdfe lntotal_adfin_dom $model3 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

est save t10Am1,replace
indeplist

outreg2 t10Am1 using regression_submission_Table10A, replace  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes") adjr2 label keep(`r(X)') ctitle("Raw") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_proc PV_EST_L_recip P2P_RegIndex_proc Proc_startup_L_recip P2P_RegIndex_Procedures Procedures_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip) title("Table 10 Panel A: This table reports the regression result, with the interaction term being proxies for the strengeth of regulatory clarity. The dependent variable is the domestic debt crowdfunding volume.")

reghdfe lntotal_adfin_dom $model4 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

est save t10Am2,replace
indeplist

outreg2 t10Am2 using regression_submission_Table10A, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_proc PV_EST_L_recip P2P_RegIndex_proc Proc_startup_L_recip P2P_RegIndex_Procedures Procedures_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)


reghdfe lntotal_adfin_dom $model5 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

est save t10Am3,replace
indeplist

outreg2 t10Am3 using regression_submission_Table10A, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_proc PV_EST_L_recip P2P_RegIndex_proc Proc_startup_L_recip P2P_RegIndex_Procedures Procedures_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)



reghdfe lntotal_adfin_dom $model1 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
 
est save t3m4,replace
indeplist

outreg2 t10Am4 using regression_submission_Table10A, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_proc PV_EST_L_recip P2P_RegIndex_proc Proc_startup_L_recip P2P_RegIndex_Procedures Procedures_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)


reghdfe lntotal_adfin_dom $model7 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

est save t10Am5,replace
indeplist

outreg2 t10Am5 using regression_submission_Table10A, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_proc PV_EST_L_recip P2P_RegIndex_proc Proc_startup_L_recip P2P_RegIndex_Procedures Procedures_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)



preserve 
replace P2P_RegIndex_pub_L_recip = P2P_RegIndex_Adj_pub_L_recip
replace P2P_RegIndex_proc = P2P_RegIndex_Adj_proc
replace P2P_RegIndex_time = P2P_RegIndex_Adj_time
replace P2P_RegIndex_cost = P2P_RegIndex_Adj_cost
replace P2P_RegIndex_pv = P2P_RegIndex_Adj_pv
replace P2P_RegIndex_cc = P2P_RegIndex_Adj_cc
replace P2P_RegIndex_sp = P2P_RegIndex_Adj_sp
replace P2P_RegIndex_ccsp = P2P_RegIndex_Adj_ccsp

reghdfe lntotal_adfin_dom $model3 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

est save t10Am6,replace
indeplist

outreg2 t10Am6 using regression_submission_Table10A, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_proc PV_EST_L_recip P2P_RegIndex_proc Proc_startup_L_recip P2P_RegIndex_Procedures Procedures_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)


reghdfe lntotal_adfin_dom $model4 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

est save t10Am7,replace
indeplist

outreg2 t10Am7 using regression_submission_Table10A, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_proc PV_EST_L_recip P2P_RegIndex_proc Proc_startup_L_recip P2P_RegIndex_Procedures Procedures_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)


reghdfe lntotal_adfin_dom $model5 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

est save t10Am8,replace
indeplist

outreg2 t10Am8 using regression_submission_Table10A, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_proc PV_EST_L_recip P2P_RegIndex_proc Proc_startup_L_recip P2P_RegIndex_Procedures Procedures_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)


reghdfe lntotal_adfin_dom $model1 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
 
est save t10Am9,replace
indeplist

outreg2 t10Am9 using regression_submission_Table10A, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_proc PV_EST_L_recip P2P_RegIndex_proc Proc_startup_L_recip P2P_RegIndex_Procedures Procedures_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)

reghdfe lntotal_adfin_dom $model7 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

est save t10Am10,replace
indeplist

outreg2 t10Am10 using regression_submission_Table10A, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_proc PV_EST_L_recip P2P_RegIndex_proc Proc_startup_L_recip P2P_RegIndex_Procedures Procedures_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)



restore 



****************************************
****************************************
****************************************
*Panel B*******************************
****************************************
****************************************


reghdfe lntotal_adnum_dom $model3 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)


est save t10Bm1,replace
indeplist

outreg2 t10Bm1 using regression_submission_Table10B, replace  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes") adjr2 label keep(`r(X)') ctitle("Raw") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_proc PV_EST_L_recip P2P_RegIndex_proc Proc_startup_L_recip P2P_RegIndex_Procedures Procedures_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip) title("Table 10 Panel A: This table reports the regression result, with the interaction term being proxies for the strengeth of regulatory clarity. The dependent variable is the logged number of domestic debt platforms")


 

reghdfe lntotal_adnum_dom $model4 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)


est save t10Bm2,replace
indeplist

outreg2 t10Bm2 using regression_submission_Table10B, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_proc PV_EST_L_recip P2P_RegIndex_proc Proc_startup_L_recip P2P_RegIndex_Procedures Procedures_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)



reghdfe lntotal_adnum_dom $model5 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)


est save t10Bm3,replace
indeplist

outreg2 t10Bm3 using regression_submission_Table10B, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_proc PV_EST_L_recip P2P_RegIndex_proc Proc_startup_L_recip P2P_RegIndex_Procedures Procedures_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)



reghdfe lntotal_adnum_dom $model1 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) 
 
est save t10Bm4,replace
indeplist

outreg2 t10Bm4 using regression_submission_Table10B, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_proc PV_EST_L_recip P2P_RegIndex_proc Proc_startup_L_recip P2P_RegIndex_Procedures Procedures_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)
 
 
 

reghdfe lntotal_adnum_dom $model7 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)


est save t10Bm5,replace
indeplist

outreg2 t10Bm5 using regression_submission_Table10B, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_proc PV_EST_L_recip P2P_RegIndex_proc Proc_startup_L_recip P2P_RegIndex_Procedures Procedures_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)





 

preserve
replace P2P_RegIndex_pub_L_recip = P2P_RegIndex_Adj_pub_L_recip
replace P2P_RegIndex_proc = P2P_RegIndex_Adj_proc
replace P2P_RegIndex_time = P2P_RegIndex_Adj_time
replace P2P_RegIndex_cost = P2P_RegIndex_Adj_cost
replace P2P_RegIndex_pv = P2P_RegIndex_Adj_pv
replace P2P_RegIndex_cc = P2P_RegIndex_Adj_cc
replace P2P_RegIndex_sp = P2P_RegIndex_Adj_sp
replace P2P_RegIndex_ccsp = P2P_RegIndex_Adj_ccsp




reghdfe lntotal_adnum_dom $model3 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)


est save t10Bm6,replace
indeplist

outreg2 t10Bm6 using regression_submission_Table10B, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_proc PV_EST_L_recip P2P_RegIndex_proc Proc_startup_L_recip P2P_RegIndex_Procedures Procedures_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)


reghdfe lntotal_adnum_dom $model4 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

est save t10Bm7,replace
indeplist

outreg2 t10Bm7 using regression_submission_Table10B, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_proc PV_EST_L_recip P2P_RegIndex_proc Proc_startup_L_recip P2P_RegIndex_Procedures Procedures_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)



reghdfe lntotal_adnum_dom $model5 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

est save t10Bm8,replace
indeplist

outreg2 t10Bm8 using regression_submission_Table10B, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_proc PV_EST_L_recip P2P_RegIndex_proc Proc_startup_L_recip P2P_RegIndex_Procedures Procedures_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)




reghdfe lntotal_adnum_dom $model1 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

est save t10Bm9,replace
indeplist

outreg2 t10Bm9 using regression_submission_Table10B, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_proc PV_EST_L_recip P2P_RegIndex_proc Proc_startup_L_recip P2P_RegIndex_Procedures Procedures_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)



reghdfe lntotal_adnum_dom $model7 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

est save t10Bm10,replace
indeplist

outreg2 t10Bm10 using regression_submission_Table10B, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_proc PV_EST_L_recip P2P_RegIndex_proc Proc_startup_L_recip P2P_RegIndex_Procedures Procedures_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)

restore
 
 
 
 

***************************************************
*Table 12******************************************
***************************************************
*Panel A*******************************************
***************************************************
**Basicaly first-stage regression for 2SLS*********

*********************************************
*********************************************
*********************************************
*********************************************
*********************************************
*********************************************
*********************************************
drop if AlwaysSwitcher_P2P == 1
drop if year < 2015

*********************************************
*********************************************
*********************************************
*********************************************
*********************************************
*********************************************
reghdfe $main_ind $ivs $cov_2sls $cov_ivs , a(i.Recipient_country i.year)  vce(cluster cluster_group)

keep if e(sample)

test P2P_RegIndex_pub_L_peer1 + P2P_RegIndex_pub_L_peer2 = 0 
local m1 = r(F)
local p1 = r(p)

est save t12Am1,replace
indeplist

outreg2 t12Am1  using regression_submission_Table12A, replace  st(coef tstat) auto(3) nonotes dta  adjr2 title("Table 12 Panel A: First-Stage Regressions. This table reports the first stage regression results of 2SLS. The dependent variable is the reglatory index. All data is aggregated by country and year separately from the 2015-2020 global surveys of crowdfunding. Heteroscedasticity-consistent cluster(cluster_group) standard errors are clustered by country and year, following Thompson (2011). T-statistics are reported in parentheses. *** p<0.01, ** p<0.05, * p<0.1") addtext("Country FE & Year FE", "Yes","F-Test:",`m1',"p-value","(`p1')")   sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/)  ctitle("Raw")


preserve 
local types "RegIndex"
foreach type in `types' {
replace P2P_`type'_pub_L_recip = P2P_`type'_Adj_pub_L_recip

forvalues i = 1/2 {
replace P2P_`type'_pub_L_peer`i' = P2P_`type'_Adj_pub_L_peer`i'
}
}

reghdfe $main_ind $ivs $cov_2sls $cov_ivs , a(i.Recipient_country i.year)  vce(cluster cluster_group)

test P2P_RegIndex_pub_L_peer1 + P2P_RegIndex_pub_L_peer2 = 0 
local m1 = r(F)
local p1 = r(p)

est save t12Am2,replace
indeplist

outreg2 t12Am2 using regression_submission_Table12A, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","F-Test:",`m1',"p-value","(`p1')")   sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/)  ctitle("Adj")


restore 




***************************************************
*Table 12******************************************
***************************************************
*Panel B*******************************************
***************************************************
*Second-stage regression of 2SLS*******************
***************************************************

ivreg2 lntotal_adfin_dom ($main_ind = $ivs) $cov_2sls $cov_ivs i.year i.Recipient_country if year >= 2015,    cluster(cluster_group)

local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Bm1,replace
indeplist

outreg2 t12Bm1 using regression_submission_Table12B, replace  st(coef tstat) auto(3) nonotes dta  adjr2 title("Table 12 Panel B: Second-Stage Regression. It reports the 2SLS regression result, where the dependent variable is the domestic crowdfunding volume") addtext("Country FE & Year FE", "Yes","Overidentification Test:",`m4',"p-value","(`p4')","Average Effect of Introducing Regulation",`m1',"p-value (of Measure 1)","(`p1')") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_pv PV_EST_L_recip P2P_RegIndex_cost Proc_startup_L_recip P2P_RegIndex_cost Time_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)  label  keep(`r(X)')  eqdrop(/)  ctitle("Raw-Total")

ivreg2 lnretail_adfin_dom ($main_ind = $ivs) $cov_2sls $cov_ivs i.year i.Recipient_country if year >= 2015,    cluster(cluster_group)

local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Bm2,replace
indeplist

outreg2 t12Bm2 using regression_submission_Table12B, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","F-Test:",`m1',"p-value","(`p1')")   sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/)  ctitle("Raw-Retail")


ivreg2 lninst_adfin_dom ($main_ind = $ivs) $cov_2sls $cov_ivs i.year i.Recipient_country if year >= 2015,    cluster(cluster_group)

local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Bm3,replace
indeplist

outreg2 t12Bm3 using regression_submission_Table12B, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","F-Test:",`m1',"p-value","(`p1')")   sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/)  ctitle("Raw-Inst")


preserve 
local types "RegIndex"
foreach type in `types' {
replace P2P_`type'_pub_L_recip = P2P_`type'_Adj_pub_L_recip

forvalues i = 1/2 {
replace P2P_`type'_pub_L_peer`i' = P2P_`type'_Adj_pub_L_peer`i'
}
}

ivreg2 lntotal_adfin_dom ($main_ind = $ivs) $cov_2sls $cov_ivs i.year i.Recipient_country if year >= 2015,    cluster(cluster_group)

local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Bm4,replace
indeplist

outreg2 t12Bm4 using regression_submission_Table12B, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","F-Test:",`m1',"p-value","(`p1')")   sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/)  ctitle("Adj-Total")



ivreg2 lnretail_adfin_dom ($main_ind = $ivs) $cov_2sls $cov_ivs i.year i.Recipient_country if year >= 2015,    cluster(cluster_group)

local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Bm5,replace
indeplist

outreg2 t12Bm5 using regression_submission_Table12B, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","F-Test:",`m1',"p-value","(`p1')")   sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/)  ctitle("Adj-Retail")


ivreg2 lninst_adfin_dom ($main_ind = $ivs) $cov_2sls $cov_ivs i.year i.Recipient_country if year >= 2015,    cluster(cluster_group)

local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Bm6,replace
indeplist

outreg2 t12Bm6 using regression_submission_Table12B, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","F-Test:",`m1',"p-value","(`p1')")   sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/)  ctitle("Adj-Inst")


restore 


***************************************************
*Table 12******************************************
***************************************************
*Panel C*******************************************
***************************************************


ivreg2 lntotal_adnum_dom ($main_ind = $ivs) $cov_2sls $cov_ivs i.year i.Recipient_country if year >= 2015,    cluster(cluster_group)

local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Cm1,replace
indeplist

outreg2 t12Cm1 using regression_submission_Table12C, replace  st(coef tstat) auto(3) nonotes dta  adjr2 title("Table 12 Panel C: Second-Stage Regression. It reports the 2SLS regression result, where the dependent variable is the number of domestic crowdfunding platforms") addtext("Country FE & Year FE", "Yes","Overidentification Test:",`m4',"p-value","(`p4')","Average Effect of Introducing Regulation",`m1',"p-value (of Measure 1)","(`p1')") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_pv PV_EST_L_recip P2P_RegIndex_cost Proc_startup_L_recip P2P_RegIndex_cost Time_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)  label  keep(`r(X)')  eqdrop(/)  ctitle("Raw-Total")

ivreg2 lnretail_adnum_dom ($main_ind = $ivs) $cov_2sls $cov_ivs i.year i.Recipient_country if year >= 2015,    cluster(cluster_group)

local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Cm2,replace
indeplist

outreg2 t12Cm2 using regression_submission_Table12C, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","F-Test:",`m1',"p-value","(`p1')")   sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/)  ctitle("Raw-Retail")


ivreg2 lninst_adnum_dom ($main_ind = $ivs) $cov_2sls $cov_ivs i.year i.Recipient_country if year >= 2015,    cluster(cluster_group)

local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Cm3,replace
indeplist

outreg2 t12Cm3 using regression_submission_Table12C, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","F-Test:",`m1',"p-value","(`p1')")   sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/)  ctitle("Raw-Inst")


preserve 
local types "RegIndex"
foreach type in `types' {
replace P2P_`type'_pub_L_recip = P2P_`type'_Adj_pub_L_recip

forvalues i = 1/2 {
replace P2P_`type'_pub_L_peer`i' = P2P_`type'_Adj_pub_L_peer`i'
}
}

ivreg2 lntotal_adnum_dom ($main_ind = $ivs) $cov_2sls $cov_ivs i.year i.Recipient_country if year >= 2015,    cluster(cluster_group)

local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Cm4,replace
indeplist

outreg2 t12Cm4 using regression_submission_Table12C, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","F-Test:",`m1',"p-value","(`p1')")   sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/)  ctitle("Adj-Total")



ivreg2 lnretail_adnum_dom ($main_ind = $ivs) $cov_2sls $cov_ivs i.year i.Recipient_country if year >= 2015,    cluster(cluster_group)

local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Cm5,replace
indeplist

outreg2 t12Cm5 using regression_submission_Table12C, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","F-Test:",`m1',"p-value","(`p1')")   sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/)  ctitle("Adj-Retail")


ivreg2 lninst_adnum_dom ($main_ind = $ivs) $cov_2sls $cov_ivs i.year i.Recipient_country if year >= 2015,    cluster(cluster_group)

local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
*raw joint test, which is the same as the differece in the incremental effects received by switcher and those never regulated 
test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Cm6,replace
indeplist

outreg2 t12Cm6 using regression_submission_Table12C, append  st(coef tstat) auto(3) nonotes dta  adjr2  addtext("Country FE & Year FE", "Yes","F-Test:",`m1',"p-value","(`p1')")   sortvar(P2P_Binary_pub_L_recip Switcher_P2P_recip P2P_Binary_Switcher_recip  P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Adj_Switcher_recip     )  label  keep(`r(X)')  eqdrop(/)  ctitle("Adj-Inst")


restore 











***************************************************
*Table 12******************************************
***************************************************
*Panel D*******************************************
***************************************************
*Mechanism Analysis********************************
***************************************************

ivreg2 lntotal_adfin_dom ($main_ind3 = $ivs3) $cov_2sls3 $cov_ivs i.year i.Recipient_country if year >= 2015,   cluster(cluster_group)

overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Dm1,replace
indeplist

outreg2 t12Dm1  using regression_submission_Table12D, replace  st(coef tstat) auto(3) nonotes dta  adjr2 title("Table 19: This table is a part of robustness check - mechanism analysis. It reports the 2SLS regression result, where the dependent variable is the domestic crowdfunding volume.") addtext("Country FE & Year FE", "Yes","Overidentification Test:",`m4',"p-value","(`p4')") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_pv PV_EST_L_recip P2P_RegIndex_cost Proc_startup_L_recip P2P_RegIndex_cost Time_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)  label  keep(`r(X)')  eqdrop(/)  ctitle("Raw")



ivreg2 lntotal_adfin_dom ($main_ind4 = $ivs4) $cov_2sls4 $cov_ivs i.year i.Recipient_country if year >= 2015,   cluster(cluster_group)
 
overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Dm2,replace
indeplist

outreg2 t12Dm2 using regression_submission_Table12D, append  st(coef tstat) auto(3) nonotes dta  adjr2 addtext("Country FE & Year FE", "Yes","Overidentification Test:",`m4',"p-value","(`p4')")  sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_pv PV_EST_L_recip P2P_RegIndex_cost Proc_startup_L_recip P2P_RegIndex_cost Time_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)   label  keep(`r(X)')  eqdrop(/)  ctitle("Raw")



ivreg2 lntotal_adfin_dom ($main_ind5 = $ivs5) $cov_2sls5 $cov_ivs i.year i.Recipient_country if year >= 2015, cluster(cluster_group)
 

overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Dm3,replace
indeplist

outreg2 t12Dm3 using regression_submission_Table12D, append  st(coef tstat) auto(3) nonotes dta  adjr2 addtext("Country FE & Year FE", "Yes","Overidentification Test:",`m4',"p-value","(`p4')") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_pv PV_EST_L_recip P2P_RegIndex_cost Proc_startup_L_recip P2P_RegIndex_cost Time_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)   label  keep(`r(X)')  eqdrop(/)  ctitle("Raw")

 
 

ivreg2 lntotal_adfin_dom ($main_ind1 = $ivs1) $cov_2sls1 $cov_ivs i.year i.Recipient_country if year >= 2015,    cluster(cluster_group)


overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Dm4,replace
indeplist

outreg2 t12Dm4 using regression_submission_Table12D, append  st(coef tstat) auto(3) nonotes dta  adjr2 addtext("Country FE & Year FE", "Yes","Overidentification Test:",`m4',"p-value","(`p4')") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_pv PV_EST_L_recip P2P_RegIndex_cost Proc_startup_L_recip P2P_RegIndex_cost Time_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)   label  keep(`r(X)')  eqdrop(/)  ctitle("Raw")





ivreg2 lntotal_adfin_dom ($main_ind7 = $ivs7) $cov_2sls7 $cov_ivs i.year i.Recipient_country if year >= 2015,   cluster(cluster_group)


overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Dm5,replace
indeplist

outreg2 t12Dm5 using regression_submission_Table12D, append  st(coef tstat) auto(3) nonotes dta  adjr2 addtext("Country FE & Year FE", "Yes","Overidentification Test:",`m4',"p-value","(`p4')") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_pv PV_EST_L_recip P2P_RegIndex_cost Proc_startup_L_recip P2P_RegIndex_cost Time_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)   label  keep(`r(X)')  eqdrop(/)  ctitle("Raw")
 

preserve 
local types "RegIndex"
foreach type in `types' {
replace P2P_`type'_pub_L_recip = P2P_`type'_Adj_pub_L_recip
replace P2P_`type'_pub_L_peer1 = P2P_`type'_Adj_pub_L_peer1
replace P2P_`type'_pub_L_peer2 = P2P_`type'_Adj_pub_L_peer2
}

local types "pv cc sp ccsp proc time cost"
foreach type in `types' {
replace P2P_RegIndex_`type' =  P2P_RegIndex_Adj_`type' 
replace  P2P_RegIndex_peer1_`type' = P2P_RegIndex_Adj_peer1_`type'
replace  P2P_RegIndex_peer2_`type' = P2P_RegIndex_Adj_peer2_`type'
}


ivreg2 lntotal_adfin_dom ($main_ind3 = $ivs3) $cov_2sls3 $cov_ivs i.year i.Recipient_country if year >= 2015,   cluster(cluster_group)

overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Dm6,replace
indeplist

outreg2 t12Dm6 using regression_submission_Table12D, append  st(coef tstat) auto(3) nonotes dta  adjr2 addtext("Country FE & Year FE", "Yes","Overidentification Test:",`m4',"p-value","(`p4')") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_pv PV_EST_L_recip P2P_RegIndex_cost Proc_startup_L_recip P2P_RegIndex_cost Time_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)   label  keep(`r(X)')  eqdrop(/)  ctitle("Adj")



ivreg2 lntotal_adfin_dom ($main_ind4 = $ivs4) $cov_2sls4 $cov_ivs i.year i.Recipient_country if year >= 2015,   cluster(cluster_group)
 

overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Dm7,replace
indeplist

outreg2 t12Dm7 using regression_submission_Table12D, append  st(coef tstat) auto(3) nonotes dta  adjr2 addtext("Country FE & Year FE", "Yes","Overidentification Test:",`m4',"p-value","(`p4')") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_pv PV_EST_L_recip P2P_RegIndex_cost Proc_startup_L_recip P2P_RegIndex_cost Time_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)   label  keep(`r(X)')  eqdrop(/)  ctitle("Adj")



ivreg2 lntotal_adfin_dom ($main_ind5 = $ivs5) $cov_2sls5 $cov_ivs i.year i.Recipient_country if year >= 2015,   cluster(cluster_group)
 

overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Dm8,replace
indeplist

outreg2 t12Dm8 using regression_submission_Table12D, append  st(coef tstat) auto(3) nonotes dta  adjr2 addtext("Country FE & Year FE", "Yes","Overidentification Test:",`m4',"p-value","(`p4')") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_pv PV_EST_L_recip P2P_RegIndex_cost Proc_startup_L_recip P2P_RegIndex_cost Time_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)   label  keep(`r(X)')  eqdrop(/)  ctitle("Adj")

 
ivreg2 lntotal_adfin_dom ($main_ind1 = $ivs1) $cov_2sls1 $cov_ivs i.year i.Recipient_country if year >= 2015,    cluster(cluster_group)

overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Dm9,replace
indeplist

outreg2 t12Dm9 using regression_submission_Table12D, append  st(coef tstat) auto(3) nonotes dta  adjr2 addtext("Country FE & Year FE", "Yes","Overidentification Test:",`m4',"p-value","(`p4')") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_pv PV_EST_L_recip P2P_RegIndex_cost Proc_startup_L_recip P2P_RegIndex_cost Time_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)   label  keep(`r(X)')  eqdrop(/)  ctitle("Adj")


  
ivreg2 lntotal_adfin_dom ($main_ind7 = $ivs7) $cov_2sls7 $cov_ivs  i.year i.Recipient_country if year >= 2015,  cluster(cluster_group)

overid
local m4 = round(r(j_oid),0.001)
local p4 = cond(r(p_oid)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p_oid)'''"  )

est save t12Dm10,replace
indeplist

outreg2 t12Dm10 using regression_submission_Table12D, append  st(coef tstat) auto(3) nonotes dta  adjr2 addtext("Country FE & Year FE", "Yes","Overidentification Test:",`m4',"p-value","(`p4')") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_pv PV_EST_L_recip P2P_RegIndex_cost Proc_startup_L_recip P2P_RegIndex_cost Time_startup_L_recip P2P_RegIndex_cost Cost_startup_L_recip)   label  keep(`r(X)')  eqdrop(/)  ctitle("Adj")
 
 
restore 

 

 

*****************************
*****PSM: *******************
*****************************


***************************************************
*Table 11******************************************
***************************************************
*Panel A*******************************************
***************************************************
**First-stage regression
cd "your directory"
use country_panel_data_final, clear

 
keep if year >= 2015

tab year, gen(year_)

encode SubRegion_recip, gen(subregion_recip)

tempfile pre_psm
save `pre_psm'

bys Recipient_country (year): gen Treated = (P2P_year_recip > 0 & P2P_year_recip != 2020)

*generate propensity score
logit P2P_Binary_pub_recip  /// 
lntotal_adfin_agg_L ///
lntotal_adnum_agg_L ///
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip  ///
                i.year 

est save t11Am1,replace
indeplist

outreg2 t11Am1 using regression_submission_Table11A, replace  st(coef tstat) auto(3) nonotes dta   addtext("Constant","Yes","Year FE", "Yes","Pseudo-R2","`e(r2_p)'")   drop(year_* P2P_Binary_pub_recip)  label   eqdrop(/)  cti("pre-match") title("Table 49: This table presents estimates from the Logit model used to estimate propensity scores for countries in the treatment and control groups. The dependent variable is the introduction of explicit crowdfunding regulation in a country, prior to matching using a PSM approach with optimal fixed ratio matching. T-statistics are reported in parentheses. *** p<0.01, ** p<0.05, * p<0.1")

predict pr
sum pr //sd of propensity score is 0.33
forvalues i = 2015/2020 {
gen pr_`i' = pr if year == `i'
replace pr_`i' = . if year != `i'
}

bys Recipient_country (year): replace P2P_Binary_pub_recip = 0 if year != P2P_year_recip
bys Recipient_country (year): replace P2P_Binary_pub_recip = 1 if P2P_RegIndex_pub_recip[_n] > P2P_RegIndex_pub_recip[_n-1] & P2P_RegIndex_pub_recip[_n] != 0

bys Recipient_country (year): keep if (P2P_Binary_pub_recip == 1  & Treated == 1) |  (Treated == 0 & P2P_year_recip != 2020)
//we do not look for control countries that are treated in 2020, because their regulation indicator is 1 only starting from 2021 in the main regression.

drop if AlwaysSwitcher_P2P == 1 

forvalues i = 2015/2020 {
psmatch2 Treated if year == `i', p(pr_`i') common neighbor(1) caliper(0.066) noreplacement

ren _treated _`i'treated
ren _support _`i'support
ren _pscore _`i'pscore
ren _weight _`i'weight
ren _id _`i'id
ren _n1 _`i'n1
ren _nn _`i'nn
ren _pdif _`i'pdif
}

gen _weight = (_2015weight == 1 | _2016weight == 1 | _2017weight == 1 | _2018weight == 1 | _2019weight == 1 | _2020weight == 1)

gen _treated = (_2015treated == 1 | _2016treated == 1 | _2017treated == 1 | _2018treated == 1 | _2019treated == 1 | _2020treated == 1)

*keep only matched pairs 
keep if _weight == 1
 
table Treated
table Treated year
*prepare for regression

gen matched_year = year

merge 1:1 recipient_country year using `pre_psm'
drop _merge

bys recipient_country (matched_year): replace matched_year = matched_year[1]

bys recipient_country (_weight): replace _weight = _weight[1]
bys recipient_country (_treated): replace _treated = _treated[1]
bys recipient_country (_weight): replace _weight = 0 if _weight == . 
bys recipient_country (_treated): replace _treated = 0 if _treated == .

drop Treated
bys Recipient_country (year): gen Treated = (P2P_year_recip > 0 )

keep if _weight == 1

table P2P_Binary_pub_L_recip

cd "your directory"
save psm_matched_all_regulations_v3.dta,replace



**post-match regression results
***************************************************
*Table 11******************************************
***************************************************
*Panel C*******************************************
***************************************************
cd "your directory"
use psm_matched_all_regulations_v3, clear
 
reghdfe lntotal_adfin_dom P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip  ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)

test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t11Cm1,replace
indeplist

outreg2 t11Cm1 using regression_submission_Table11C, replace  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Raw") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip) title("Table Panel C Part I: This table reports the estimation results based on the PSM-matched samples. The dependent variable in model (1) and (4) is the domestic debt crowdfunding volume contributed by both retail and institutional investors, in model (2) and (5) is contributed by retail investors, and in model (3) and (6) is contributed by institutional investors. The regulation variables include the level of the regulatory index, and the adjusted regulatory index, respectively. The level and adjusted level of the regulatory index are measures of the regulatory clarity in the country using indicator variables for different dimensions as in Table 3. All independent variables are described in the Appendix and are lagged by a year. All regressions include country and year fixed effects. Heteroscedasticity-consistent robust standard errors are clustered by country and year, following Thompson (2011). *** p<0.01, ** p<0.05, * p<0.1")


reghdfe lnretail_adfin_dom P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)

test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
est save t11Cm2,replace
indeplist

outreg2 t11Cm2 using regression_submission_Table11C, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Raw") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)
 


reghdfe lninst_adfin_dom P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)

test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
 
 est save t11Cm3,replace
indeplist

outreg2 t11Cm3 using regression_submission_Table11C, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Raw") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)

 
preserve
replace P2P_RegIndex_pub_L_recip = P2P_RegIndex_Adj_pub_L_recip

reghdfe lntotal_adfin_dom P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t11Cm4,replace
indeplist

outreg2 t11Cm4 using regression_submission_Table11C, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)

 
 *
 
reghdfe lnretail_adfin_dom P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

 
est save t11Cm5,replace
indeplist

outreg2 t11Cm5 using regression_submission_Table11C, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)


 *
 
reghdfe lninst_adfin_dom P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t11Cm6,replace
indeplist

outreg2 t11Cm6 using regression_submission_Table11C, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)


restore

***************************************************
*Table 11******************************************
***************************************************
*Panel D*******************************************
***************************************************
****dep variable: # of platforms
reghdfe lntotal_adnum_dom P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)

test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )


 est save t11Dm1,replace
indeplist

outreg2 t11Dm1 using regression_submission_Table11D, replace  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Raw") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip) title("Table 11 Panel C Part I: This table reports the estimation results based on the PSM-matched samples. The dependent variable in model (1) and (4) is the number of domestic debt crowdfunding platforms serving both retail and institutional investors, in model (2) and (5) is the number of those serving retail investors, and in model (3) and (6) is the number of those serving institutional investors. The regulation variables include the level of the regulatory index, and the adjusted regulatory index, respectively. The level and adjusted level of the regulatory index are measures of the regulatory clarity in the country using indicator variables for different dimensions as in Table 3. All independent variables are described in the Appendix and are lagged by a year. All regressions include country and year fixed effects. Heteroscedasticity-consistent robust standard errors are clustered by country and year, following Thompson (2011). *** p<0.01, ** p<0.05, * p<0.1")


reghdfe lnretail_adnum_dom P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)

test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t11Dm2,replace
indeplist

outreg2 t11Dm2 using regression_submission_Table11D, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Raw") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)
 
 
reghdfe lninst_adnum_dom P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)

test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t11Dm3,replace
indeplist

outreg2 t11Dm3 using regression_submission_Table11D, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Raw") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)
 
preserve
replace P2P_RegIndex_pub_L_recip = P2P_RegIndex_Adj_pub_L_recip


reghdfe lntotal_adnum_dom P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
 
est save t11Dm4,replace
indeplist

outreg2 t11Dm4 using regression_submission_Table11D, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)
 
*


 
reghdfe lnretail_adnum_dom P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

 
est save t11Dm5,replace
indeplist

outreg2 t11Dm5 using regression_submission_Table11D, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)
 
 
*



reghdfe lninst_adnum_dom P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip ///
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test P2P_RegIndex_pub_L_recip*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t11Dm6,replace
indeplist

outreg2 t11Dm6 using regression_submission_Table11D, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)


restore 




/*check whether it is any regulation or regulatory clarity that matters*/
***************************************************
*Table 11******************************************
***************************************************
*Panel E*******************************************
***************************************************
gen regulated = (P2P_RegIndex_pub_L_recip > 0)

label var regulated "Regulated"
****dep variable: volume  //note: switcher variable is dropped because I only kept obs for switching countries that are after the introduction of regulation
reghdfe lntotal_adfin_dom regulated P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip  ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
test _b[regulated] + _b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
 
est save t11Em1,replace
indeplist

outreg2 t11Em1 using regression_submission_Table11E, replace  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Raw") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip) title("Table 11 Panel C Part I: This table reports the estimation results based on the PSM-matched samples. The dependent variable in model (1) and (4) is the domestic debt crowdfunding volume contributed by both retail and institutional investors, in model (2) and (5) is contributed by retail investors, and in model (3) and (6) is contributed by institutional investors. The regulation variables include the level of the regulatory index, and the adjusted regulatory index, respectively. The level and adjusted level of the regulatory index are measures of the regulatory clarity in the country using indicator variables for different dimensions as in Table 3. The variable, Regulated, indicates whether the jurisdication has introduced a regulation. All independent variables are described in the Appendix and are lagged by a year. All regressions include country and year fixed effects. Heteroscedasticity-consistent robust standard errors are clustered by country and year, following Thompson (2011). *** p<0.01, ** p<0.05, * p<0.1")


reghdfe lnretail_adfin_dom regulated P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
test _b[regulated] + _b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

 
 est save t11Em2,replace
indeplist

outreg2 t11Em2 using regression_submission_Table11E, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Raw") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)



reghdfe lninst_adfin_dom regulated P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)


local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
test _b[regulated] + _b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
 
 est save t11Em3,replace
indeplist

outreg2 t11Em3 using regression_submission_Table11E, append  st(coef tstat) auto(3) nonotes dta  addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Raw") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)

 
preserve
replace P2P_RegIndex_pub_L_recip = P2P_RegIndex_Adj_pub_L_recip


 
 

reghdfe lntotal_adfin_dom regulated P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
test _b[regulated] + _b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

 
est save t11Em4,replace
indeplist

outreg2 t11Em4 using regression_submission_Table11E, append  st(coef tstat) auto(3) nonotes dta  addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)

 
 *
 

reghdfe lnretail_adfin_dom regulated P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
test _b[regulated] + _b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )


 
 
est save t11Em5,replace
indeplist

outreg2 t11Em5 using regression_submission_Table11E, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')")  adjr2 label keep(`r(X)') ctitle("Adj") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)

 
 
 *
 
reghdfe lninst_adfin_dom regulated P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
test _b[regulated] + _b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

 
est save t11Em6,replace
indeplist

outreg2 t11Em6 using regression_submission_Table11E, append  st(coef tstat) auto(3) nonotes dta  addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)




restore




***************************************************
*Table 11******************************************
***************************************************
*Panel F*******************************************
***************************************************
****dep variable: # of platforms
reghdfe lntotal_adnum_dom regulated P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
test _b[regulated] + _b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
 
 
 est save t11Fm1,replace
indeplist

outreg2 t11Fm1 using regression_submission_Table11F, replace  st(coef tstat) auto(3) nonotes dta  addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Raw") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip) title("Table 11 Panel C Part I: This table reports the estimation results based on the PSM-matched samples. The dependent variable in model (1) and (4) is the number of domestic debt crowdfunding platforms serving both retail and institutional investors, in model (2) and (5) is the number of those serving retail investors, and in model (3) and (6) is the number of those serving institutional investors. The regulation variables include the level of the regulatory index, and the adjusted regulatory index, respectively. The level and adjusted level of the regulatory index are measures of the regulatory clarity in the country using indicator variables for different dimensions as in Table 3. All independent variables are described in the Appendix and are lagged by a year. All regressions include country and year fixed effects. Heteroscedasticity-consistent robust standard errors are clustered by country and year, following Thompson (2011). *** p<0.01, ** p<0.05, * p<0.1")


reghdfe lnretail_adnum_dom regulated P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
test _b[regulated] + _b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )


est save t11Fm2,replace
indeplist

outreg2 t11Fm2 using regression_submission_Table11F, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Raw") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)
 
 
reghdfe lninst_adnum_dom regulated P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
test _b[regulated] + _b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t11Fm3,replace
indeplist

outreg2 t11Fm3 using regression_submission_Table11F, append  st(coef tstat) auto(3) nonotes dta  addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Raw") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)
 
preserve
replace P2P_RegIndex_pub_L_recip = P2P_RegIndex_Adj_pub_L_recip


reghdfe lntotal_adnum_dom regulated P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
test _b[regulated] + _b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

 
est save t11Fm4,replace
indeplist

outreg2 t11Fm4 using regression_submission_Table11F, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)
 
*


 
reghdfe lnretail_adnum_dom regulated P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
test _b[regulated] + _b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

 
est save t11Fm5,replace
indeplist

outreg2 t11Fm5 using regression_submission_Table11F, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)
 
 
*



reghdfe lninst_adnum_dom regulated P2P_RegIndex_pub_L_recip /// 
                RL_EST_L_recip /// 
                lngdp_L_recip ///
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip ///
				lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
test _b[regulated] + _b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t11Fm6,replace
indeplist

outreg2 t11Fm6 using regression_submission_Table11F, append  st(coef tstat) auto(3) nonotes dta  addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)


restore






***************************************************
*Table 11******************************************
***************************************************
*Part III & IV*************************************
*Panel G*******************************************
***************************************************

*supply vs demand
cd "your directory"
use country_panel_data_final,clear

local choice "supply demand "

foreach i in `choice' {
bys Recipient_country (year): egen switcher_P2P_`i' = mean(P2P_`i'_pub_L_recip)  if Switcher_P2P_recip == 1 & year >= P2P_year_recip + 1 & year >= 2015 & year <= 2020 & P2P_year_recip!= 0

bys Recipient_country (year): egen switcher_P2P_`i'_Adj = mean(P2P_`i'_Adj_pub_L_recip)  if Switcher_P2P_recip == 1 & year >= P2P_year_recip + 1 & year >= 2015 & year <= 2020 & P2P_year_recip!= 0


bys Recipient_country (year): replace switcher_P2P_`i' = . if year != P2P_year_recip + 1

bys Recipient_country (year): replace switcher_P2P_`i'_Adj =. if year != P2P_year_recip + 1

bys Recipient_country (year): egen always_P2P_`i'_after = mean(P2P_`i'_pub_L_recip)  if Switcher_P2P_recip == 0 & year >= P2P_year_recip + 1 & year >= 2016 & year <= 2020 & P2P_year_recip!= 0

bys Recipient_country (year): egen always_P2P_`i'_Adj_after = mean(P2P_`i'_Adj_pub_L_recip)  if Switcher_P2P_recip == 0 & year >= P2P_year_recip + 1 & year >= 2016 & year <= 2020 & P2P_year_recip!=0


bys Recipient_country (always_P2P_`i'_after): replace always_P2P_`i'_after = always_P2P_`i'_after[1]

bys Recipient_country (always_P2P_`i'_Adj_after): replace always_P2P_`i'_Adj_after = always_P2P_`i'_Adj_after[1]



bys Recipient_country (year): egen always_P2P_`i'_before = mean(P2P_`i'_pub_L_recip)  if Switcher_P2P_recip == 0 & year >= P2P_year_recip + 1 & year <= 2015 & P2P_year_recip!= 0

bys Recipient_country (year): egen always_P2P_`i'_Adj_before = mean(P2P_`i'_Adj_pub_L_recip)  if Switcher_P2P_recip == 0 & year >= P2P_year_recip + 1 &  year <= 2015 & P2P_year_recip!=0


bys Recipient_country (always_P2P_`i'_before): replace always_P2P_`i'_before = always_P2P_`i'_before[1]

bys Recipient_country (always_P2P_`i'_Adj_before): replace always_P2P_`i'_Adj_before = always_P2P_`i'_Adj_before[1]



bys Recipient_country (year): gen always_P2P_`i' = always_P2P_`i'_after - always_P2P_`i'_before

bys Recipient_country (year): gen always_P2P_`i'_Adj = always_P2P_`i'_Adj_after - always_P2P_`i'_Adj_before


bys Recipient_country (year): replace always_P2P_`i' = . if year != 2015

bys Recipient_country (year): replace always_P2P_`i'_Adj =. if year != 2015


sum switcher_P2P_`i' 
local switcher_P2P_`i' = r(mean)

sum switcher_P2P_`i'_Adj
local switcher_P2P_`i'_Adj = r(mean)


sum always_P2P_`i'
local always_P2P_`i' = r(mean)

sum always_P2P_`i'_Adj
local always_P2P_`i'_Adj = r(mean)
  
sum always_P2P_`i'_after
local always_P2P_`i'_after = r(mean)

sum always_P2P_`i'_Adj_after
local always_P2P_`i'_Adj_after = r(mean)
}

cd "your directory"
use psm_matched_all_regulations_v3, clear
 
gen regulated = (P2P_RegIndex_pub_L_recip > 0 )
gen high_reg = (P2P_RegIndex_pub_L_recip>20)
label var regulated "Regulated"

gen P2P_RegIndex_supply = P2P_RegIndex_pub_L_recip-P2P_supply_pub_L_recip
label var P2P_RegIndex_supply "Regulatory Clarity Index - Supply-Side Index"

gen P2P_RegIndex_demand = P2P_RegIndex_pub_L_recip-P2P_demand_pub_L_recip
label var P2P_RegIndex_demand "Regulatory Clarity Index - Demand-Side Index"


****dep variable: volume  //note: switcher variable is dropped because I only kept obs for switching countries that are after the introduction of regulation
reghdfe lntotal_adfin_dom regulated P2P_RegIndex_supply P2P_supply_pub_L_recip  /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)


local m1 = round(_b[regulated] + _b[P2P_RegIndex_supply]*(`switcher_P2P_RegIndex'-`switcher_P2P_supply')  +  _b[P2P_supply_pub_L_recip]*`switcher_P2P_supply',0.001)

test _b[regulated] + _b[P2P_RegIndex_supply]*(`switcher_P2P_RegIndex'-`switcher_P2P_supply')  +  _b[P2P_supply_pub_L_recip]*`switcher_P2P_supply' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )


est save t11Gm1,replace
indeplist

outreg2 t11Gm1 using regression_submission_Table11G, replace  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Raw-`i'-Total") sortvar(P2P_supply_pub_L_recip P2P_supply_Adj_pub_L_recip  P2P_demand_pub_L_recip P2P_demand_Adj_pub_L_recip P2P_disc_pub_L_recip P2P_disc_Adj_pub_L_recip) title("Table 11 Panel C Part III & IV: This table reports the impact of demand-, supply-related regulation on volume.")


local choice "supply demand"

local s = 1

foreach i in `choice'  {

local j = `s' + 1
local k = `s' + 2
local l = `s' + 3
local z = `s' + 4
local x = `s' + 5

replace P2P_RegIndex_`i' = P2P_RegIndex_pub_L_recip - P2P_`i'_pub_L_recip

if `s' != 1 {
****dep variable: volume  //note: switcher variable is dropped because I only kept obs for switching countries that are after the introduction of regulation
reghdfe lntotal_adfin_dom regulated P2P_RegIndex_`i' P2P_`i'_pub_L_recip  /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
 

local m1 = round(_b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex'-`switcher_P2P_`i'')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'',0.001)
test _b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex'-`switcher_P2P_`i'')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )


est save t11Gm`s',replace
indeplist

outreg2 t11Gm`s' using regression_submission_Table11G, append st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Raw-`i'-Total") sortvar(P2P_supply_pub_L_recip P2P_supply_Adj_pub_L_recip  P2P_demand_pub_L_recip P2P_demand_Adj_pub_L_recip P2P_disc_pub_L_recip P2P_disc_Adj_pub_L_recip) title("Table 11 Panel C Part III & IV: This table reports the impact of demand-, supply-related regulation on number of platforms.")
}


reghdfe lnretail_adfin_dom regulated P2P_RegIndex_`i' P2P_`i'_pub_L_recip  /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

local m1 = round(_b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex'-`switcher_P2P_`i'')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'',0.001)
test _b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex'-`switcher_P2P_`i'')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

 
 est save t11Gm`j',replace
indeplist

outreg2 t11Gm`j' using regression_submission_Table11G, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Raw-`i'-Retail") sortvar(P2P_supply_pub_L_recip P2P_supply_Adj_pub_L_recip  P2P_demand_pub_L_recip P2P_demand_Adj_pub_L_recip P2P_disc_pub_L_recip P2P_disc_Adj_pub_L_recip)


reghdfe lninst_adfin_dom regulated P2P_RegIndex_`i' P2P_`i'_pub_L_recip  /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

local m1 = round(_b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex'-`switcher_P2P_`i'')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'',0.001)
test _b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex'-`switcher_P2P_`i'')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t11Gm`k',replace
indeplist

outreg2 t11Gm`k' using regression_submission_Table11G, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)')  ctitle("Raw-`i'-Inst") sortvar(P2P_supply_pub_L_recip P2P_supply_Adj_pub_L_recip  P2P_demand_pub_L_recip P2P_demand_Adj_pub_L_recip P2P_disc_pub_L_recip P2P_disc_Adj_pub_L_recip)



 
preserve
replace P2P_`i'_pub_L_recip = P2P_`i'_Adj_pub_L_recip
replace P2P_RegIndex_`i' = P2P_RegIndex_Adj_pub_L_recip - P2P_`i'_Adj_pub_L_recip
 
reghdfe lntotal_adfin_dom regulated P2P_RegIndex_`i' P2P_`i'_pub_L_recip  /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

local m1 = round(_b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex_Adj'-`switcher_P2P_`i'_Adj')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'_Adj',0.001)
test _b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex_Adj'-`switcher_P2P_`i'_Adj')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )


 
est save t11Gm`l',replace
indeplist

outreg2 t11Gm`l' using regression_submission_Table11G, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)')  ctitle("Adj-`i'-Total") sortvar(P2P_supply_pub_L_recip P2P_supply_Adj_pub_L_recip  P2P_demand_pub_L_recip P2P_demand_Adj_pub_L_recip P2P_disc_pub_L_recip P2P_disc_Adj_pub_L_recip)

 
 *
 

reghdfe lnretail_adfin_dom regulated P2P_RegIndex_`i' P2P_`i'_pub_L_recip  /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex_Adj'-`switcher_P2P_`i'_Adj')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'_Adj',0.001)
test _b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex_Adj'-`switcher_P2P_`i'_Adj')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

 
est save t11Gm`z',replace
indeplist

outreg2 t11Gm`z' using regression_submission_Table11G, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Adj-`i'-Retail") sortvar(P2P_supply_pub_L_recip P2P_supply_Adj_pub_L_recip  P2P_demand_pub_L_recip P2P_demand_Adj_pub_L_recip P2P_disc_pub_L_recip P2P_disc_Adj_pub_L_recip)

 
 
 *
 
reghdfe lninst_adfin_dom regulated P2P_RegIndex_`i' P2P_`i'_pub_L_recip  /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex_Adj'-`switcher_P2P_`i'_Adj')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'_Adj',0.001)
test _b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex_Adj'-`switcher_P2P_`i'_Adj')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
 
est save t11Gm`x',replace
indeplist

outreg2 t11Gm`x' using regression_submission_Table11G, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Adj-`i'-Inst") sortvar(P2P_supply_pub_L_recip P2P_supply_Adj_pub_L_recip  P2P_demand_pub_L_recip P2P_demand_Adj_pub_L_recip P2P_disc_pub_L_recip P2P_disc_Adj_pub_L_recip)

local s = `s' + 6
dis `s'
restore
}


***************************************************
*Table 11******************************************
***************************************************
*Part III & IV*************************************
*Panel H*******************************************
***************************************************


****dep variable: # of platforms  //note: switcher variable is dropped because I only kept obs for switching countries that are after the introduction of regulation
reghdfe lntotal_adnum_dom regulated P2P_RegIndex_supply P2P_supply_pub_L_recip  /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)


local m1 = round(_b[regulated] + _b[P2P_RegIndex_supply]*(`switcher_P2P_RegIndex'-`switcher_P2P_supply')  +  _b[P2P_supply_pub_L_recip]*`switcher_P2P_supply',0.001)
test _b[regulated] + _b[P2P_RegIndex_supply]*(`switcher_P2P_RegIndex'-`switcher_P2P_supply')  +  _b[P2P_supply_pub_L_recip]*`switcher_P2P_supply' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t11Hm1,replace
indeplist

outreg2 t11Hm1 using regression_submission_Table11H, replace  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Raw-`i'-Total") sortvar(P2P_supply_pub_L_recip P2P_supply_Adj_pub_L_recip  P2P_demand_pub_L_recip P2P_demand_Adj_pub_L_recip P2P_disc_pub_L_recip P2P_disc_Adj_pub_L_recip) title("Table 11 Panel C Part III & IV: This table reports the impact of demand-, supply-related regulation on number of platforms.")

local choice "supply demand"

local s = 1

foreach i in `choice'  {

local j = `s' + 1
local k = `s' + 2
local l = `s' + 3
local z = `s' + 4
local x = `s' + 5

replace P2P_RegIndex_`i' = P2P_RegIndex_pub_L_recip - P2P_`i'_pub_L_recip

if `s' != 1 {
****dep variable: volume  //note: switcher variable is dropped because I only kept obs for switching countries that are after the introduction of regulation
reghdfe lntotal_adnum_dom regulated P2P_RegIndex_`i' P2P_`i'_pub_L_recip  /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
 
local m1 = round(_b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex'-`switcher_P2P_`i'')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'',0.001)
test _b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex'-`switcher_P2P_`i'')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t11Hm`s',replace
indeplist

outreg2 t11Hm`s' using regression_submission_Table11H, append st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Raw-`i'-Total") sortvar(P2P_supply_pub_L_recip P2P_supply_Adj_pub_L_recip  P2P_demand_pub_L_recip P2P_demand_Adj_pub_L_recip P2P_disc_pub_L_recip P2P_disc_Adj_pub_L_recip) title("Table 11 Panel C Part III & IV: This table reports the impact of demand-, supply-related regulation on number of platforms.")
}


reghdfe lnretail_adnum_dom regulated P2P_RegIndex_`i' P2P_`i'_pub_L_recip  /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

local m1 = round(_b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex'-`switcher_P2P_`i'')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'',0.001)
test _b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex'-`switcher_P2P_`i'')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
 
est save t11Hm`j',replace
indeplist

outreg2 t11Hm`j' using regression_submission_Table11H, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Raw-`i'-Retail")  sortvar(P2P_supply_pub_L_recip P2P_supply_Adj_pub_L_recip  P2P_demand_pub_L_recip P2P_demand_Adj_pub_L_recip P2P_disc_pub_L_recip P2P_disc_Adj_pub_L_recip)


reghdfe lninst_adnum_dom regulated P2P_RegIndex_`i' P2P_`i'_pub_L_recip  /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex'-`switcher_P2P_`i'')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'',0.001)
test _b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex'-`switcher_P2P_`i'')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

 est save t11Hm`k',replace
indeplist

outreg2 t11Hm`k' using regression_submission_Table11H, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Raw-`i'-Inst") sortvar(P2P_supply_pub_L_recip P2P_supply_Adj_pub_L_recip  P2P_demand_pub_L_recip P2P_demand_Adj_pub_L_recip P2P_disc_pub_L_recip P2P_disc_Adj_pub_L_recip)



preserve
replace P2P_`i'_pub_L_recip = P2P_`i'_Adj_pub_L_recip
replace P2P_RegIndex_`i' = P2P_RegIndex_Adj_pub_L_recip - P2P_`i'_Adj_pub_L_recip
 
reghdfe lntotal_adnum_dom regulated P2P_RegIndex_`i' P2P_`i'_pub_L_recip  /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

local m1 = round(_b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex_Adj'-`switcher_P2P_`i'_Adj')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'_Adj',0.001)
test _b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex_Adj'-`switcher_P2P_`i'_Adj')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t11Hm`l',replace
indeplist

outreg2 t11Hm`l' using regression_submission_Table11H, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Adj-`i'-Total") sortvar(P2P_supply_pub_L_recip P2P_supply_Adj_pub_L_recip  P2P_demand_pub_L_recip P2P_demand_Adj_pub_L_recip P2P_disc_pub_L_recip P2P_disc_Adj_pub_L_recip)

 
 *
 

reghdfe lnretail_adnum_dom regulated P2P_RegIndex_`i' P2P_`i'_pub_L_recip  /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex_Adj'-`switcher_P2P_`i'_Adj')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'_Adj',0.001)
test _b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex_Adj'-`switcher_P2P_`i'_Adj')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  ) 
 
 est save t11Hm`z',replace
indeplist

outreg2 t11Hm`z' using regression_submission_Table11H, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Adj-`i'-Retail") sortvar(P2P_supply_pub_L_recip P2P_supply_Adj_pub_L_recip  P2P_demand_pub_L_recip P2P_demand_Adj_pub_L_recip P2P_disc_pub_L_recip P2P_disc_Adj_pub_L_recip)

 
 
 *

reghdfe lninst_adnum_dom regulated P2P_RegIndex_`i' P2P_`i'_pub_L_recip  /// 
                RL_EST_L_recip /// 
				///
                 lngdp_L_recip /// 
                 Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip ///
				GC_LegalRights_L_recip ///
				GC_CreditInfo_L_recip ///
				RI_L_recip  ///
                Bank_C2A_L_recip ///
                DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip /// 
                Bank_NPL_L_recip /// 
                /// 
                lnMobilePhoneUsage_L_recip ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex_Adj'-`switcher_P2P_`i'_Adj')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'_Adj',0.001)
test _b[regulated] + _b[P2P_RegIndex_`i']*(`switcher_P2P_RegIndex_Adj'-`switcher_P2P_`i'_Adj')  +  _b[P2P_`i'_pub_L_recip]*`switcher_P2P_`i'_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
 
est save t11Hm`x',replace
indeplist

outreg2 t11Hm`x' using regression_submission_Table11H, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')") adjr2 label keep(`r(X)') ctitle("Adj-`i'-Inst") sortvar(P2P_supply_pub_L_recip P2P_supply_Adj_pub_L_recip  P2P_demand_pub_L_recip P2P_demand_Adj_pub_L_recip P2P_disc_pub_L_recip P2P_disc_Adj_pub_L_recip)

local s = `s' + 6
dis `s'
restore
}










***************************************************
*Table 11******************************************
***************************************************
*Part V********************************************
*Panel I*******************************************
***************************************************
cd "your directory"
use country_panel_data_final,clear


ren ECF_year_recip ECF_year
ren P2P_year_recip P2P_year

gen P2P_StrScore_Switcher_recip = P2P_StrScore_pub_L_recip*Switcher_P2P_recip
gen P2P_StrScore_Adj_Switcher_recip = P2P_StrScore_Adj_pub_L_recip*Switcher_P2P_recip

gen regulated = (P2P_RegIndex_pub_L_recip > 0)

cd "your directory"


*generate time-series average index for each country
*and then compute cross-sectional average
*****Regulatory Clarity Index:
bys Recipient_country (year): egen switcher_P2P_RegIndex = mean(P2P_RegIndex_pub_L_recip)  if Switcher_P2P_recip == 1 & year >= P2P_year + 1 & year >= 2015 & year <= 2020 & P2P_year!= 0

bys Recipient_country (year): egen switcher_P2P_RegIndex_Adj = mean(P2P_RegIndex_Adj_pub_L_recip)  if Switcher_P2P_recip == 1 & year >= P2P_year + 1 & year >= 2015 & year <= 2020 & P2P_year!= 0



bys Recipient_country (year): replace switcher_P2P_RegIndex = . if year != P2P_year + 1

bys Recipient_country (year): replace switcher_P2P_RegIndex_Adj =. if year != P2P_year + 1



bys Recipient_country (year): egen always_P2P_RegIndex_after = mean(P2P_RegIndex_pub_L_recip)  if Switcher_P2P_recip == 0 & year >= P2P_year + 1 & year >= 2016 & year <= 2020 & P2P_year!= 0

bys Recipient_country (year): egen always_P2P_RegIndex_Adj_after = mean(P2P_RegIndex_Adj_pub_L_recip)  if Switcher_P2P_recip == 0 & year >= P2P_year + 1 & year >= 2016 & year <= 2020 & P2P_year!=0


bys Recipient_country (always_P2P_RegIndex_after): replace always_P2P_RegIndex_after = always_P2P_RegIndex_after[1]

bys Recipient_country (always_P2P_RegIndex_Adj_after): replace always_P2P_RegIndex_Adj_after = always_P2P_RegIndex_Adj_after[1]



bys Recipient_country (year): egen always_P2P_RegIndex_before = mean(P2P_RegIndex_pub_L_recip)  if Switcher_P2P_recip == 0 & year >= P2P_year + 1 & year <= 2015 & P2P_year!= 0

bys Recipient_country (year): egen always_P2P_RegIndex_Adj_before = mean(P2P_RegIndex_Adj_pub_L_recip)  if Switcher_P2P_recip == 0 & year >= P2P_year + 1 &  year <= 2015 & P2P_year!=0



bys Recipient_country (always_P2P_RegIndex_before): replace always_P2P_RegIndex_before = always_P2P_RegIndex_before[1]

bys Recipient_country (always_P2P_RegIndex_Adj_before): replace always_P2P_RegIndex_Adj_before = always_P2P_RegIndex_Adj_before[1]



bys Recipient_country (year): gen always_P2P_RegIndex = always_P2P_RegIndex_after - always_P2P_RegIndex_before

bys Recipient_country (year): gen always_P2P_RegIndex_Adj = always_P2P_RegIndex_Adj_after - always_P2P_RegIndex_Adj_before


bys Recipient_country (year): replace always_P2P_RegIndex = . if year != 2015

bys Recipient_country (year): replace always_P2P_RegIndex_Adj =. if year != 2015





sum switcher_P2P_RegIndex 
local switcher_P2P_RegIndex = r(mean)

sum switcher_P2P_RegIndex_Adj
local switcher_P2P_RegIndex_Adj = r(mean)


sum always_P2P_RegIndex
local always_P2P_RegIndex = r(mean)

sum always_P2P_RegIndex_Adj
local always_P2P_RegIndex_Adj = r(mean)
  


sum always_P2P_RegIndex_after
local always_P2P_RegIndex_after = r(mean)

sum always_P2P_RegIndex_Adj_after
local always_P2P_RegIndex_Adj_after = r(mean)





*****Regulatory Stringency Socre:
bys Recipient_country (year): egen switcher_P2P_StrScore = mean(P2P_StrScore_pub_L_recip)  if Switcher_P2P_recip == 1 & year >= P2P_year + 1 & year >= 2015 & year <= 2020 & P2P_year!= 0

bys Recipient_country (year): egen switcher_P2P_StrScore_Adj = mean(P2P_StrScore_Adj_pub_L_recip)  if Switcher_P2P_recip == 1 & year >= P2P_year + 1 & year >= 2015 & year <= 2020 & P2P_year!= 0

bys Recipient_country (year): replace switcher_P2P_StrScore = . if year != P2P_year + 1

bys Recipient_country (year): replace switcher_P2P_StrScore_Adj =. if year != P2P_year + 1



bys Recipient_country (year): egen always_P2P_StrScore_after = mean(P2P_StrScore_pub_L_recip)  if Switcher_P2P_recip == 0 & year >= P2P_year + 1 & year >= 2016 & year <= 2020 & P2P_year!= 0

bys Recipient_country (year): egen always_P2P_StrScore_Adj_after = mean(P2P_StrScore_Adj_pub_L_recip)  if Switcher_P2P_recip == 0 & year >= P2P_year + 1 & year >= 2016 & year <= 2020 & P2P_year!=0



bys Recipient_country (always_P2P_StrScore_after): replace always_P2P_StrScore_after = always_P2P_StrScore_after[1]

bys Recipient_country (always_P2P_StrScore_Adj_after): replace always_P2P_StrScore_Adj_after = always_P2P_StrScore_Adj_after[1]

bys Recipient_country (year): egen always_P2P_StrScore_before = mean(P2P_StrScore_pub_L_recip)  if Switcher_P2P_recip == 0 & year >= P2P_year + 1 & year <= 2015 & P2P_year!= 0

bys Recipient_country (year): egen always_P2P_StrScore_Adj_before = mean(P2P_StrScore_Adj_pub_L_recip)  if Switcher_P2P_recip == 0 & year >= P2P_year + 1 &  year <= 2015 & P2P_year!=0


bys Recipient_country (always_P2P_StrScore_before): replace always_P2P_StrScore_before = always_P2P_StrScore_before[1]

bys Recipient_country (always_P2P_StrScore_Adj_before): replace always_P2P_StrScore_Adj_before = always_P2P_StrScore_Adj_before[1]

bys Recipient_country (year): gen always_P2P_StrScore = always_P2P_StrScore_after - always_P2P_StrScore_before

bys Recipient_country (year): gen always_P2P_StrScore_Adj = always_P2P_StrScore_Adj_after - always_P2P_StrScore_Adj_before


bys Recipient_country (year): replace always_P2P_StrScore = . if year != 2015

bys Recipient_country (year): replace always_P2P_StrScore_Adj =. if year != 2015


sum switcher_P2P_StrScore 
local switcher_P2P_StrScore = r(mean)

sum switcher_P2P_StrScore_Adj
local switcher_P2P_StrScore_Adj = r(mean)


sum always_P2P_StrScore
local always_P2P_StrScore = r(mean)

sum always_P2P_StrScore_Adj
local always_P2P_StrScore_Adj = r(mean)
  

sum always_P2P_StrScore_after
local always_P2P_StrScore_after = r(mean)

sum always_P2P_StrScore_Adj_after
local always_P2P_StrScore_Adj_after = r(mean)




*********************************************************
*********************************************************
*********************************************************
*********************************************************
*********************************************************
*********************************************************
*********************************************************
*********************************************************
*********************************************************
*********************************************************

local types "P2P"
foreach type in `types' {
global cov_RegIndex_`type'1  regulated `type'_RegIndex_pub_L_recip  RL_EST_L_recip   lngdp_L_recip
global cov_RegIndex_`type'2 ${cov_RegIndex_`type'1} Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip 

global cov_StrScore_`type'1 regulated `type'_StrScore_pub_L_recip   RL_EST_L_recip   lngdp_L_recip
global cov_StrScore_`type'2 ${cov_StrScore_`type'1} Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip 

global cov_both_`type'1  regulated `type'_RegIndex_pub_L_recip `type'_StrScore_pub_L_recip  RL_EST_L_recip lngdp_L_recip
global cov_both_`type'2 ${cov_both_`type'1} Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip 
}


global cov_RegIndex_P2P3 $cov_RegIndex_P2P2 				GC_LegalRights_L_recip GC_CreditInfo_L_recip RI_L_recip  
global cov_RegIndex_P2P4 $cov_RegIndex_P2P3                 Bank_C2A_L_recip    DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip    Bank_NPL_L_recip    lnMobilePhoneUsage_L_recip 

global cov_StrScore_P2P3 $cov_StrScore_P2P2 GC_LegalRights_L_recip GC_CreditInfo_L_recip RI_L_recip 

global cov_StrScore_P2P4 $cov_StrScore_P2P3 Bank_C2A_L_recip    DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip    Bank_NPL_L_recip    lnMobilePhoneUsage_L_recip 

global cov_both_P2P3 $cov_both_P2P2 GC_LegalRights_L_recip GC_CreditInfo_L_recip RI_L_recip 

global cov_both_P2P4 $cov_both_P2P3 Bank_C2A_L_recip    DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip    Bank_NPL_L_recip    lnMobilePhoneUsage_L_recip 

  
*********************************************************
*********************************************************
*********************************************************
*********************************************************
*********************************************************
*************PSM Sample*********************************
*********************************************************
*********************************************************
*********************************************************
*********************************************************
*********************************************************
*********************************************************
*********************************************************
*********************************************************
cd "your directory"
use psm_matched_all_regulations_v3,clear



gen P2P_StrScore_Switcher_recip = P2P_StrScore_pub_L_recip*Switcher_P2P_recip
gen P2P_StrScore_Adj_Switcher_recip = P2P_StrScore_Adj_pub_L_recip*Switcher_P2P_recip

gen regulated = (P2P_RegIndex_pub_L_recip > 0)

label var regulated "Regulated (debt)"

label var P2P_StrScore_pub_L_recip "High-Stringency Indicator"

label var P2P_StrScore_Switcher_recip "High-Stringency Indicator X Switcher"
label var P2P_StrScore_Adj_Switcher_recip "High-Stringency Indicator X Switcher"


egen P2P_StrScore_pub_L_recip2 = xtile(P2P_StrScore_pub_L_recip) if P2P_StrScore_pub_L_recip!=0, n(2) by(year)
replace P2P_StrScore_pub_L_recip2 = 0 if regulated == 0  | P2P_StrScore_pub_L_recip2 == 1
replace P2P_StrScore_pub_L_recip2 = 1 if P2P_StrScore_pub_L_recip2 == 2

replace P2P_StrScore_pub_L_recip = P2P_StrScore_pub_L_recip2

drop P2P_StrScore_pub_L_recip2





egen P2P_StrScore_Adj_pub_L_recip2 = xtile(P2P_StrScore_Adj_pub_L_recip) if P2P_StrScore_Adj_pub_L_recip!=0, n(2) by(year)
replace P2P_StrScore_Adj_pub_L_recip2 = 0 if regulated == 0  | P2P_StrScore_Adj_pub_L_recip2 == 1
replace P2P_StrScore_Adj_pub_L_recip2 = 1 if P2P_StrScore_Adj_pub_L_recip2 == 2

replace P2P_StrScore_Adj_pub_L_recip = P2P_StrScore_Adj_pub_L_recip2

drop P2P_StrScore_Adj_pub_L_recip2


cd "your directory"
****dep variable: volume  //note: switcher variable is dropped because I only kept obs for switching countries that are after the introduction of regulation
reghdfe lntotal_adfin_dom $cov_both_P2P4  ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
local m3 = round(_b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test _b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
 
est save t11Im1,replace
indeplist

outreg2 t11Im1 using regression_submission_Table11I, replace  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Low-Stringency Regulation",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing High-Stringency Regulation",`m3',"p-value (of Measure 3)","(`p3')") adjr2 label keep(`r(X)') ctitle("Raw") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip) title("Table 11 Panel C Part V: This table reports the estimation results based on the PSM-matched samples. The dependent variable in model (1) and (4) is the domestic debt crowdfunding volume contributed by both retail and institutional investors, in model (2) and (5) is contributed by retail investors, and in model (3) and (6) is contributed by institutional investors. The regulation variables include the level of the regulatory index, and the adjusted regulatory index, respectively. The level and adjusted level of the regulatory index are measures of the regulatory clarity in the country using indicator variables for different dimensions as in Table 3. The variable, Regulated, indicates whether the jurisdication has introduced a regulation. All independent variables are described in the Appendix and are lagged by a year. All regressions include country and year fixed effects. Heteroscedasticity-consistent robust standard errors are clustered by country and year, following Thompson (2011). *** p<0.01, ** p<0.05, * p<0.1")


reghdfe lnretail_adfin_dom $cov_both_P2P4 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
local m3 = round(_b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test _b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
  
est save t11Im2,replace
indeplist

outreg2 t11Im2 using regression_submission_Table11I, append  st(coef tstat) auto(3) nonotes dta  addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Low-Stringency Regulation",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing High-Stringency Regulation",`m3',"p-value (of Measure 3)","(`p3')") adjr2 label keep(`r(X)') ctitle("Raw") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)



reghdfe lninst_adfin_dom $cov_both_P2P4 ///
if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
local m3 = round(_b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test _b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
 
 est save t11Im3,replace
indeplist

outreg2 t11Im3 using regression_submission_Table11I, append  st(coef tstat) auto(3) nonotes dta  addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Low-Stringency Regulation",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing High-Stringency Regulation",`m3',"p-value (of Measure 3)","(`p3')")  adjr2 label keep(`r(X)') ctitle("Raw") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)

 
preserve
replace P2P_RegIndex_pub_L_recip = P2P_RegIndex_Adj_pub_L_recip
replace P2P_StrScore_pub_L_recip = P2P_StrScore_Adj_pub_L_recip


 
 
 
reghdfe lntotal_adfin_dom $cov_both_P2P4 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test _b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
  
est save t11Im4,replace
indeplist

outreg2 t11Im4 using regression_submission_Table11I, append  st(coef tstat) auto(3) nonotes dta  addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Low-Stringency Regulation",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing High-Stringency Regulation",`m3',"p-value (of Measure 3)","(`p3')") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)

 
 *
 

reghdfe lnretail_adfin_dom $cov_both_P2P4 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test _b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

 est save t11Im5,replace
indeplist

outreg2 t11Im5 using regression_submission_Table11I, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Low-Stringency Regulation",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing High-Stringency Regulation",`m3',"p-value (of Measure 3)","(`p3')") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)

 
 
 *
 
reghdfe lninst_adfin_dom $cov_both_P2P4 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test _b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
 
 est save t11Im6,replace
indeplist

outreg2 t11Im6 using regression_submission_Table11I, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Low-Stringency Regulation",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing High-Stringency Regulation",`m3',"p-value (of Measure 3)","(`p3')") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)




restore


***************************************************
*Table 11******************************************
***************************************************
*Part V********************************************
*Panel J*******************************************
***************************************************

****dep variable: # of platforms
reghdfe lntotal_adnum_dom $cov_both_P2P4 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
local m3 = round(_b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test _b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
 
 
 est save t11Jm1,replace
indeplist

outreg2 t11Jm1 using regression_submission_Table11J, replace  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Low-Stringency Regulation",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing High-Stringency Regulation",`m3',"p-value (of Measure 3)","(`p3')")  adjr2 label keep(`r(X)') ctitle("Raw") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip) title("Table 11 Panel C Part V: This table reports the estimation results based on the PSM-matched samples. The dependent variable in model (1) and (4) is the number of domestic debt crowdfunding platforms serving both retail and institutional investors, in model (2) and (5) is the number of those serving retail investors, and in model (3) and (6) is the number of those serving institutional investors. The regulation variables include the level of the regulatory index, and the adjusted regulatory index, respectively. The level and adjusted level of the regulatory index are measures of the regulatory clarity in the country using indicator variables for different dimensions as in Table 3. All independent variables are described in the Appendix and are lagged by a year. All regressions include country and year fixed effects. Heteroscedasticity-consistent robust standard errors are clustered by country and year, following Thompson (2011). *** p<0.01, ** p<0.05, * p<0.1")


reghdfe lnretail_adnum_dom $cov_both_P2P4 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
local m3 = round(_b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test _b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
 
est save t11Jm2,replace
indeplist

outreg2 t11Jm2 using regression_submission_Table11J, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Low-Stringency Regulation",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing High-Stringency Regulation",`m3',"p-value (of Measure 3)","(`p3')") adjr2 label keep(`r(X)') ctitle("Raw") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)
 
 
reghdfe lninst_adnum_dom $cov_both_P2P4 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
local m3 = round(_b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test _b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
 
est save t11Jm3,replace
indeplist

outreg2 t11Jm3 using regression_submission_Table11J, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Low-Stringency Regulation",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing High-Stringency Regulation",`m3',"p-value (of Measure 3)","(`p3')") adjr2 label keep(`r(X)') ctitle("Raw") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)
 
preserve
replace P2P_RegIndex_pub_L_recip = P2P_RegIndex_Adj_pub_L_recip
replace P2P_StrScore_pub_L_recip = P2P_StrScore_Adj_pub_L_recip


reghdfe lntotal_adnum_dom $cov_both_P2P4 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test _b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t11Jm4,replace
indeplist

outreg2 t11Jm4 using regression_submission_Table11J, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Low-Stringency Regulation",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing High-Stringency Regulation",`m3',"p-value (of Measure 3)","(`p3')") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)
 
*


 
reghdfe lnretail_adnum_dom $cov_both_P2P4 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test _b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t11Jm5,replace
indeplist

outreg2 t11Jm5 using regression_submission_Table11J, append  st(coef tstat) auto(3) nonotes dta  addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Low-Stringency Regulation",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing High-Stringency Regulation",`m3',"p-value (of Measure 3)","(`p3')") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)
 
 
*

reghdfe lninst_adnum_dom $cov_both_P2P4 ///
 if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test _b[regulated]+_b[P2P_StrScore_pub_L_recip]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t11Jm6,replace
indeplist

outreg2 t11Jm6 using regression_submission_Table11J, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Low-Stringency Regulation",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing High-Stringency Regulation",`m3',"p-value (of Measure 3)","(`p3')") adjr2 label keep(`r(X)') ctitle("Adj") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip)


restore





cd "your directory"
local panel "A B C D" 
forvalues i = 5/10 {
cap foreach j in `panel' {
use "regression_submission_Table`i'`j'_dta", clear 
export excel using "regression_results_submission.xlsx", sheet("Table`i'`j'",replace) 
}
}

use "regression_submission_Table11A_dta", clear 
export excel using "regression_results_submission.xlsx", sheet("Table11A",replace) 

local panel "C D E F G H I J" 
forvalues i = 11/11 {
foreach j in `panel' {
use "regression_submission_Table`i'`j'_dta", clear 
export excel using "regression_results_submission.xlsx", sheet("Table`i'`j'",replace) 
}
}

local panel "A B C D" 
forvalues i = 12/12 {
foreach j in `panel' {
use "regression_submission_Table`i'`j'_dta", clear 
export excel using "regression_results_submission.xlsx", sheet("Table`i'`j'",replace) 
}
}




***************************************************
*Figure 1******************************************
***************************************************
*this figure is generated on Excel based on counry-level crowdfunding volume.



***************************************************
*Figure 2******************************************
***************************************************

cd "your directory"
use psm_matched_all_regulations_v3,clear

drop if AlwaysSwitcher_P2P == 1

replace P2P_year_recip = 0 if P2P_year_recip > 2019 | P2P_year_recip == 2015 //we ensure all treated countries should have at least one year that is either treated or untreated.

replace P2P_RegIndex_pub_recip = 0 if P2P_year_recip == 0

drop if P2P_year_recip == 0
bys recipient_country: egen mean_P2P_RegIndex = mean(P2P_RegIndex_Adj_pub_recip) if year >= P2P_year_recip

bys recipient_country (mean_P2P_RegIndex): replace mean_P2P_RegIndex = mean_P2P_RegIndex[1]

replace mean_P2P_RegIndex = 0 if mean_P2P_RegIndex == .


duplicates drop recipient_country,force

keep recipient_country mean_P2P_RegIndex P2P_year_recip


xtile quart_P2P_RegIndex = mean_P2P_RegIndex,n(2)

sort quart_P2P_RegIndex

table quart_P2P_RegIndex
table P2P_year_recip
table P2P_year_recip quart_P2P_RegIndex
tab quart_P2P_RegIndex, sum(mean_P2P_RegIndex)

merge 1:m recipient_country using psm_matched_all_regulations_v3.dta
drop _merge

replace mean_P2P_RegIndex = 0 if mean_P2P_RegIndex == .

replace quart_P2P_RegIndex = 0 if quart_P2P_RegIndex == .

table quart_P2P_RegIndex


gen regulated = (P2P_RegIndex_pub_L_recip > 0)

ren lnBankBranch_per100k_L_recip lnBankBranch_per100k_L


*

drop if year < 2015 

tabulate year, generate(year_dum)

drop year_dum3

**

xtset Recipient_country year
sort Recipient_country year



gen timeToTreat = year - P2P_year_recip
replace timeToTreat = . if P2P_year_recip== 0  | P2P_year_recip > 2020


cap drop eventplot_*
cap drop event_time
eventdd  lntotal_adfin_dom RL_EST_L_recip lngdp_L_recip  Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip  GC_LegalRights_L_recip GC_CreditInfo_L_recip RI_L_recip  Bank_C2A_L_recip  DomCredit_by_banks_L_recip lnBankBranch_per100k_L Bank_NPL_L_recip lnMobilePhoneUsage_L_recip , timevar(timeToTreat) method(hdfe, absorb(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)) graph_op(ytitle("n") xlabel(-2(1)2)) ci(rline) leads(3) lags(3) accum

matrix results_agg = e(leads) \ e(lags)

svmat results_agg, names(eventplot_aggregate)
replace eventplot_aggregate1 = -1 if _n == 1
replace eventplot_aggregate1 = -2 if _n == 2
replace eventplot_aggregate1 = -3 if _n == 3

eventdd  lntotal_adfin_dom RL_EST_L_recip lngdp_L_recip  Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip  GC_LegalRights_L_recip GC_CreditInfo_L_recip RI_L_recip  Bank_C2A_L_recip  DomCredit_by_banks_L_recip lnBankBranch_per100k_L Bank_NPL_L_recip lnMobilePhoneUsage_L_recip if quart_P2P_RegIndex == 1 | quart_P2P_RegIndex == 0, timevar(timeToTreat) method(hdfe, absorb(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) ) graph_op(ytitle("") xlabel(-2(1)2)) ci(rline)  leads(3) lags(3) accum


matrix results_low = e(leads) \ e(lags)

svmat results_low, names(eventplot_low)

**
preserve 

replace timeToTreat = 0 if timeToTreat == .

cap drop timeToTreat_dum*
tabulate timeToTreat, gen(timeToTreat_dum)

gen P2P_Binary_pub_recip_3lead = (timeToTreat_dum2==1 | timeToTreat_dum1 == 1)
gen P2P_Binary_pub_recip_2lead = timeToTreat_dum3
gen P2P_Binary_pub_recip_1lead = timeToTreat_dum4

gen P2P_Binary_pub_recip_0 = timeToTreat_dum5
replace P2P_Binary_pub_recip_0 = 0 if P2P_year_recip == 0

gen P2P_Binary_pub_recip_1lag = timeToTreat_dum6
gen P2P_Binary_pub_recip_2lag = timeToTreat_dum7
gen P2P_Binary_pub_recip_3lag = (timeToTreat_dum8 == 1 | timeToTreat_dum9 == 1 | timeToTreat_dum10 == 1)

sort Recipient_country year


drop P2P_Binary_pub_recip_1lead

reghdfe lntotal_adfin_dom P2P_Binary_pub_recip_* RL_EST_L_recip lngdp_L_recip  Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip  GC_LegalRights_L_recip GC_CreditInfo_L_recip RI_L_recip  Bank_C2A_L_recip  DomCredit_by_banks_L_recip lnBankBranch_per100k_L Bank_NPL_L_recip lnMobilePhoneUsage_L_recip if quart_P2P_RegIndex == 1 | quart_P2P_RegIndex == 0,a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

test P2P_Binary_pub_recip_3lead P2P_Binary_pub_recip_2lead

local pretrend_low_p = cond(r(p)<0.001,"P<0.001", "`:di %5.3f `=`r(p)'''")
restore 
**


eventdd  lntotal_adfin_dom RL_EST_L_recip lngdp_L_recip  Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip  GC_LegalRights_L_recip GC_CreditInfo_L_recip RI_L_recip  Bank_C2A_L_recip  DomCredit_by_banks_L_recip lnBankBranch_per100k_L Bank_NPL_L_recip lnMobilePhoneUsage_L_recip if quart_P2P_RegIndex == 2 | quart_P2P_RegIndex == 0, timevar(timeToTreat) method(hdfe, absorb(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) ) graph_op(ytitle("") xlabel(-2(1)2)) ci(rline)  leads(3) lags(3) accum

matrix results_high = e(leads) \ e(lags)

svmat results_high, names(eventplot_high)


**
preserve 

replace timeToTreat = 0 if timeToTreat == .

cap drop timeToTreat_dum*
tabulate timeToTreat, gen(timeToTreat_dum)

gen P2P_Binary_pub_recip_3lead = (timeToTreat_dum2==1 | timeToTreat_dum1 == 1)
gen P2P_Binary_pub_recip_2lead = timeToTreat_dum3
gen P2P_Binary_pub_recip_1lead = timeToTreat_dum4

gen P2P_Binary_pub_recip_0 = timeToTreat_dum5
replace P2P_Binary_pub_recip_0 = 0 if P2P_year_recip == 0

gen P2P_Binary_pub_recip_1lag = timeToTreat_dum6
gen P2P_Binary_pub_recip_2lag = timeToTreat_dum7
gen P2P_Binary_pub_recip_3lag = (timeToTreat_dum8 == 1 | timeToTreat_dum9 == 1 | timeToTreat_dum10 == 1)

drop P2P_Binary_pub_recip_1lead
reghdfe lntotal_adfin_dom P2P_Binary_pub_recip_* RL_EST_L_recip lngdp_L_recip  Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip  GC_LegalRights_L_recip GC_CreditInfo_L_recip RI_L_recip  Bank_C2A_L_recip  DomCredit_by_banks_L_recip lnBankBranch_per100k_L Bank_NPL_L_recip lnMobilePhoneUsage_L_recip if quart_P2P_RegIndex == 2 | quart_P2P_RegIndex == 0,a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

test P2P_Binary_pub_recip_3lead P2P_Binary_pub_recip_2lead

local pretrend_high_p =  cond(r(p)<0.001,"P<0.001", "`:di %5.3f `=`r(p)'''")
restore 
**

ren eventplot_aggregate1 event_time

drop eventplot_high1 eventplot_low1

sort event_time
twoway  rcap eventplot_low2 eventplot_low4 event_time , lc(green)  || scatter eventplot_low3 event_time , mc(green)  /// 
|| rcap eventplot_high2 eventplot_high4 event_time , lc(blue) || scatter eventplot_high3 event_time , mc(blue) ms(T) xlabel(#9)  ylabel(-2(2)6)  xtitle("Event Time") ytitle("Effect of Crowdfunding Regulation") yli(0, lc(gs8) lw(thin)) yla(, ang(h)) legend(order(2 "Low-Clarity Regulation" 4 "High-Clarity Regulation")) saving("volume_eventplot",replace) note("pretrend p-value: for low-clarity regulation = `pretrend_low_p', for high-clarity regulation = `pretrend_high_p'" )


replace event_time = . if event_time < -3 | event_time > 4
twoway rcap eventplot_aggregate2 eventplot_aggregate4 event_time, lc(black) || scatter   eventplot_aggregate3 event_time, mc(black) ms(S) 


********************************************************
********************************************************
********************************************************
********************************************************
********************************************************

cap drop eventplot_*
cap drop event_time
eventdd  lntotal_adnum_dom RL_EST_L_recip lngdp_L_recip  Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip  GC_LegalRights_L_recip GC_CreditInfo_L_recip RI_L_recip  Bank_C2A_L_recip  DomCredit_by_banks_L_recip lnBankBranch_per100k_L Bank_NPL_L_recip lnMobilePhoneUsage_L_recip , timevar(timeToTreat) method(hdfe, absorb(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)) graph_op(ytitle("") xlabel(-2(1)2)) ci(rline)   leads(3) lags(3) accum

matrix results_agg = e(leads) \ e(lags)

svmat results_agg, names(eventplot_aggregate)
replace eventplot_aggregate1 = -1 if _n == 1
replace eventplot_aggregate1 = -2 if _n == 2
replace eventplot_aggregate1 = -3 if _n == 3

eventdd  lntotal_adnum_dom RL_EST_L_recip lngdp_L_recip  Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip  GC_LegalRights_L_recip GC_CreditInfo_L_recip RI_L_recip  Bank_C2A_L_recip  DomCredit_by_banks_L_recip lnBankBranch_per100k_L Bank_NPL_L_recip lnMobilePhoneUsage_L_recip if quart_P2P_RegIndex == 1 | quart_P2P_RegIndex == 0, timevar(timeToTreat) method(hdfe, absorb(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) ) graph_op(ytitle("") xlabel(-2(1)2)) ci(rline)   leads(3) lags(3) accum



matrix results_low = e(leads) \ e(lags)

svmat results_low, names(eventplot_low)

**
preserve 

replace timeToTreat = 0 if timeToTreat == .

cap drop timeToTreat_dum*
tabulate timeToTreat, gen(timeToTreat_dum)

gen P2P_Binary_pub_recip_3lead = (timeToTreat_dum2==1 | timeToTreat_dum1 == 1)
gen P2P_Binary_pub_recip_2lead = timeToTreat_dum3
gen P2P_Binary_pub_recip_1lead = timeToTreat_dum4

gen P2P_Binary_pub_recip_0 = timeToTreat_dum5
replace P2P_Binary_pub_recip_0 = 0 if P2P_year_recip == 0

gen P2P_Binary_pub_recip_1lag = timeToTreat_dum6
gen P2P_Binary_pub_recip_2lag = timeToTreat_dum7
gen P2P_Binary_pub_recip_3lag = (timeToTreat_dum8 == 1 | timeToTreat_dum9 == 1 | timeToTreat_dum10 == 1)

drop P2P_Binary_pub_recip_1lead
reghdfe lntotal_adnum_dom P2P_Binary_pub_recip_* RL_EST_L_recip lngdp_L_recip  Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip  GC_LegalRights_L_recip GC_CreditInfo_L_recip RI_L_recip  Bank_C2A_L_recip  DomCredit_by_banks_L_recip lnBankBranch_per100k_L Bank_NPL_L_recip lnMobilePhoneUsage_L_recip if quart_P2P_RegIndex == 1 | quart_P2P_RegIndex == 0,a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

test P2P_Binary_pub_recip_3lead P2P_Binary_pub_recip_2lead

local pretrend_low_p = cond(r(p)<0.001,"P<0.001", "`:di %5.3f `=`r(p)'''")
restore 
**

eventdd  lntotal_adnum_dom RL_EST_L_recip lngdp_L_recip  Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip  GC_LegalRights_L_recip GC_CreditInfo_L_recip RI_L_recip  Bank_C2A_L_recip  DomCredit_by_banks_L_recip lnBankBranch_per100k_L Bank_NPL_L_recip lnMobilePhoneUsage_L_recip if quart_P2P_RegIndex == 2 | quart_P2P_RegIndex == 0, timevar(timeToTreat) method(hdfe, absorb(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year) ) graph_op(ytitle("Suicides per 1m Women") xlabel(-2(1)2)) ci(rline)   leads(3) lags(3) accum


matrix results_high = e(leads) \ e(lags)

svmat results_high, names(eventplot_high)


**
preserve 

replace timeToTreat = 0 if timeToTreat == .

cap drop timeToTreat_dum*
tabulate timeToTreat, gen(timeToTreat_dum)

gen P2P_Binary_pub_recip_3lead = (timeToTreat_dum2==1 | timeToTreat_dum1 == 1)
gen P2P_Binary_pub_recip_2lead = timeToTreat_dum3
gen P2P_Binary_pub_recip_1lead = timeToTreat_dum4

gen P2P_Binary_pub_recip_0 = timeToTreat_dum5
replace P2P_Binary_pub_recip_0 = 0 if P2P_year_recip == 0

gen P2P_Binary_pub_recip_1lag = timeToTreat_dum6
gen P2P_Binary_pub_recip_2lag = timeToTreat_dum7
gen P2P_Binary_pub_recip_3lag = (timeToTreat_dum8 == 1 | timeToTreat_dum9 == 1 | timeToTreat_dum10 == 1)

drop P2P_Binary_pub_recip_1lead
reghdfe lntotal_adnum_dom P2P_Binary_pub_recip_* RL_EST_L_recip lngdp_L_recip  Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip  GC_LegalRights_L_recip GC_CreditInfo_L_recip RI_L_recip  Bank_C2A_L_recip  DomCredit_by_banks_L_recip lnBankBranch_per100k_L Bank_NPL_L_recip lnMobilePhoneUsage_L_recip if quart_P2P_RegIndex == 2 | quart_P2P_RegIndex == 0,a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

test P2P_Binary_pub_recip_3lead P2P_Binary_pub_recip_2lead

local pretrend_high_p =  cond(r(p)<0.001,"P<0.001", "`:di %5.3f `=`r(p)'''")
restore
**

ren eventplot_aggregate1 event_time
drop eventplot_high1 eventplot_low1
twoway rcap eventplot_aggregate2 eventplot_aggregate4 event_time, lc(black) || scatter eventplot_aggregate3 event_time, mc(black) ms(S) 

twoway  rcap eventplot_low2 eventplot_low4 event_time , lc(green)  || scatter eventplot_low3 event_time , mc(green)  ///
|| rcap eventplot_high2 eventplot_high4 event_time , lc(blue) || scatter eventplot_high3 event_time , mc(blue) ms(T) xlabel(#9)  ylabel(-1.5(0.5)1.5)  xtitle("Event Time") ytitle("Effect of Crowdfunding Regulation") yli(0, lc(gs8) lw(thin)) yla(, ang(h)) legend(order(2 "Low-Clarity Regulation" 4 "High-Clarity Regulation")) saving("number_eventplot",replace) note("pretrend p-value: for low-clarity regulation = `pretrend_low_p', for high-clarity regulation = `pretrend_high_p'" )

