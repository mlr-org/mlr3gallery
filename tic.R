get_stage("install") %>%
  add_step(step_install_deps()) %>%
  add_code_step(blogdown::install_hugo())

get_stage("deploy") %>%
  add_code_step(blogdown::build_site()) %>%
  add_code_step(writeLines("mlr3gallery.mlr-org.com", "docs/CNAME"))

if (ci_can_push() && !ci_is_tag()) {
  get_stage("before_deploy") %>%
    add_step(step_setup_ssh())

  if (ci_get_branch() == "master") {
    get_stage("deploy") %>%
      add_step(step_setup_push_deploy(path = "docs", branch = "gh-pages",
        orphan = TRUE)) %>%
      add_step(step_do_push_deploy(path = "docs"))
  }
}
