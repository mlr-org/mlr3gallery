# predict_gl.R

library(data.table)
library(jsonlite)
library(mlr3)
library(mlr3pipelines)

source("fix_feature_types.R")

gl = readRDS("gl.rds")

feature_info = readRDS("feature_info.rds")

#* @post /predict_medv
function(req) {
  # get the JSON string from the post body
  newdata = fromJSON(req$postBody, simplifyVector = FALSE)
  # expect either JSON objects in an array or nested JSON objects
  newdata = rbindlist(newdata, use.names = TRUE)
  # convert all features in place to their expected feature_type
  newdata[, colnames(newdata) := mlr3misc::pmap(
    list(.SD, colnames(newdata)),
    fix_feature_types,
    feature_info = feature_info)]
  # predict and return as a data.table
  as.data.table(gl$predict_newdata(newdata))
  # or only the numeric values
  # gl$predict_newdata(newdata)$response
}
