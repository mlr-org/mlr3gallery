#' @title Clean Post Directory 
#'
#' @description
#' Remove html and ancillary files from `_post` directory.
#'
#' @export
clean_posts_mlr3gallery = function() {
  root = rprojroot::find_package_root_file()
  path = file.path(root, "_posts")
  htmls = list.files(path, pattern = "\\.html$", full.names = TRUE, recursive = TRUE)
  unlink(htmls)
  ancillary_files = list.files("_posts/", pattern = "^.*_files", include.dirs = TRUE, recursive = TRUE, full.names = TRUE)
  unlink(ancillary_files, recursive = TRUE)

  invisible(TRUE)
}
