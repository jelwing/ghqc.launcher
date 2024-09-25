delete_bgj_script <- function(script) {
  Sys.sleep(10)
  file.remove(script)
}

error_checks <- function(app_name, qc_dir, lib_path) {
  if(!dir.exists(qc_dir)) stop(paste(qc_dir, "does not exist."))
  if(!dir.exists(lib_path)) stop(paste(lib_path, "does not exist. Refer to installation guide and check library path is set to correct location."))
  if(!(app_name) %in% c("ghqc_create_app", "ghqc_update_app", "ghqc_report_app")) stop(paste(app_name, "not found in ghqc package."))
}

run_app <- function(app_name, qc_dir, lib_path) {
 error_checks(app_name = app_name,
              qc_dir = qc_dir,
              lib_path = lib_path
              )

  # needed a way to create a temp file in the qc dir that would ran in a background job in the qc dir
  # the script needed to point towards the ghqc libpaths, load the package, and run the app
  # tried to make it as bare as possible for low dependencies/not to mess with user's own env
  tryCatch({
    script <- tempfile("background", tmpdir = qc_dir, fileext = ".R")
    done_file <- tempfile("job_done", tmpdir = tempdir())

    script_content <- paste(
      'cat("State of session prior to running ghqc:")',
      'lib_paths <- .libPaths()',
      'sessionInfo <- sessionInfo()',
      'lib_paths_indexed <- paste0("[", seq_along(lib_paths), "] ", "\", lib_paths, "\", collapse = "\n")',
      'cat(paste0("Output from .libPaths():\n", lib_paths_indexed))',
      'cat(paste0("Output from sessionInfo():"))',
      'print(sessionInfo())',
      paste0('.libPaths("', lib_path, '")'),
      'library(ghqc)',
      'cat("State of session after running ghqc:")',
      'lib_paths <- .libPaths()',
      'sessionInfo <- sessionInfo()',
      'lib_paths_indexed <- paste0("[", seq_along(lib_paths), "] ", "\", lib_paths, "\", collapse = "\n")',
      'cat(paste0("Output from .libPaths():\n", lib_paths_indexed))',
      'cat(paste0("Output from sessionInfo():"))',
      'print(sessionInfo())',
      paste0('writeLines("done", "', done_file, '")'),
      paste0(app_name, '()'),
      sep = "\n"
    )

    writeLines(script_content, script)

    # create a random port, set it as a sys env so that the shiny app can open to it and then rstudio opens viewer pane to it
    port <- httpuv::randomPort()
    Sys.setenv("GHQC_SHINY_PORT" = port)

    # runs the script within the qc dir and sleeps as its spinning up
    # using stopApp() within shiny seems to close the the viewer pane + causes bg to succeed
    job_id <- rstudioapi::jobRunScript(script, name = app_name, workingDir = qc_dir, importEnv = TRUE)

    # checks if the script is still running before proceeding
    repeat {
      if (file.exists(done_file)) break
      Sys.sleep(1)
    }

    Sys.sleep(5)

    withr::defer(file.remove(script))
    rstudioapi::viewer(sprintf("https://127.0.0.1:%s", port))
  }, error = function(e){
    print(e$message)
  })
}
