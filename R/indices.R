get_figures <- function(data, col, iso2c_codes) {
  col <- enquo(col)
  data %>%
    filter(iso2c %in% iso2c_codes) %>%
    filter(!is.na(!!col)) %>%
    group_by(!!col, projects) %>%
    summarise(n = sum(n, na.rm = TRUE)) %>%
    ungroup() %>%
    pivot_wider(names_from = projects, values_from = n) %>%
    mutate(shares = evaluated / sum(evaluated),
           success = granted / evaluated) %>%
    select(!!col, shares, success)
}


self_indices <- function(data, col, iso2c_code, iso2c_codes) {
  col <- enquo(col)
  self <- get_figures(data,!!col, iso2c_code)
  less <-
    get_figures(data,!!col,
                setdiff(iso2c_codes, iso2c_code))
  self %>%
    select(!!col) %>%
    bind_cols(tibble(
      activity = pull(self, shares) / pull(less, shares),
      success = pull(self, success) / pull(less, success)
    )) %>%
    mutate(iso2c = iso2c_code)
}

get_indices <- function(data, col, iso2c_codes, long = FALSE) {
  col <- enquo(col)
  if (missing(iso2c_codes))
    iso2c_codes <- pull(distinct(data, iso2c))
  
  result <- iso2c_codes %>%
    map_df(
      self_indices,
      data = data,
      col = !!col,
      iso2c_codes = iso2c_codes
    )
  if (long) {
    result <- result %>%
      pivot_longer(c("activity", "success"), names_to = "index")
  }
  result
}

# tests
iso2c_subset <- "CH"
iso2c_set <- c("CH", "NL", "GB", "BE", "AT")
get_figures(participation, research_domain, iso2c_subset)
self_indices(participation, research_domain, iso2c_subset, iso2c_set)
self_indices(participation, research_domain, "NL", iso2c_set)
get_indices(participation, research_domain, iso2c_set)
