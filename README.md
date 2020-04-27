# mlr3gallery

<!-- badges: start -->
[![R CMD Check via {tic}](https://github.com/pat-s/mlr3gallery/workflows/R%20CMD%20Check%20via%20{tic}/badge.svg?branch=master)](https://github.com/pat-s/mlr3gallery/actions)
<!-- badges: end -->

## Add a new post

1. Install `distill` via install.packages("distill")`.
1. Run `distill::create_blog()`.
1. Add a setup chunk to your post
    
   ````r
   ```{r setup, include=FALSE}
   knitr::opts_chunk$set(
   echo = TRUE,
   R.options = list(width = 80)
   )
   ```
   ````
1. Write the post and select appropriate categories.
1. Add required packages to DESCRIPTION file via `usethis::use_package(<package>)`.
1. Render the post (`rmarkdown::render(<post>)`.
   The website can be previewed using `rmarkdown::render_site()` and `pkgdown::preview_site()` or (when using RStudio) by clicking on "Build Website" in the "Build" pane.
1. Apply the [mlr-style](https://github.com/mlr-org/mlr3/wiki/Style-Guide#styler-mlr-style) to the post.
1. Check if everything looks good.
1. Open Pull Request for review (the `docs/` directory needs to be included - this is the directory that is going to be served via gh-pages)

## CI

All posts are rendered on every push to ensure that all posts can be run without issues.
