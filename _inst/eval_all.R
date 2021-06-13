posts = c(
  "2021-03-09-practical-tuning-series-tune-a-support-vector-machine",
  "2021-03-10-practical-tuning-series-tune-a-preprocessing-pipeline",
  "2021-03-11-practical-tuning-series-build-an-automated-machine-learning-system",
  "2021-02-03-tuning-a-complex-graph",
  "2020-01-30-house-prices-in-king-county",
  "2020-03-11-mlr3pipelines-tutorial-german-credit",
  "2020-03-11-mlr3tuning-tutorial-german-credit",
  "2020-03-30-imbalanced-data"
)

files = list.files(file.path("./_posts/", posts), pattern = "^.*\\.Rmd", full.names = TRUE)
lapply(files, function(file) rmarkdown::render(file, encoding = "UTF-8", params = list(eval_all = TRUE)))
