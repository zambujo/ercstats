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
    ungroup() %>%
    pivot_wider(names_from = indicator, values_from = value)
}


plot_indicators <- function(df,
                            x_lab,
                            y_lab = "Granted Projects",
                            caption = "Source: ERC website, World Bank") {
  ggplot(aes(x, y, label = iso2c, col = eu28), data =df) +
    scale_color_grey(start = 0, end = .5) +
    geom_smooth(
      method = "lm",
      se = FALSE,
      col = "gray85",
      size = .8
    ) +
    geom_point(size = 1.5, alpha = .5) +
    geom_text_repel(size = 3, show.legend = FALSE) +
    scale_y_log10(labels = number_format(accuracy = 1)) +
    scale_x_log10(labels = number_format(accuracy = 1)) +
    labs(
      caption = caption,
      color = element_blank(),
      x = x_lab,
      y = y_lab
    ) +
    theme_minimal() +
    theme(
      plot.title.position = "plot",
      legend.position = c(.17, .96),
      legend.direction = "horizontal",
      legend.key.size = unit(4, "mm"),
      legend.background = element_rect(
        linetype = "dotted",
        fill = alpha("white", 1),
        color = alpha("black", 0.25)
      )
    )
}
