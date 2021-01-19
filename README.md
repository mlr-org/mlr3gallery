# mlr3gallery

<!-- badges: start -->
[![R CMD Check via {tic}](https://github.com/mlr-org/mlr3gallery/workflows/tic/badge.svg?branch=master)](https://github.com/mlr-org/mlr3gallery/actions)
<!-- badges: end -->

## Add a new post

1. Install `distill` via `install.packages("distill")`.
1. Run `distill::create_post()`.
1. Add a setup chunk to your post

   ````r
    knitr::opts_chunk$set(
     echo = TRUE,
     R.options = list(width = 80)
   )
   ````
1. Write the post and select appropriate categories. Tags are not available.
1. Add required packages to the DESCRIPTION file via `usethis::use_package(<package>)`.
1. Render your post locally using `rmarkdown::render()` and preview locally using `rmarkdown::render_site()` and `pkgdown::preview_site()` or (when using RStudio) by clicking on "Build Website" in the "Build" pane.
1. Apply the [mlr-style](https://github.com/mlr-org/mlr3/wiki/Style-Guide#styler-mlr-style) to the post.
1. Open a Pull request and commit only the Rmd file and external images (your local html file and all files generated during the rendering should be ignored automatically).
1. Now CI deploys a preview of the site including the new Rmd.
   All auxiliary files will be deployed automatically.
   The preview is available in the Checks menu within the PR.

## CI

All posts are rendered on every push to ensure that all posts can be run without issues.
