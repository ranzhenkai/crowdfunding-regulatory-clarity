*This do file aims to provide a set of main regression tables included in the manuscript
*Only tables based on platform-level data are described in this code:
*Table 8 and Table 11 Panel C Part II
*Other tables are based on country-level data, and are described in another code 

//merge with control variables, so that the final data is ready for generating all platform-level regressions
cd "your directory"
use crowdfunding_platform_level_2015_2020, clear

merge m:1 recipient_country year using regindex_country_level_2015_2020
drop if _merge == 2
drop _merge 

merge m:1 recipient_country year using control_variables
drop if _merge == 2
drop _merge 

cd "your directory"
save platform_panel_data_final, replace 


*****************All Main Tables************************
********************************************************
cd "your directory"
use country_panel_data_final,clear

bys Recipient_country (year): egen switcher_P2P_RegIndex = mean(P2P_RegIndex_pub_L_recip)  if Switcher_P2P_recip == 1 & year >= P2P_year_recip + 1 & year >= 2015 & year <= 2020 & P2P_year_recip!= 0

bys Recipient_country (year): egen switcher_P2P_RegIndex_Adj = mean(P2P_RegIndex_Adj_pub_L_recip)  if Switcher_P2P_recip == 1 & year >= P2P_year_recip + 1 & year >= 2015 & year <= 2020 & P2P_year_recip!= 0

bys Recipient_country (year): replace switcher_P2P_RegIndex = . if year != P2P_year_recip + 1

bys Recipient_country (year): replace switcher_P2P_RegIndex_Adj =. if year != P2P_year_recip + 1

bys Recipient_country (year): egen always_P2P_RegIndex_after = mean(P2P_RegIndex_pub_L_recip)  if Switcher_P2P_recip == 0 & year >= P2P_year_recip + 1 & year >= 2016 & year <= 2020 & P2P_year_recip!= 0

bys Recipient_country (year): egen always_P2P_RegIndex_Adj_after = mean(P2P_RegIndex_Adj_pub_L_recip)  if Switcher_P2P_recip == 0 & year >= P2P_year_recip + 1 & year >= 2016 & year <= 2020 & P2P_year_recip!=0

bys Recipient_country (always_P2P_RegIndex_after): replace always_P2P_RegIndex_after = always_P2P_RegIndex_after[1]

bys Recipient_country (always_P2P_RegIndex_Adj_after): replace always_P2P_RegIndex_Adj_after = always_P2P_RegIndex_Adj_after[1]

bys Recipient_country (year): egen always_P2P_RegIndex_before = mean(P2P_RegIndex_pub_L_recip)  if Switcher_P2P_recip == 0 & year >= P2P_year_recip + 1 & year <= 2015 & P2P_year_recip!= 0

bys Recipient_country (year): egen always_P2P_RegIndex_Adj_before = mean(P2P_RegIndex_Adj_pub_L_recip)  if Switcher_P2P_recip == 0 & year >= P2P_year_recip + 1 &  year <= 2015 & P2P_year_recip!=0


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


***************************************************
***************Regression Analysis*****************
***************************************************

***************************************************
*Table 8*******************************************
***************************************************
***************************************************
cd "your directory"
use platform_panel_data_final,clear

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

est save t8Am1,replace
indeplist
outreg2 t8Am1 using regression_submission_platform_level_Table8A, replace  st(coef tstat) auto(3) nonotes dta  title("Table 8: Impact of Regulation on Platform-Level Domestic and Forgein Debt Crowdfunding Volume. This table reports DiD tests to examine how platform-level domestic debt crowdfunding volume is impacted by changes in regulation. The dependent variable is the log of debt crowdfunding volume per domestic and foreign platform scaled by GDP per capita by country. The independent variables, Regulation index and Adjusted Regulation Index, are, respectively, the raw and normalised measures of the regulatory clarity in the country using indicator variables for different regulation provisions. The independent variable, Switcher, is 1 if the country introduces its first regulation between 2015-2020, and 0 otherwise. All independent variables are described in the Appendix and are lagged by a year. All data is aggregated by platform and year separately from the 2015-2020 global surveys of crowdfunding. Heteroscedasticity-consistent robust standard errors are clustered by country and year, following Thompson (2011). T-statistics are reported in parentheses. *** p<0.01, ** p<0.05, * p<0.1") addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip P2P_RegIndex_Adj_Switcher_recip Switcher_P2P_recip    )  label keep(`r(X)') ctitle("Raw-Domestic")


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

				
est save t8Am2,replace
indeplist
outreg2 t8Am2 using regression_submission_platform_level_Table8A, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip P2P_RegIndex_Adj_Switcher_recip Switcher_P2P_recip    )  label keep(`r(X)') ctitle("Raw-Domestic")


reghdfe lntotal_adfin_in P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip /// 
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

est save t8Am3,replace
indeplist
outreg2 t8Am3 using regression_submission_platform_level_Table8A, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip P2P_RegIndex_Adj_Switcher_recip Switcher_P2P_recip    )  label keep(`r(X)') ctitle("Raw-Foreign")


reghdfe lntotal_adfin_in P2P_RegIndex_pub_L_recip Switcher_P2P_recip P2P_RegIndex_Switcher_recip /// 
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

				
est save t8Am4,replace
indeplist
outreg2 t8Am4 using regression_submission_platform_level_Table8A, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_Adj_pub_L_recip P2P_RegIndex_Adj_Switcher_recip Switcher_P2P_recip    )  label keep(`r(X)') ctitle("Raw-Foreign")


replace P2P_RegIndex_pub_L_recip = P2P_RegIndex_Adj_pub_L_recip
replace P2P_RegIndex_Switcher_recip = P2P_RegIndex_Adj_Switcher_recip


reghdfe lntotal_adfin_dom P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
                 lngdp_L_recip /// 
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

	
est save t8Am5,replace
indeplist
outreg2 t8Am5 using regression_submission_platform_level_Table8A, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip Switcher_P2P_recip    )  label keep(`r(X)') ctitle("Adj-Domestic")


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
local m1 = round((_b[P2P_RegIndex_pub_L_recip] + _b[P2P_RegIndex_Switcher_recip])*`switcher_P2P_RegIndex_Adj',0.001) 
local m2 = round(_b[P2P_RegIndex_pub_L_recip]*`always_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + _b[P2P_RegIndex_Switcher_recip]*`switcher_P2P_RegIndex_Adj',0.001)

test (P2P_RegIndex_pub_L_recip + P2P_RegIndex_Switcher_recip)*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test  P2P_RegIndex_pub_L_recip*`always_P2P_RegIndex_Adj' = 0
local p2 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
test P2P_RegIndex_pub_L_recip*(`switcher_P2P_RegIndex_Adj' - `always_P2P_RegIndex_Adj') + P2P_RegIndex_Switcher_recip*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )


est save t8Am6,replace
indeplist
outreg2 t8Am6 using regression_submission_platform_level_Table8A, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip Switcher_P2P_recip    )  label keep(`r(X)') ctitle("Adj-Domestic")




reghdfe lntotal_adfin_in P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip /// 
                RL_EST_L_recip /// 
                 lngdp_L_recip /// 
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

	
est save t8Am7,replace
indeplist
outreg2 t8Am7 using regression_submission_platform_level_Table8A, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip Switcher_P2P_recip    )  label keep(`r(X)') ctitle("Adj-Foreign")


reghdfe lntotal_adfin_in P2P_RegIndex_pub_L_recip Switcher_P2P_recip  P2P_RegIndex_Switcher_recip /// 
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


est save t8Am8,replace
indeplist
outreg2 t8Am8 using regression_submission_platform_level_Table8A, append  st(coef tstat) auto(3) nonotes dta   addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation: Measure 1",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation: Measure 2",`m2',"p-value (of Measure 2)","(`p2')","Average Effect of Introducing Regulation: Measure 3",`m3',"p-value (of Measure 3)","(`p3')") adjr2  sortvar(P2P_Binary_pub_L_recip P2P_Binary_Switcher_recip P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip P2P_RegIndex_pub_L_recip P2P_RegIndex_Switcher_recip Switcher_P2P_recip    )  label keep(`r(X)') ctitle("Adj-Foreign")







***************************************************
*Table 11******************************************
***************************************************
***************************************************
**Panel C Part II**********************************
***************************************************
***************************************************
cd "your directory"
use country_panel_data_final,clear

bys Recipient_country (year): egen switcher_P2P_RegIndex = mean(P2P_RegIndex_pub_L_recip)  if Switcher_P2P_recip == 1 & year >= P2P_year_recip + 1 & year >= 2015 & year <= 2020 & P2P_year_recip!= 0

bys Recipient_country (year): egen switcher_P2P_RegIndex_Adj = mean(P2P_RegIndex_Adj_pub_L_recip)  if Switcher_P2P_recip == 1 & year >= P2P_year_recip + 1 & year >= 2015 & year <= 2020 & P2P_year_recip!= 0

bys Recipient_country (year): replace switcher_P2P_RegIndex = . if year != P2P_year_recip + 1

bys Recipient_country (year): replace switcher_P2P_RegIndex_Adj =. if year != P2P_year_recip + 1

sum switcher_P2P_RegIndex 
local switcher_P2P_RegIndex = r(mean)

sum switcher_P2P_RegIndex_Adj
local switcher_P2P_RegIndex_Adj = r(mean)


***************************************************
***************************************************
cd "your directory"
use platform_panel_data_final,clear

ren lntotal_adfin_dom lntotal_adfin_dom_plat 
ren lnretail_adfin_dom lnretail_adfin_dom_plat
ren lninst_adfin_dom lninst_adfin_dom_plat

merge m:1 recipient_country year using psm_matched_all_regulations_v3
keep if _merge == 3
drop _merge 


replace indivfunder_numby_model = . if indivfunder_numby_model == 0  |  recipient_country != source_country
replace fundraiser_numby_model = . if fundraiser_numby_model == 0 |  recipient_country != source_country

gen ln_indivfunder_numby_model = ln(1+indivfunder_numby_model)
gen ln_fundraiser_numby_model = ln(1+fundraiser_numby_model)

gen regulated = (P2P_RegIndex_pub_L_recip > 0)

sort CompanyID recipient_country year
bys CompanyID recipient_country (year): gen entry_year = year[1] if altfin_vol_usd[1] != . 

cap drop new_plat
gen new_plat = (entry_year >= P2P_year_recip + 1 & P2P_year_recip != 0) if P2P_year_recip != . & recipient_country == source_country
replace new_plat = 0 if P2P_year_recip == 0 & recipient_country == source_country
replace new_plat = . if recipient_country != source_country

gen P2P_RegIndex_newplat = P2P_RegIndex_pub_L_recip*new_plat
gen P2P_RegIndex_Adj_newplat = P2P_RegIndex_Adj_pub_L_recip*new_plat

label var regulated "Regulated (debt)"
label var new_plat "New Platform Indicator"
label var P2P_RegIndex_newplat "Regulation Index (debt) X New Platform Indicator"
label var P2P_RegIndex_Adj_newplat "Regulation Index (debt) X New Platform Indicator"

global model1 P2P_RegIndex_pub_L_recip new_plat P2P_RegIndex_newplat RL_EST_L_recip lngdp_L_recip Time_startup_L_recip Cost_startup_L_recip Tax_income_pct_L_recip GC_LegalRights_L_recip GC_CreditInfo_L_recip RI_L_recip Bank_C2A_L_recip DomCredit_by_banks_L_recip lnBankBranch_per100k_L_recip Bank_NPL_L_recip lnMobilePhoneUsage_L_recip

global model2 regulated $model1

reghdfe lntotal_adfin_dom_plat $model2 ///
			    if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
local m3 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' + _b[P2P_RegIndex_newplat]*`switcher_P2P_RegIndex',0.001)
test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' + _b[P2P_RegIndex_newplat]*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
 
est save t11CIm1,replace
indeplist

outreg2 t11CIm1 using regression_submission_platform_level_Table11CI, replace  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation for Old Platforms",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation for New Platforms",`m3',"p-value (of Measure 3)","(`p3')") adjr2 label keep(`r(X)') ctitle("Raw-Total") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip new_plat P2P_RegIndex_newplat  P2P_RegIndex_Adj_newplat) title("Table 11 Panel C Part II.1: This table reports the estimation results based on the PSM-matched samples and investigates the conditional effect of regulatory clarity on the domestic debt volume generated on old and new platforms, respectively. The independent variable, New Platform Indicators, equals one if the platform enters the market at least in year after the publication of the explicit regulation. The variable, Regulated, indicates whether the jurisdication has introduced a regulation. All independent variables are described in the Appendix and are lagged by a year. All regressions include country and year fixed effects. Heteroscedasticity-consistent robust standard errors are clustered by country and year, following Thompson (2011). *** p<0.01, ** p<0.05, * p<0.1")

		
reghdfe lnretail_adfin_dom_plat $model2 ///
			    if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
local m3 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' + _b[P2P_RegIndex_newplat]*`switcher_P2P_RegIndex',0.001)
test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' + _b[P2P_RegIndex_newplat]*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
 
est save t11CIm2,replace
indeplist

outreg2 t11CIm2 using regression_submission_platform_level_Table11CI, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation for Old Platforms",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation for New Platforms",`m3',"p-value (of Measure 3)","(`p3')") adjr2 label keep(`r(X)') ctitle("Raw-Retail") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip new_plat P2P_RegIndex_newplat  P2P_RegIndex_Adj_newplat) 


reghdfe lninst_adfin_dom_plat $model2 ///
			    if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
local m3 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' + _b[P2P_RegIndex_newplat]*`switcher_P2P_RegIndex',0.001)
test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' + _b[P2P_RegIndex_newplat]*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
 
est save t11CIm3,replace
indeplist

outreg2 t11CIm3 using regression_submission_platform_level_Table11CI, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation for Old Platforms",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation for New Platforms",`m3',"p-value (of Measure 3)","(`p3')") adjr2 label keep(`r(X)') ctitle("Raw-Inst") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip new_plat P2P_RegIndex_newplat  P2P_RegIndex_Adj_newplat)


preserve 

replace P2P_RegIndex_pub_L_recip = P2P_RegIndex_Adj_pub_L_recip
replace P2P_RegIndex_newplat = P2P_RegIndex_Adj_newplat

				
				
reghdfe lntotal_adfin_dom_plat  $model2 ///
			    if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
	
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' + _b[P2P_RegIndex_newplat]*`switcher_P2P_RegIndex_Adj',0.001)
test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' + _b[P2P_RegIndex_newplat]*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t11CIm4,replace
indeplist

outreg2 t11CIm4 using regression_submission_platform_level_Table11CI, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation for Old Platforms",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation for New Platforms",`m3',"p-value (of Measure 3)","(`p3')") adjr2 label keep(`r(X)') ctitle("Adj-Total") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip new_plat P2P_RegIndex_newplat  P2P_RegIndex_Adj_newplat) 

		
reghdfe lnretail_adfin_dom_plat $model2 ///
			    if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' + _b[P2P_RegIndex_newplat]*`switcher_P2P_RegIndex_Adj',0.001)
test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' + _b[P2P_RegIndex_newplat]*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t11CIm5,replace
indeplist

outreg2 t11CIm5 using regression_submission_platform_level_Table11CI, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation for Old Platforms",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation for New Platforms",`m3',"p-value (of Measure 3)","(`p3')") adjr2 label keep(`r(X)') ctitle("Adj-Retail") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip new_plat P2P_RegIndex_newplat  P2P_RegIndex_Adj_newplat) 


reghdfe lninst_adfin_dom_plat $model2 ///
			    if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
				
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' + _b[P2P_RegIndex_newplat]*`switcher_P2P_RegIndex_Adj',0.001)
test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' + _b[P2P_RegIndex_newplat]*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t11CIm6,replace
indeplist

outreg2 t11CIm6 using regression_submission_platform_level_Table11CI, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation for Old Platforms",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation for New Platforms",`m3',"p-value (of Measure 3)","(`p3')") adjr2 label keep(`r(X)') ctitle("Adj-Inst") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip new_plat P2P_RegIndex_newplat  P2P_RegIndex_Adj_newplat) 

restore









******************************
******************************
******************************
******************************
******************************
******************************

reghdfe ln_indivfunder_numby_model $model2 ///
			    if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)

local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' + _b[P2P_RegIndex_newplat]*`switcher_P2P_RegIndex',0.001)
test _b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test _b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex' + _b[P2P_RegIndex_newplat]*`switcher_P2P_RegIndex' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
 
est save t11CIIm1,replace
indeplist

outreg2 t11CIIm1 using regression_submission_platform_level_Table11CII, replace  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation for Old Platforms",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation for New Platforms",`m3',"p-value (of Measure 3)","(`p3')") adjr2 label keep(`r(X)') ctitle("Raw-ln(funder)") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip new_plat P2P_RegIndex_newplat  P2P_RegIndex_Adj_newplat) title("Table 11 Panel C Part II.2: This table reports the estimation results based on the PSM-matched samples and investigates the effect of regulatory clarity on the domestic debt volume generated on old and new platforms, respectively. The independent variable, New Platform Indicators, equals one if the platform enters the market at least in year after the publication of the explicit regulation. The variable, Regulated, indicates whether the jurisdication has introduced a regulation. All independent variables are described in the Appendix and are lagged by a year. All regressions include country and year fixed effects. Heteroscedasticity-consistent robust standard errors are clustered by country and year, following Thompson (2011). *** p<0.01, ** p<0.05, * p<0.1")


preserve 

replace P2P_RegIndex_pub_L_recip = P2P_RegIndex_Adj_pub_L_recip
replace P2P_RegIndex_newplat = P2P_RegIndex_Adj_newplat



reghdfe ln_indivfunder_numby_model $model2 ///
			    if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' + _b[P2P_RegIndex_newplat]*`switcher_P2P_RegIndex_Adj',0.001)
test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' + _b[P2P_RegIndex_newplat]*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t11CIIm2,replace
indeplist

outreg2 t11CIIm2 using regression_submission_platform_level_Table11CII, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation for Old Platforms",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation for New Platforms",`m3',"p-value (of Measure 3)","(`p3')") adjr2 label keep(`r(X)') ctitle("Adj-ln(funder)") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip new_plat P2P_RegIndex_newplat  P2P_RegIndex_Adj_newplat) 



restore


				
reghdfe ln_fundraiser_numby_model $model2 ///
			    if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
				
local m1 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' + _b[P2P_RegIndex_newplat]*`switcher_P2P_RegIndex_Adj',0.001)
test _b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test _b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' + _b[P2P_RegIndex_newplat]*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )
 
est save t11CIIIm1,replace
indeplist

outreg2 t11CIIIm1 using regression_submission_platform_level_Table11CIII, replace  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation for Old Platforms",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation for New Platforms",`m3',"p-value (of Measure 3)","(`p3')") adjr2 label keep(`r(X)') ctitle("Raw-ln(funder)") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip new_plat P2P_RegIndex_newplat  P2P_RegIndex_Adj_newplat) title("Table 11 Panel C Part II.3: This table reports the estimation results based on the PSM-matched samples and investigates the effect of regulatory clarity on the domestic debt volume generated on old and new platforms, respectively. The independent variable, New Platform Indicators, equals one if the platform enters the market at least in year after the publication of the explicit regulation. The variable, Regulated, indicates whether the jurisdication has introduced a regulation. All independent variables are described in the Appendix and are lagged by a year. All regressions include country and year fixed effects. Heteroscedasticity-consistent robust standard errors are clustered by country and year, following Thompson (2011). *** p<0.01, ** p<0.05, * p<0.1")



preserve 

replace P2P_RegIndex_pub_L_recip = P2P_RegIndex_Adj_pub_L_recip
replace P2P_RegIndex_newplat = P2P_RegIndex_Adj_newplat


				
reghdfe ln_fundraiser_numby_model $model2 ///
			    if year >= 2015 , a(i.Recipient_country i.year) vce(cluster i.Recipient_country##i.year)
local m1 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj',0.001)
local m3 = round(_b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' + _b[P2P_RegIndex_newplat]*`switcher_P2P_RegIndex_Adj',0.001)
test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' = 0
local p1 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

test _b[regulated]+_b[P2P_RegIndex_pub_L_recip]*`switcher_P2P_RegIndex_Adj' + _b[P2P_RegIndex_newplat]*`switcher_P2P_RegIndex_Adj' = 0
local p3 = cond(r(p)<0.001,"P<0.001", "P=`:di %5.3f `=`r(p)'''"  )

est save t11CIIIm2,replace
indeplist

outreg2 t11CIIIm2 using regression_submission_platform_level_Table11CIII, append  st(coef tstat) auto(3) nonotes dta addtext("Recipient country FE & Year FE", "Yes","Average Effect of Introducing Regulation for Old Platforms",`m1',"p-value (of Measure 1)","(`p1')","Average Effect of Introducing Regulation for New Platforms",`m3',"p-value (of Measure 3)","(`p3')") adjr2 label keep(`r(X)') ctitle("Adj-ln(fundraiser)") sortvar(regulated P2P_RegIndex_pub_L_recip P2P_RegIndex_Adj_pub_L_recip new_plat P2P_RegIndex_newplat  P2P_RegIndex_Adj_newplat) 



restore




				


cd "your directory"
use "regression_submission_platform_level_Table8A_dta", clear 
export excel using "regression_results_submission_platform_level.xlsx", sheet("Table8",replace) 

use "regression_submission_platform_level_Table11CI_dta", clear 
export excel using "regression_results_submission_platform_level.xlsx", sheet("Table11.C.II.1",replace) 

use "regression_submission_platform_level_Table11CII_dta", clear 
export excel using "regression_results_submission_platform_level.xlsx", sheet("Table11.C.II.2",replace) 

use "regression_submission_platform_level_Table11CIII_dta", clear 
export excel using "regression_results_submission_platform_level.xlsx", sheet("Table11.C.II.3",replace) 

