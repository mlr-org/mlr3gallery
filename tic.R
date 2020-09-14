get_stage("install") %>%
  add_step(step_install_deps())

get_stage("script") %>%
  add_code_step(lapply(list.files("_posts/",
    pattern = ".Rmd",
    full.names = TRUE, recursive = TRUE), rmarkdown::render))

if (ci_get_branch() == "master") {
  get_stage("before_deploy") %>%
    add_step(step_setup_ssh()) %>%
    add_step(step_setup_push_deploy())

  get_stage("deploy") %>%
    add_code_step(rmarkdown::render_site()) %>%
    add_code_step(writeLines("mlr3gallery.mlr-org.com", "docs/CNAME")) %>%
    add_step(step_do_push_deploy(
      path = ".",
      commit_paths = "docs/"))
} else {
  get_stage("deploy") %>%
    add_code_step(rmarkdown::render_site())
}
