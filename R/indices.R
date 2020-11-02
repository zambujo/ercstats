get_figures <- function(data, col, iso2c_codes) {
  col <- enquo(col)
  data %>%
    filter(iso2c %in% iso2c_codes) %>%
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


#' Calculate activity and success indexes for a group of countries
#'
#' @param data A tibble containing ERC country participation data.
#' @param col Unquoted expression for the partitioning variable.
#' @param iso2c_codes A string vector of country iso2c codes.
#'
#' @return A tibble with activity and success indexes by country
#' and by partitioning variable
#'
#' @examples
#'\dontrun{
#' df <- read_rds("data/erc_country_stats.rds")
#' get_indices(df, research_domain, c("CH", "IL"))
#' }
get_indices <- function(data, col, iso2c_codes) {
  if (!("iso2c" %in% names(data)))
    stop("iso2c column not found in data")
  
  if (missing(iso2c_codes))
    iso2c_codes <- pull(distinct(data, iso2c))
  
  if (!all(iso2c_codes %in% pull(data, iso2c)))
    stop("Error: iso2c_codes not all in data$iso2c")
  
  col <- enquo(col)
  if (!(quo_name(col) %in% names(data)))
    stop(paste(quo_name(col), "column not found in data"))
  
  data <- data %>%
    filter(!is.na(!!col))
  
  iso2c_codes %>%
    map_df(
      self_indices,
      data = data,
      col = !!col,
      iso2c_codes = iso2c_codes
    )
}


plot_indices <- function(data,
                         partitioning,
                         title = "Activity and Success Indices",
                         subtitle = "",
                         nc = 3) {
  partitioning <- enquo(partitioning)
  
  ggplot(aes(
    x = activity,
    y = success,
    label = iso2c,
    col = iso2c
  ), data = data) +
    geom_hline(yintercept = 1,
               color = "gray70",
               linetype = "dotted") +
    geom_vline(xintercept = 1,
               color = "gray70",
               linetype = "dotted") +
    geom_point(size = 2,
               alpha = .6) +
    geom_text_repel() +
    labs(
      title = title,
      subtitle = subtitle,
      caption = "Source: ERC",
      x = "Activity Index",
      y = "Success Index"
    ) +
    facet_wrap(as.formula(paste("~", quo_name(partitioning))), ncol = nc) +
    theme_minimal() +
    theme(plot.title.position = "plot",
          legend.position = "none")
}

