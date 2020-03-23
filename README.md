# mlr3gallery

<!-- badges: start -->
![R CMD Check via {tic}](https://github.com/mlr-org/mlr3gallery/workflows/R%20CMD%20Check%20via%20%7Btic%7D/badge.svg?branch=master&event=push)
<!-- badges: end -->

A simple blogdown site for case studies using mlr3.

## Create a new post

Copy and rename an existing post in `content/post/`.
You can render the new post with `rmarkdown::render()`.
To see it integrated into the layout of the page, use:

```r
blogdown::serve_site()
```

Note that you need to have `hugo` installed locally.
