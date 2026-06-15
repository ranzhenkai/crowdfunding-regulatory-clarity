# Global Crowdfunding & Regulatory Clarity Dataset (2015–2020)

_Annual, country-level debt- and equity-based crowdfunding activity worldwide from 2015 to 2020, together with a constructed index of how clearly each country regulates crowdfunding._

Replication data and code for:

> **Ran, Z., Rau, P. R., & Ziegler, T. (2025).** "Sometimes, Always, Never: Regulatory
> Clarity and the Development of Digital Financing." _Management Science_, 71(9),
> 8027–8071. https://doi.org/10.1287/mnsc.2023.01538

This package discloses two country-by-year datasets and the Stata code that produces
the paper's tables. The **platform-level** dataset used in the paper is subject to
confidentiality requirements and is **not** included.

## Datasets

| File                                       | Description                                                                                                                                                                                                                                                                                                                            |
| ------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `crowdfunding_country_level_2015_2020.dta` | Country-level digital financing activity, 2015–2020: debt- and equity-based crowdfunding volumes (USD) and platform counts by investor type (retail / institutional) and origin (domestic / foreign / total), with GDP-scaled and log-transformed versions, market-concentration (HHI) measures, and regional/peer-country aggregates. |
| `regindex_country_level_2015_2020.dta`     | The **regulatory clarity index** constructed by the authors, for debt-based (P2P) and equity-based (ECF) crowdfunding — including adjusted, demand-/supply-side, stringency, switcher, and peer-country variants, plus the year each country first introduced regulation.                                                              |

A complete variable dictionary for every dataset is in **`readme.pdf`** (also
`readme.docx`).

## Code

| File                                                     | Purpose                                                                          |
| -------------------------------------------------------- | -------------------------------------------------------------------------------- |
| `ms_code_submission_regression_tables_sum_stats.do`      | Summary statistics                                                               |
| `ms_code_submission_regression_tables_country_level.do`  | Country-level regression tables                                                  |
| `ms_code_submission_regression_tables_platform_level.do` | Platform-level regression tables (requires the confidential platform-level data) |

Run the `.do` files from this directory (they read the `.dta` files by name). The
`*.log` files are the original run outputs, included for reference.

## Sources

- **Crowdfunding activity:** Cambridge Centre for Alternative Finance (CCAF).
- **Macro & governance controls:** World Bank, World Development Indicators (WDI).
- **Regulatory clarity index:** constructed by the authors.

## Terms of use

The code may be used freely. If you use these data, please **cite the paper above**
and retain the original data-source attributions (CCAF, World Bank WDI). Please note
the confidential platform-level data are not redistributed here.
