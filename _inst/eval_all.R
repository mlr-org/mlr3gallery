posts = c(
  "2021-03-09-practical-tuning-series-tune-a-support-vector-machine",
  "2021-03-10-practical-tuning-series-tune-a-preprocessing-pipeline",
  "2021-03-11-practical-tuning-series-build-an-automated-machine-learning-system",
  "2021-02-03-tuning-a-complex-graph",
  "2020-01-30-house-prices-in-king-county",
  "2020-03-11-mlr3pipelines-tutorial-german-credit",
  "2020-03-11-mlr3tuning-tutorial-german-credit",
  "2020-03-30-imbalanced-data",
  "2020-09-14-mlr3fselect-basic",
  "2020-09-11-liver-patient-classification",
  "2020-07-27-bikesharing-demand",
  "2020-05-02-feature-engineering-of-date-time-variables"
)

files = list.files(file.path("./_posts/", posts), pattern = "^.*\\.Rmd", full.names = TRUE)
lapply(files, function(file) rmarkdown::render(file, encoding = "UTF-8", params = list(eval_all = TRUE)))
