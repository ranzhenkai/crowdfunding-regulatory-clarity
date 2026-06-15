# Codebook — `crowdfunding_country_level_2015_2020.dta`

Variable dictionary for the country-level crowdfunding (digital financing) dataset, 2015–2020, from the replication package for **Ran, Rau & Ziegler (2025, _Management Science_)**. Definitions are reproduced from the package documentation (`readme.pdf` / `readme.docx`).

**Conventions.** Crowdfunding volumes are in USD. Platform-origin suffixes: `_agg` = domestic and foreign platforms combined; `_dom` = domestic only; `_in` = foreign only. Investor-group prefixes: `total_` = retail and/or institutional; `retail_` = retail; `inst_` = institutional (`af…` = finance volume, `np…` = number of platforms). A leading `ln…` denotes a GDP-per-capita-scaled, log-transformed measure; a trailing `_L` denotes a one-year lag. `…_peer1` averages over a country's regional peers; `…_peer2` over its crowdfunding peers.

| **Variable** | **Description** |
|----|----|
| recipient_country | Country where funding projects are based. |
| SubRegion_recip | Sub-geographical region of the country where funding projects are based. |
| MajorRegion_recip | Main geographical region of the country where funding projects are based. |
| year | Year in which the funding is raised. |
| total_afdebt_agg | Debt-based crowdfunding volume (in USD) contributed by retail and/or institutional investors across both domestic and foreign platforms for a given country in a year. |
| total_afeq_agg | Equity-based crowdfunding volume (in USD) contributed by retail and/or institutional investors across both domestic and foreign platforms for a given country in a year. |
| retail_afdebt_agg | Debt-based crowdfunding volume (in USD) contributed by retail investors across both domestic and foreign platforms for a given country in a year. |
| retail_afeq_agg | Equity-based crowdfunding volume (in USD) contributed by retail investors across both domestic and foreign platforms for a given country in a year. |
| inst_afdebt_agg | Debt-based crowdfunding volume (in USD) contributed by institutional investors across both domestic and foreign platforms for a given country in a year. |
| inst_afeq_agg | Equity-based crowdfunding volume (in USD) contributed by institutional investors across both domestic and foreign platforms for a given country in a year. |
| total_npdebt_agg | Number of platforms where debt-based crowdfunding products are listed and serve retail and/or institutional investors for a given country in a year. |
| total_npeq_agg | Number of platforms where equity-based crowdfunding products are listed and serve retail and/or institutional investors for a given country in a year. |
| retail_npdebt_agg | Number of platforms where debt-based crowdfunding products are listed and serve at least retail investors for a given country in a year. |
| retail_npeq_agg | Number of platforms where equity-based crowdfunding products are listed and serve at least retail investors for a given country in a year. |
| inst_npdebt_agg | Number of platforms where debt-based crowdfunding products are listed and serve at least institutional investors for a given country in a year. |
| inst_npeq_agg | Number of platforms where equity-based crowdfunding products are listed and serve at least institutional investors for a given country in a year. |
| lntotal_adfin_agg | Debt-based crowdfunding volume (in USD) contributed by retail and/or institutional investors across both domestic and foreign platforms for a given country in a year, after being scaled by GDP per capita and applied a log-transformation. |
| lntotal_adnum_agg | Number of platforms where debt-based crowdfunding products are listed and serve retail and/or institutional investors for a given country in a year, after being applied a log transformation. |
| lntotal_adfin_agg_L | Debt-based crowdfunding volume (in USD) contributed by retail and/or institutional investors across both domestic and foreign platforms for a given country in a year, after being scaled by GDP per capita, applied a log-transformation, and lagged by one year. |
| lntotal_adnum_agg_L | Number of platforms where debt-based crowdfunding products are listed and serve retail and/or institutional investors for a given country in a year, after being applied a log transformation and lagged by one year. |
| total_afdebt_dom | Debt-based crowdfunding volume (in USD) contributed by retail and/or institutional investors across domestic platforms for a given country in a year. |
| total_afeq_dom | Equity-based crowdfunding volume (in USD) contributed by retail and/or institutional investors across domestic platforms for a given country in a year. |
| total_npdebt_dom | Number of domestic platforms where debt-based crowdfunding products are listed and serve retail and/or institutional investors for a given country in a year. |
| total_npeq_dom | Number of domestic platforms where equity-based crowdfunding products are listed and serve retail and/or institutional investors for a given country in a year. |
| retail_afdebt_dom | Debt-based crowdfunding volume (in USD) contributed by retail investors across domestic platforms for a given country in a year. |
| retail_afeq_dom | Equity-based crowdfunding volume (in USD) contributed by retail investors across domestic platforms for a given country in a year. |
| retail_npdebt_dom | Number of domestic platforms where debt-based crowdfunding products are listed and serve at least retail investors for a given country in a year. |
| retail_npeq_dom | Number of domestic platforms where equity-based crowdfunding products are listed and serve at least retail investors for a given country in a year. |
| inst_afdebt_dom | Debt-based crowdfunding volume (in USD) contributed by institutional investors across domestic platforms for a given country in a year. |
| inst_afeq_dom | Equity-based crowdfunding volume (in USD) contributed by institutional investors across domestic platforms for a given country in a year. |
| inst_npdebt_dom | Number of domestic platforms where debt-based crowdfunding products are listed and serve at least institutional investors for a given country in a year. |
| inst_npeq_dom | Number of domestic platforms where equity-based crowdfunding products are listed and serve at least institutional investors for a given country in a year. |
| lntotal_adfin_dom | Debt-based crowdfunding volume (in USD) contributed by retail and/or institutional investors across domestic platforms for a given country in a year, after being scaled by GDP per capita and applied a log-transformation. |
| lntotal_adnum_dom | Number of domestic platforms where debt-based crowdfunding products are listed and serve retail and/or institutional investors for a given country in a year, after being applied a log transformation. |
| lnretail_adfin_dom | Debt-based crowdfunding volume (in USD) contributed by at least retail investors across domestic platforms for a given country in a year, after being scaled by GDP per capita and applied a log-transformation. |
| lnretail_adnum_dom | Number of domestic platforms where debt-based crowdfunding products are listed and serve at least retail investors for a given country in a year, after being applied a log transformation. |
| lninst_adfin_dom | Debt-based crowdfunding volume (in USD) contributed by at least institutional investors across domestic platforms for a given country in a year, after being scaled by GDP per capita and applied a log-transformation. |
| lninst_adnum_dom | Number of domestic platforms where debt-based crowdfunding products are listed and serve at least institutional investors for a given country in a year, after being applied a log transformation. |
| lntotal_aefin_dom | Equity-based crowdfunding volume (in USD) contributed by retail and/or institutional investors across domestic platforms for a given country in a year, after being scaled by GDP per capita and applied a log-transformation. |
| lntotal_aenum_dom | Number of domestic platforms where equity-based crowdfunding products are listed and serve retail and/or institutional investors for a given country in a year, after being applied a log transformation. |
| lnretail_aefin_dom | Equity-based crowdfunding volume (in USD) contributed by retail investors across domestic platforms for a given country in a year, after being scaled by GDP per capita and applied a log-transformation. |
| lnretail_aenum_dom | Number of domestic platforms where equity-based crowdfunding products are listed and serve at least retail investors for a given country in a year, after being applied a log transformation. |
| lninst_aefin_dom | Equity-based crowdfunding volume (in USD) contributed by institutional investors across domestic platforms for a given country in a year, after being scaled by GDP per capita and applied a log-transformation. |
| lninst_aenum_dom | Number of domestic platforms where equity-based crowdfunding products are listed and serve at least institutional investors for a given country in a year, after being applied a log transformation. |
| total_afdebt_in | Debt-based crowdfunding volume (in USD) contributed by retail and/or institutional investors across foreign platforms for a given country in a year. |
| total_afeq_in | Equity-based crowdfunding volume (in USD) contributed by retail and/or institutional investors across foreign platforms for a given country in a year. |
| total_npdebt_in | Number of foreign platforms where debt-based crowdfunding products are listed and serve retail and/or institutional investors for a given country in a year. |
| total_npeq_in | Number of foreign platforms where equity-based crowdfunding products are listed and serve retail and/or institutional investors for a given country in a year. |
| retail_afdebt_in | Debt-based crowdfunding volume (in USD) contributed by retail investors across foreign platforms for a given country in a year. |
| retail_afeq_in | Equity-based crowdfunding volume (in USD) contributed by retail investors across foreign platforms for a given country in a year. |
| retail_npdebt_in | Number of foreign platforms where debt-based crowdfunding products are listed and serve at least retail investors for a given country in a year. |
| retail_npeq_in | Number of foreign platforms where equity-based crowdfunding products are listed and serve at least retail investors for a given country in a year. |
| inst_afdebt_in | Debt-based crowdfunding volume (in USD) contributed by institutional investors across foreign platforms for a given country in a year. |
| inst_afeq_in | Equity-based crowdfunding volume (in USD) contributed by institutional investors across foreign platforms for a given country in a year. |
| inst_npdebt_in | Number of foreign platforms where debt-based crowdfunding products are listed and serve at least institutional investors for a given country in a year. |
| inst_npeq_in | Number of foreign platforms where equity-based crowdfunding products are listed and serve at least institutional investors for a given country in a year. |
| lntotal_adfin_in | Debt-based crowdfunding volume (in USD) contributed by retail and/or institutional investors across foreign platforms for a given country in a year, after being scaled by GDP per capita and applied a log transformation. |
| lntotal_adnum_in | Number of foreign platforms where debt -based crowdfunding products are listed and serve retail and/or institutional investors for a given country in a year, after being applied a log transformation. |
| lnretail_adfin_in | Debt-based crowdfunding volume (in USD) contributed by retail investors across foreign platforms for a given country in a year, after being scaled by GDP per capita and applied a log transformation. |
| lnretail_adnum_in | Number of foreign platforms where debt -based crowdfunding products are listed and serve retail investors for a given country in a year, after being applied a log transformation. |
| lninst_adfin_in | Debt-based crowdfunding volume (in USD) contributed by institutional investors across foreign platforms for a given country in a year, after being scaled by GDP per capita and applied a log transformation. |
| lninst_adnum_in | Number of foreign platforms where debt-based crowdfunding products are listed and serve institutional investors for a given country in a year, after being applied a log transformation. |
| lntotal_aefin_in | Equity-based crowdfunding volume (in USD) contributed by retail and/or institutional investors across foreign platforms for a given country in a year, after being scaled by GDP per capita and applied a log transformation. |
| lntotal_aenum_in | Number of foreign platforms where equity -based crowdfunding products are listed and serve retail and/or institutional investors for a given country in a year, after being applied a log transformation. |
| lnretail_aefin_in | Equity-based crowdfunding volume (in USD) contributed by retail investors across foreign platforms for a given country in a year, after being scaled by GDP per capita and applied a log transformation. |
| lnretail_aenum_in | Number of foreign platforms where equity -based crowdfunding products are listed and serve retail investors for a given country in a year, after being applied a log transformation. |
| lninst_aefin_in | Equity-based crowdfunding volume (in USD) contributed by institutional investors across foreign platforms for a given country in a year, after being scaled by GDP per capita and applied a log transformation. |
| lninst_aenum_in | Number of foreign platforms where equity -based crowdfunding products are listed and serve institutional investors for a given country in a year, after being applied a log transformation. |
| hhind_debfin_total | Herfindahl–Hirschman Index (HHI) of a country's debt-based crowdfunding market (with funding contributed by retail and/or institutional investors). |
| hhind_equfin_total | Herfindahl–Hirschman Index (HHI) of a country's equity-based crowdfunding market (with funding contributed by retail and/or institutional investors). |
| hhind_debfin_retail | Herfindahl–Hirschman Index (HHI) of a country's debt-based crowdfunding market (with funding contributed by retail investors). |
| hhind_equfin_retail | Herfindahl–Hirschman Index (HHI) of a country's equity-based crowdfunding market (with funding contributed by retail investors). |
| hhind_debfin_inst | Herfindahl–Hirschman Index (HHI) of a country's debt-based crowdfunding market (with funding contributed by institutional investors). |
| hhind_equfin_inst | Herfindahl–Hirschman Index (HHI) of a country's equity-based crowdfunding market (with funding contributed by institutional investors). |
| total_afdebt_level_peer1 | Lagged average debt-based domestic crowdfunding volume (scaled by GDP per capita in the peer country) across a country’s regional peer countries in a year. |
| lntotal_afdebt_level_peer1 | Lagged average debt-based domestic crowdfunding volume (scaled by GDP per capita in the peer country) across a country’s regional peer countries in a year, after being applied a log transformation. |
| total_afdebt_growth_peer1 | Lagged average growth rate in debt-based domestic crowdfunding volume (scaled by GDP per capita in the peer country) across a country’s regional peer countries in a year. |
| lntotal_afdebt_growth_peer1 | Lagged average growth rate in debt-based domestic crowdfunding volume (scaled by GDP per capita in the peer country) across a country’s regional peer countries in a year, after being applied a log transformation. |
| total_npdebt_level_peer1 | Lagged average number of debt-based domestic crowdfunding platforms across a country’s regional peer countries in a year. |
| lntotal_npdebt_level_peer1 | Lagged average number of debt-based domestic crowdfunding platforms across a country’s regional peer countries in a year, after being applied a log transformation. |
| total_npdebt_growth_peer1 | Lagged average growth rate in the number of debt-based domestic crowdfunding platforms across a country’s regional peer countries in a year. |
| lntotal_npdebt_growth_peer1 | Lagged average growth rate in the number of debt-based domestic crowdfunding platforms across a country’s regional peer countries in a year, after being applied a log transformation. |
| total_afdebt_level_peer2 | Lagged average debt-based domestic crowdfunding volume (scaled by GDP per capita in the peer country) across a country’s crowdfunding peer countries in a year. |
| lntotal_afdebt_level_peer2 | Lagged average debt-based domestic crowdfunding volume (scaled by GDP per capita in the peer country) across a country’s crowdfunding peer countries in a year, after being applied a log transformation. |
| total_afdebt_growth_peer2 | Lagged average growth rate in debt-based domestic crowdfunding volume (scaled by GDP per capita in the peer country) across a country’s crowdfunding peer countries in a year. |
| lntotal_afdebt_growth_peer2 | Lagged average growth rate in debt-based domestic crowdfunding volume (scaled by GDP per capita in the peer country) across a country’s crowdfunding peer countries in a year, after being applied a log transformation. |
| total_npdebt_level_peer2 | Lagged average number of debt-based domestic crowdfunding platforms across a country’s crowdfunding peer countries in a year. |
| lntotal_npdebt_level_peer2 | Lagged average number of debt-based domestic crowdfunding platforms across a country’s crowdfunding peer countries in a year, after being applied a log transformation. |
| total_npdebt_growth_peer2 | Lagged average growth rate in the number of debt-based domestic crowdfunding platforms across a country’s crowdfunding peer countries in a year. |
| lntotal_npdebt_growth_peer2 | Lagged average growth rate in the number of debt-based domestic crowdfunding platforms across a country’s crowdfunding peer countries in a year, after being applied a log transformation. |

---
_This lists the documented analysis variables. The raw `.dta` also contains a few auxiliary variables (a duplicate-case `Recipient_country` and `AlwaysSwitcher_*`) used in intermediate steps._
