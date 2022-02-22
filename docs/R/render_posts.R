#' @title Render Gallery Posts
#'
#' @description
#' Renders all rmarkdown files in the `_posts`  directory.
#'
#' @param time (`integer(1)`)\cr
#'   A posts is skipped when the file was rendered less than `time` minutes ago.
#' @param eval_all (`logical(1)`)\cr
#'   If `TRUE`, all chunks are evaluated and intermediate results are stored.
#'
#' @export
render_posts = function(time = 0, eval_all = FALSE) {
  dirs = list.dirs("_posts/", full.names = TRUE, recursive = FALSE)

  walk(dirs, function(dir) {
    rmd = list.files(dir, pattern = ".Rmd", full.names = TRUE, recursive = FALSE)
    html = list.files(dir, pattern = ".html", full.names = TRUE, recursive = FALSE)

    if (!length(html) || difftime(Sys.time(), file.info(html)$mtime, units = "mins") > time) {
       rmarkdown::render(rmd, encoding = "UTF-8", params = list(eval_all = eval_all))
    }
  })

  invisible(TRUE)
}
