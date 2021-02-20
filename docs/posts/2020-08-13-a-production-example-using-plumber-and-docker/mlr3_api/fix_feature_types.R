# fix_feature_types.R

fix_feature_types = function(feature, feature_name, feature_info) {
  id = match(feature_name, feature_info$feature_names)
  feature_type = feature_info$feature_types$type[id]
  switch(feature_type,
    "logical"   = as.logical(feature),
    "integer"   = as.integer(feature),
    "numeric"   = as.numeric(feature),
    "character" = as.character(feature),
    "factor"    = factor(feature, levels = feature_info$levels[[feature_name]],
      ordered = FALSE),
    "ordered"   = factor(feature, levels = feature_info$levels[[feature_name]],
      ordered = TRUE),
    "POSIXct"   = as.POSIXct(feature)
  )
}
