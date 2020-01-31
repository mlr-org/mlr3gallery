# mlr3gallery

A simple blogdown site for case studies using mlr3.

## Create a new post

Copy and rename an existing post in `content/post/`.
You can render the new post with `rmarkdown::render()`.
To see it integrated into the layout of the page, use:
```r
blogdown::serve_site()
```

Note that you need to have `hugo` installed.

There is currently no automation or CI set-up. Just create a PR with the new Rmd file.
