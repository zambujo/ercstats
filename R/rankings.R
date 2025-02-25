get_rankings <- function(data, top = 10) {
  if (!("iso2c" %in% names(data)))
    stop("iso2c column not found in data")
  
  if (!("projects" %in% names(data)))
    stop("projects column not found in data")
  
  data %>%
    group_by(iso2c, projects) %>%
    summarise(n = sum(n)) %>%
    ungroup() %>%
    group_split(projects) %>%
    map(function(x)
      arrange(x, desc(n))) %>%
    map(function(x, n = top)
      head(x, n)) %>%
    map(function(x)
      mutate(x, rank = row_number())) %>%
    bind_rows() %>%
    mutate(iso2c = str_to_lower(iso2c),
           projects = as.numeric(projects))
}


plot_rankings <- function(data,
                          title = "Ranking of top-10 participating countries",
                          subtitle = "From evaluated to granted projects",
                          projects_from = "Evaluated",
                          projects_to = "Granted") {
  ggplot(aes(projects, rank, color = iso2c), data = data) +
    geom_bump(size = 2, alpha = .4) +
    geom_flag(data = filter(data, projects == 1),
              aes(x = projects, y = rank, country = iso2c)) +
    geom_flag(data = filter(data, projects == 2),
              aes(x = projects, y = rank, country = iso2c)) +
    scale_x_continuous(
      breaks = 1:2,
      expand = c(0.02, 0, .05, 0),
      labels = c(projects_from, projects_to)
    ) +
    geom_text(
      data = tibble(
        xpos = rep(.95, 10),
        ypos = 1:10,
        txt = as.character(1:10)
      ),
      aes(x = xpos, y = ypos, label = txt),
      size = 3,
      color = "gray40"
    ) +
    scale_y_reverse(breaks = 1:max(pull(data, rank)),
                    labels = number_format(accuracy = 1)) +
    labs(
      title = title,
      subtitle = subtitle,
      x = element_blank(),
      y = element_blank()
    ) +
    theme_minimal() +
    theme(
      axis.text.x = element_text(face = "bold"),
      axis.text.y = element_blank(),
      plot.title.position = "plot",
      legend.position = "none",
      panel.grid = element_blank()
    )
}
