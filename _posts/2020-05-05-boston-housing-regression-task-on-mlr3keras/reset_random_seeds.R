##' Reset random sets sets a seed in Random, Python, NumPy and Tensorflow.
##' Futhermore it disables hash seeds, and can disable GPU and CPU
##' parallesim by choice
##' You may check CPU afterwards by
##' print(tensorflow$python$client$device_lib$list_local_devices())
##'
reset_random_seeds <- function(seed = 1L,
                               disable_gpu = FALSE,
                               disable_parallel_cpu = FALSE) {
  checkmate::assert_integerish(seed, len = 1L, lower = 1L, all.missing = FALSE)
  if (!is.integer(seed)) seed <- as.integer(seed)

  # note what has been disabled
  disabled <- character()
  config <- list()
  session <- NULL

  # disable CUDA if requested
  if (disable_gpu) {
    Sys.setenv(CUDA_VISIBLE_DEVICES = "")
    config$device_count <-  list(gpu = 0L)
    disabled <- c(disabled, "GPU")
  }
  if (disable_parallel_cpu) {
    config$intra_op_parallelism_threads <- 1L
    config$inter_op_parallelism_threads <- 1L
    disabled <- c(disabled, "CPU parallelism")
  }
  # set seed in...
  set.seed(seed) # R
  random <- import("random")
  random$seed(seed) # Random
  numpy <- import("numpy")
  numpy$random$seed(seed) # NumPy
  # disable hash randomization before importing tensorflow
  os <- import("os")
  os$environ$setdefault("PYTHONHASHSEED", value = "str(1)")
  # set tensorflow seed
  tensorflow <- import("tensorflow")
  tensorflow$random$set_seed(seed)
  if (length(config) > 0L) {
    tf <- tensorflow$compat$v1
    session_conf <- do.call(tf$ConfigProto, config)
    session <- tf$Session(graph = tf$get_default_graph(), config = session_conf)
    tf$keras$backend$set_session(session)
  }
}
