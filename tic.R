get_stage("install") %>%
  add_step(step_install_deps())

# WEEKLY run which runs all code
if (ci_get_env("WEEKLY") == "true") {
  get_stage("script") %>%
    add_code_step({
      remotes::install_version("rmarkdown", version = "2.10", repos = "http://cran.us.r-project.org") # 2.11 breaks distill
      files = list.files("_posts/", pattern = ".Rmd", full.names = TRUE, recursive = TRUE)
      for (f in files) {
        rmarkdown::render(f, encoding = "UTF-8", params = list(eval_all = TRUE))
      }
    })
} else {

  get_stage("script") %>%
    add_code_step({
      remotes::install_version("rmarkdown", version = "2.10", repos = "http://cran.us.r-project.org") # 2.11 breaks distill
      files = list.files("_posts/", pattern = ".Rmd", full.names = TRUE, recursive = TRUE)
      for (f in files) {
        rmarkdown::render(f)
      }
    })

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

}
