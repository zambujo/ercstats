# ERC Statistics

<!-- badges: start -->
[![Launch Rstudio Binder](http://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/zambujo/ercstats/master?urlpath=rstudio)
<!-- badges: end -->

## About

An exploration and visualization of the participation of ERC member countries in FP8 using R.

## Data

The [European Research Council (ERC)](https://erc.europa.eu) provides country statistics [freely available online](https://erc.europa.eu/projects-figures/statistics).  The numbers refer to both evaluated and granted projects submitted to the ERC.  Here, the numbers are provided in [CSV](data-raw/erc_country_stats.csv) for analysis.

### Data dictionary

|Variable        |Class     |Description                       |
|:---------------|:---------|:---------------------------------|
|iso2c           |character |`iso2c` country code              |
|call_year       |integer   |`2007` - `2020`                   |
|funding_scheme  |factor    |`StG`, `CoG`, `AdG`, `PoC`, `SyG` |
|research_domain |factor    |`LS`, `PE`, `SH`                  |
|research_panel  |factor    |`LS1` - `SH6`                     |
|projects        |factor    |`evaluated`, `granted`            |
|n               |integer   |number of projects                |

> 💡 _The numbers of evaluated projects can be lower than the number granted projects because of country mobility during the time lag between evaluation and approval of projects._

## Tree

```{bash}
.
├── LICENSE
├── R
│   ├── indicators.R
│   ├── indices.R
│   ├── overview.R
│   ├── packages.R
│   └── rankings.R
├── README.md
├── data
│   └── erc_country_stats.rds
├── data-raw
│   ├── erc_country_stats.csv
│   ├── metadata.yml
│   └── prepare.R
├── docs
│   └── index.html
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
