# Codebook — `regindex_country_level_2015_2020.dta`

Variable dictionary for the regulatory clarity index dataset, 2015–2020, from the replication package for **Ran, Rau & Ziegler (2025, _Management Science_)**. Definitions are reproduced from the package documentation (`readme.pdf` / `readme.docx`).

**Conventions.** `P2P_…` = debt-based (peer-to-peer) crowdfunding regulation; `ECF_…` = equity-based crowdfunding regulation. `…_Adj…` = adjusted index; `…_demand…` / `…_supply…` = demand-/supply-side sub-indices; `…_Binary…` = a 0/1 post-regulation indicator; `…_Switcher…` = interaction with the switcher-country indicator; `StrScore` = stringency score. `…_pub…` is measured by the regulation's publication year; a trailing `_L` denotes a one-year lag. `…_peer1` averages over regional peers; `…_peer2` over crowdfunding peers.

| **Variable** | **Description** |
|----|----|
| recipient_country | Country |
| year | Year |
| P2P_RegIndex_pub_recip | Regulatory clarity index of debt-based crowdfunding regulations by the regulation’s publication year |
| P2P_RegIndex_pub_L_recip | Lagged regulatory clarity index of debt-based crowdfunding regulations by the regulation’s publication year |
| P2P_RegIndex_Adj_pub_recip | Adjusted regulatory clarity index of debt-based crowdfunding regulations by the regulation’s publication year |
| P2P_RegIndex_Adj_pub_L_recip | Lagged adjusted regulatory clarity index of debt-based crowdfunding regulations by the regulation’s publication year |
| ECF_RegIndex_pub_recip | Regulatory clarity index of equity-based crowdfunding regulations by the regulation’s publication year |
| ECF_RegIndex_pub_L_recip | Lagged regulatory clarity index of equity-based crowdfunding regulations by the regulation’s publication year |
| ECF_RegIndex_Adj_pub_recip | Adjusted regulatory clarity index of equity-based crowdfunding regulations by the regulation’s publication year |
| ECF_RegIndex_Adj_pub_L_recip | Lagged adjusted regulatory clarity index of equity-based crowdfunding regulations by the regulation’s publication year |
| Switcher_P2P_recip | Switcher country indicator for debt-based regulations |
| Switcher_ECF_recip | Switcher country indicator for equity-based regulations |
| P2P_Binary_pub_recip | Debt-based regulation indicator |
| P2P_Binary_pub_L_recip | Lagged debt-based regulation indicator |
| P2P_Binary_Switcher_recip | P2P_Binary_pub_L_recip X Switcher_P2P_recip |
| ECF_Binary_pub_recip | Equity-based regulation indicator |
| ECF_Binary_pub_L_recip | Lagged equity-based regulation indicator |
| ECF_Binary_Switcher_recip | ECF_Binary_pub_L_recip X Switcher_ECF_recip |
| P2P_RegIndex_Switcher_recip | P2P_RegIndex_pub_L_recip X Switcher_P2P_recip |
| P2P_RegIndex_Adj_Switcher_recip | P2P_RegIndex_Adj_pub_L_recip X Switcher_P2P_recip |
| ECF_RegIndex_Switcher_recip | ECF_RegIndex_pub_L_recip X Switcher_ECF_recip |
| ECF_RegIndex_Adj_Switcher_recip | ECF_RegIndex_Adj_pub_L_recip X Switcher_ECF_recip |
| P2P_demand_pub_recip | Demand-related regulatory clarity index of debt-based crowdfunding regulations by the regulation’s publication year. |
| P2P_demand_pub_L_recip | Lagged demand-related regulatory clarity index of debt-based crowdfunding regulations by the regulation’s publication year. |
| P2P_demand_Adj_pub_recip | Adjusted demand-related regulatory clarity index of debt-based crowdfunding regulations by the regulation’s publication year. |
| P2P_demand_Adj_pub_L_recip | Lagged adjusted demand-related regulatory clarity index of debt-based crowdfunding regulations by the regulation’s publication year. |
| ECF_demand_pub_recip | Demand-related regulatory clarity index of equity-based crowdfunding regulations by the regulation’s publication year. |
| ECF_demand_pub_L_recip | Lagged demand-related regulatory clarity index of equity-based crowdfunding regulations by the regulation’s publication year. |
| ECF_demand_Adj_pub_recip | Adjusted demand-related regulatory clarity index of equity-based crowdfunding regulations by the regulation’s publication year. |
| ECF_demand_Adj_pub_L_recip | Lagged adjusted demand-related regulatory clarity index of equity-based crowdfunding regulations by the regulation’s publication year. |
| P2P_supply_pub_recip | Supply-related regulatory clarity index of debt-based crowdfunding regulations by the regulation’s publication year. |
| P2P_supply_pub_L_recip | Lagged supply-related regulatory clarity index of debt-based crowdfunding regulations by the regulation’s publication year. |
| P2P_supply_Adj_pub_recip | Adjusted supply-related regulatory clarity index of debt-based crowdfunding regulations by the regulation’s publication year. |
| P2P_supply_Adj_pub_L_recip | Lagged adjusted supply-related regulatory clarity index of debt-based crowdfunding regulations by the regulation’s publication year. |
| ECF_supply_pub_recip | Supply-related regulatory clarity index of equity-based crowdfunding regulations by the regulation’s publication year. |
| ECF_supply_pub_L_recip | Lagged supply-related regulatory clarity index of equity-based crowdfunding regulations by the regulation’s publication year. |
| ECF_supply_Adj_pub_recip | Adjusted supply-related regulatory clarity index of equity-based crowdfunding regulations by the regulation’s publication year. |
| ECF_supply_Adj_pub_L_recip | Lagged adjusted supply-related regulatory clarity index of equity-based crowdfunding regulations by the regulation’s publication year. |
| P2P_RegIndex_pub_peer1 | Average regulatory clarity index of debt-based crowdfunding regulations across a country’s regional peer countries. |
| P2P_RegIndex_pub_L_peer1 | Lagged average regulatory clarity index of debt-based crowdfunding regulations across a country’s regional peer countries. |
| P2P_RegIndex_Adj_pub_peer1 | Average adjusted regulatory clarity index of debt-based crowdfunding regulations across a country’s regional peer countries. |
| P2P_RegIndex_Adj_pub_L_peer1 | Lagged average adjusted regulatory clarity index of debt-based crowdfunding regulations across a country’s regional peer countries. |
| ECF_RegIndex_pub_peer1 | Average regulatory clarity index of equity-based crowdfunding regulations across a country’s regional peer countries. |
| ECF_RegIndex_pub_L_peer1 | Lagged average regulatory clarity index of equity-based crowdfunding regulations across a country’s regional peer countries. |
| ECF_RegIndex_Adj_pub_peer1 | Average adjusted regulatory clarity index of equity-based crowdfunding regulations across a country’s regional peer countries. |
| ECF_RegIndex_Adj_pub_L_peer1 | Lagged average adjusted regulatory clarity index of equity-based crowdfunding regulations across a country’s regional peer countries. |
| P2P_RegIndex_pub_peer2 | Average regulatory clarity index of debt-based crowdfunding regulations across a country’s crowdfunding peer countries. |
| P2P_RegIndex_pub_L_peer2 | Lagged average regulatory clarity index of debt-based crowdfunding regulations across a country’s crowdfunding peer countries. |
| P2P_RegIndex_Adj_pub_peer2 | Average adjusted regulatory clarity index of debt-based crowdfunding regulations across a country’s crowdfunding peer countries. |
| P2P_RegIndex_Adj_pub_L_peer2 | Lagged average adjusted regulatory clarity index of debt-based crowdfunding regulations across a country’s crowdfunding peer countries. |
| ECF_RegIndex_pub_peer2 | Average regulatory clarity index of equity-based crowdfunding regulations across a country’s regional peer countries. |
| ECF_RegIndex_pub_L_peer2 | Lagged average regulatory clarity index of equity-based crowdfunding regulations across a country’s crowdfunding peer countries. |
| ECF_RegIndex_Adj_pub_peer2 | Average adjusted regulatory clarity index of equity-based crowdfunding regulations across a country’s crowdfunding peer countries. |
| ECF_RegIndex_Adj_pub_L_peer2 | Lagged average adjusted regulatory clarity index of equity-based crowdfunding regulations across a country’s crowdfunding peer countries. |
| ECF_year_recip | The year in which a country’s first equity-based crowdfunding regulation is introduced. |
| P2P_year_recip | The year in which a country’s first debt-based crowdfunding regulation is introduced. |
| P2P_StrScore_pub_L_recip | Lagged stringency score of debt-based crowdfunding regulations. |
| P2P_StrScore_Adj_pub_L_recip | Lagged adjusted stringency score of debt-based crowdfunding regulations. |

---
_This lists the documented analysis variables. The raw `.dta` also contains a duplicate-case `Recipient_country`._
