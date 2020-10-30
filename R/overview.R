library(ggplot2)
library(scales)


#' Bar-plot of country participation by evaluated and granted projects
#'
#' @param df A tibble. 
#' @param title A character .
#' @param subtitle A character.
#' @param caption A character.
#' @param legend_title A character
#'
#' @return A ggplot object.
plot_participation <- function(df,
                               title = "Country Participation",
                               subtitle = "Number of ERC Projects",
                               caption = "Source: ERC website",
                               legend_title = "Projects") {
  df %>% 
  group_by(iso2c, projects) %>%
    summarise(n = sum(n, na.rm = TRUE)) %>%
    mutate(N = n[projects == "evaluated"]) %>%
    ungroup() %>%
    mutate(
      projects = fct_rev(projects),
      country = countrycode(iso2c, "iso2c", "country.name.en"),
      country = fct_reorder(country, N)) %>%
  ggplot(aes(x = country, y = n, fill = projects)) +
    geom_bar(position = "dodge",
             stat = "identity",
             alpha = .7) +
    scale_fill_grey() +
    scale_y_continuous(expand = c(0.001, 0.02, .02, .02),
                       labels = number_format(accuracy = 1)) +
    guides(fill = guide_legend(reverse = TRUE)) +
    labs(
      title = title,
      subtitle = subtitle,
      caption = caption,
      fill = legend_title,
      x = element_blank(),
      y = element_blank()
    ) +
    coord_flip() +
    theme_minimal() +
    theme(
      plot.title.position = "plot",
      axis.ticks.y = element_blank(),
      legend.position = c(.85, 1.05),
      legend.direction = "horizontal",
      legend.key.size = unit(4, "mm"),
      legend.background = element_rect(
        linetype = "dotted",
        fill = alpha("white", 1),
        color = alpha("black", 0.25)
      )
    )
}
