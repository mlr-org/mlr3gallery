do_blogdown(path = "docs", orphan = TRUE)

get_stage("deploy") %>%
  add_code_step(writeLines("mlr3gallery.mlr-org.com", "docs/CNAME"))
