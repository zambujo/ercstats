# ERC Statistics

## About

An exploration and visualization of the participation of ERC member countries in FP8 using R.

## Data

The [European Research Council (ERC)](https://erc.europa.eu) provides country statistics [freely available online](https://erc.europa.eu/projects-figures/statistics).  The numbers refer to both evaluated and granted projects submitted to the ERC.  Here, the numbers are provided in [CSV](data-raw/erc_country_stats.csv) for analysis.

### Data dictionary

The first 6 rows are shown below:
|iso2c | call_year|funding_scheme |research_domain |research_panel |funded |  n|
|:-----|---------:|:--------------|:---------------|:--------------|:------|--:|
|AL    |      2018|StG            |PE              |PE7            |TRUE   |  0|
|AL    |      2018|StG            |PE              |PE7            |FALSE  |  1|
|AL    |      2018|StG            |SH              |SH1            |TRUE   |  0|
|AL    |      2018|StG            |SH              |SH1            |FALSE  |  1|
|AT    |      2014|StG            |LS              |LS1            |TRUE   |  0|
|AT    |      2014|StG            |LS              |LS1            |FALSE  |  4|

with the following definition:
|Variable        |Class   |Description                 |
|:---------------|:-------|:---------------------------|
|iso2c           |string  |Country `iso2c` code        |
|call_year       |integer |2007 to 2020                |
|funding_scheme  |string  |StG, CoG, AdG, PoC, SyG     |
|research_domain |string  |LS, PE, SH                  |
|research_panel  |string  |LS1 to SH6                  |
|funded          |boolean |                            |
|n               |integer |Number of projects          |

## Tree

```{bash}
.
├── LICENSE
├── README.md
├── data
│   └── erc_country_stats.rds
├── data-raw
│   ├── erc_country_stats.csv
│   ├── metadata.yml
│   └── prepare.R
├── docs
│   └── index.html
├── ercstats.Rproj
└── notebooks
    └── exploration.Rmd
```

## License

Distributed under the MIT License.

## Acknowledgments

- {[countrycode](https://github.com/vincentarelbundock/countrycode)}
- {[ggflags](https://github.com/rensa/ggflags)}
- {[ggbump](https://github.com/davidsjoberg/ggbump)}
- {[wbstats](https://github.com/nset-ornl/wbstats)}
- {[eurostat](https://github.com/rOpenGov/eurostat)}
