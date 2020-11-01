library(tidyverse)
library(countrycode)
library(knitr)
library(wbstats)
library(scales)
library(ggrepel)
library(ggflags)
library(ggbump)
library(conflicted)


options(dplyr.summarise.inform = FALSE)
conflict_prefer("filter", "dplyr")
conflict_prefer("lag", "dplyr")
