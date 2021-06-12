# mlr3gallery

<!-- badges: start -->
[![R CMD Check via {tic}](https://github.com/mlr-org/mlr3gallery/workflows/tic/badge.svg?branch=main)](https://github.com/mlr-org/mlr3gallery/actions)
<!-- badges: end -->

## Add a new post

1. Install `distill` via `install.packages("distill")`.
1. Run `distill::create_post()`.
1. Add a setup chunk to your post

   ````r
    knitr::opts_chunk$set(
     echo = TRUE,
     R.options = list(width = 120)
   )
   ````
1. Write the post and select appropriate categories. Tags are not available.
1. Run `mlr3gallery::name_chunks_mlr3gallery()` to name all chunks of your posts using the pattern `[file-name]-[number]`.
1. Add required packages to the DESCRIPTION file via `usethis::use_package(<package>)`.
1. Render your post locally using `rmarkdown::render()` and preview locally using `rmarkdown::render_site()` and `pkgdown::preview_site()` or (when using RStudio) by clicking on "Build Website" in the "Build" pane.
1. Apply the [mlr-style](https://github.com/mlr-org/mlr3/wiki/Style-Guide#styler-mlr-style) to the post.
1. Open a Pull request and commit only the Rmd file and external images (your local html file and all files generated during the rendering should be ignored automatically).
1. Now CI deploys a preview of the site including the new Rmd.knit
   All auxiliary files will be deployed automatically.
   The preview is available in the Checks menu within the PR.

## CI

All posts are rendered on every push to ensure that all posts can be run without issues.

## Static posts

If it is not feasible to render your posts on the CI, the post can be added to the `_static` folder. 

1. Render the post locally using `rmarkdown::render()` and create a new folder in `_static`.
1. Copy the generated `index.html` and `_files` auxiliary folder to the newly created folder in `_static`.
1. Prefix your `.Rmd` file with an underscore to prevent it from rendering on the CI.
1. Open a Pull request to add your static posts.

## Long running posts

If it takes too long to render some parts of your post on the CI, intermediate results can be loaded with `readRDS()`.

1. Declare a new parameter named `eval_all` using the `params` field within the YAML section.

```r
params:
  eval_all: FALSE
```

2. Add `eval = params$eval_all` to the long running chunk.

````r
```{r chunk-name, eval = params$eval_all}
bmr = benchmark(...)
```
````

3. Add a new chunk that saves the result.

````r
```{r chunk-name, echo = FALSE, eval = params$eval_all}
saveRDS(bmr, "data/bmr.rda")
```
````

4. Add a hidden chunk that loads the intermediate result.

````r
```{r chunk-name, echo = FALSE}
bmr = readRDS("data/bmr.rda")
```
````

Calling `rmarkdown::(post.Rmd, encoding = "UTF-8", params = list(eval_all = TRUE))` executes all chunks of the post.
The CI skips the long running chunks and only loads the intermediate results.

`mlr3` objects stored in an `.rda` file can get incompatible with new package versions.
In this case, we just have to render the posts again with `eval_all = TRUE` and commit the saved `.rda` files.

