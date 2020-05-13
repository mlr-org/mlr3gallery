##' Reset random sets sets a seed in Random, Python, NumPy and Tensorflow.
##' Futhermore it disables hash seeds, and can disable GPU and CPU parallesim by choice.
##' You may check CPU afterwards by
##' tensorflow <- reticulate::import("tensorflow")
##' print(tensorflow$python$client$device_lib$list_local_devices())
##'
set_seeds = function(seed = 1L,
                     r_s = TRUE,
                     random_s = TRUE,
                     python_s = TRUE,
                     disable_gpu = FALSE,
                     disable_parallel_cpu = FALSE,
                     quiet = FALSE) {

  checkmate::assert_integerish(seed, len = 1L, lower = 1L, all.missing = FALSE)
  if (!is.integer(seed)) seed = as.integer(seed)
  tensorflow = reticulate::import("tensorflow")

  if (tensorflow::tf_version() >= "2.0") {
    tf = tensorflow$compat$v1
    } else tf <- tensorflow

  # call hook (returns TRUE if TF seed should be set, this allows users to
  # call this function even when using front-end packages like keras that
  # may not use TF as their backend)
  using_tf <- tensorflow:::call_hook("tensorflow.on_before_use_session", quiet)
  if (using_tf) tf$reset_default_graph()


  session <- NULL
  config <- configure_session(disable_gpu, disable_parallel_cpu)

  # disable CUDA if requested
  if (disable_gpu) Sys.setenv(CUDA_VISIBLE_DEVICES = "")

  # set seed in...
  if (r_s) set.seed(seed) # R
  if (random_s) {
    random <- import("random")
    random$seed(seed) # Random
  }
  # python and NumPy
  if (python_s) py_set_seed(seed, disable_hash_randomization = TRUE)
  # tensorflow
  tensorflow$random$set_seed(seed)

  if (length(config) > 0L) {
    tf <- tensorflow$compat$v1
    tf$reset_default_graph()
    session_conf <- do.call(tf$ConfigProto, config)
    session <- tf$Session(graph = tf$get_default_graph(), config = session_conf)
    # call after hook
    tensorflow:::call_hook("tensorflow.compat.v1.on_use_session", session, quiet)
    # return  session invisibly
    # tf$keras$backend$set_session(session)
  }
  invisible(session)
}

configure_session <- function(disable_gpu, disable_parallel_cpu) {
  config <- list()
  if (disable_gpu) {
    config$device_count <-  list(gpu = 0L)
  }
  if (disable_parallel_cpu) {
    config$intra_op_parallelism_threads <- 1L
    config$inter_op_parallelism_threads <- 1L
  }
  config
}
