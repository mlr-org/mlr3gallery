get_stage("install") %>%
  add_step(step_install_deps())

get_stage("script") %>%
  add_code_step({files = list.files("_posts/", pattern = ".Rmd", full.names = TRUE, recursive = TRUE)
     for(f in files) {rmarkdown::render(f)}}) # lapply does not render all posts

# copy static html posts
get_stage("script") %>%
  add_code_step({
    files = list.files("_static", full.names = TRUE)
    file.copy(files, "_posts", recursive = TRUE)
  })

if (ci_get_branch() == "main") {
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
