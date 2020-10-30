library(dplyr)
library(tidyr)
library(wbstats)
options(dplyr.summarise.inform = FALSE)


#' Calculate average values per country over a period of time
#'
#' @param iso2c Character vector of country (or region).
#' @param from  Integer. The initial year of the time period.
#' @param to    Integer. The final year of the time period.
#'
#' @return A tibble with the average values per country and indicator.
get_indicators <- function(iso2c, from = 2014L, to = 2020L) {
  if (missing(iso2c))
    stop("iso2c is missing")
  if (!is.integer(from))
    stop("from not integer")
  if (!is.integer(to))
    stop("to not integer")
  
  indicators <-
    c(
      gerd_percent_gdp = "GB.XPD.RSDV.GD.ZS",
      gdp = "NY.GDP.MKTP.CD",
      population = "SP.POP.TOTL"
    )
  
  result <-
    wb_data(
      indicator = indicators,
      country = iso2c,
      start_date = from,
      end_date = to
    ) %>%
    mutate(gerd = gerd_percent_gdp * gdp / 100) %>%
    select(iso2c, date, gerd, gdp, population) %>%
    pivot_longer(c("gerd", "gdp", "population"),
                 names_to = "indicator",
                 values_to = "value")
  
  result %>%
    group_by(iso2c, indicator) %>%
    summarise(value = mean(value, na.rm = TRUE)) %>%
    ungroup()
}
