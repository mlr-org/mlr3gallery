get_stage("install") %>%
  add_step(step_install_deps())

get_stage("script") %>%
  add_code_step(lapply(list.files("_posts/",
    pattern = ".Rmd",
    full.names = TRUE, recursive = TRUE), rmarkdown::render))
