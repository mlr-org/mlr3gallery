# train_gl.R

library(mlr3)
library(mlr3pipelines)

data = tsk("boston_housing")$data()
data = data[, c("medv", "crim", "tax", "town")]
task = TaskRegr$new("boston", backend = data, target = "medv")

g = po("imputemedian") %>>%
  po("imputeoor") %>>%
  po("fixfactors") %>>%
  lrn("regr.rpart")

gl = GraphLearner$new(g)

gl$train(task)

saveRDS(gl, "gl.rds")

feature_info = list(
  feature_names = task$feature_names,
  feature_types = task$feature_types,
  levels = task$levels()
)

saveRDS(feature_info, "feature_info.rds")
