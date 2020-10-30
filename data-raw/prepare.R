library(tidyverse)
library(here)
library(csvy)


# read --------------------------------------------------------------------
df <-
  here("data-raw", "erc_country_stats.csv") %>%
  read_csv()


# logic -------------------------------------------------------------------
panels_in_order <-
  c(paste0("LS", 1:9), paste0("PE", 1:10), paste0("SH", 1:6))

df <- df %>%
  mutate(
    n = as.integer(n),
    call_year = as.integer(call_year),
    projects = fct_relevel(projects, "evaluated", "granted"),
    research_domain = fct_relevel(research_domain, "LS", "PE", "SH"),
    research_panel = fct_relevel(research_panel, panels_in_order),
    funding_scheme = fct_relevel(funding_scheme,
                                 "StG", "CoG", "AdG", "PoC", "SyG"))


# write -------------------------------------------------------------------
df %T>%
  write_csvy(
    metadata = here('data-raw', "metadata.yml"), 
    metadata_only = TRUE) %>%
  write_rds(here('data', 'erc_country_stats.rds'))  



# coda --------------------------------------------------------------------
library(fs)
library(yaml)
library(knitr)
library(jsonlite)


## for documentation
df %>%
  head() %>%
  kable(format = "pipe")

here("data-raw", 
     "metadata.yml") %>%
  read_yaml() %>%
  toJSON() %>%
  fromJSON() %>%
  pluck("fields") %>%
  kable(format = "pipe")

dir_tree(here())
