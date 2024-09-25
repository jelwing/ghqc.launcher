#' @title Initialize QC checklists for a set of files on Github
#' @description
#' This function allows the user to initialize QC checklists for a set of files on Github.
#'
#' To initialize QC checklists, the user:
#' 1) names a new QC milestone or selects an existing on to coalesce a set of files to be QCed,
#' 2) optionally sets a milestone description if the user opts to create a new milestone,
#' 3) optionally selects a set of collaborators to assign to various checklists in the QC milestone,
#' 4) selects a set of files from the file tree on the right side of the pane,
#' 5) allocates a checklist type to each file, along with an optional assignee, and finally
#' 6) posts the QC milestone by clicking "Create QC Items" on the bottom of the pane.
#'
#' At any time, the user can:
#' - Click `checklist info` to the right of the file tree to view the items in each checklist
#' - Click `preview` next to any file to view its current contents
#'
#' @examples
#' # example code
#' run_ghqc_create_app()
#'
#' @param app_name the name of the app to run in the background
#' @param qc_dir the directory in which the app is run
#' @param lib_path the path to the ghqc package and its dependencies
#'
#' @seealso \link{run_ghqc_update_app} and \link{run_ghqc_report_app}
#'
#' @export
run_ghqc_create_app <- function(app_name = "ghqc_create_app",
                                qc_dir = getwd(),
                                lib_path = "~/ghqc-rpkgs/") {
  run_app(app_name = app_name,
          qc_dir = qc_dir,
          lib_path = lib_path)
}



#' @title Update a QC issue with script changes amid QC
#' @description
#' This function allows a user to update a QC issue with a comment that gives context surrounding changes to the QC file.
#' An update comment indicates the hash and git sha of the updated file and an optionally displays the file difference between versions.
#'
#' To use this app, first initialize a set of QC issues with \link{run_ghqc_create_app}.
#'
#' To update a QC issue, the user:
#' 1) optionally selects the milestone of the relevant QC issue (for ease of filtering)
#' 2) selects the QC issue they'd like to update
#' 3) optionally gives a contextualizing message about the file changes
#' 4) indicates whether or not display the file difference
#' 5) chooses whether to
#'      - compare the original version with the most recent or,
#'      - manually select an older file version (reference) to compare with a newer file version (comparator)
#' 6) optionally previews the comment before posting it, and finally
#' 7) posts the comment on the Github QC issue
#'
#'
#' @param app_name the name of the app to run in the background
#' @param qc_dir the directory in which the app is run
#' @param lib_path the path to the ghqc package and its dependencies
#'
#' @examples
#' # example code
#' run_ghqc_update_app()
#'
#' @seealso \link{run_ghqc_create_app} and \link{run_ghqc_report_app}
#'
#' @export
run_ghqc_update_app <- function(app_name = "ghqc_update_app",
                                qc_dir = getwd(),
                                lib_path = "~/ghqc-rpkgs/") {
  run_app(app_name = app_name,
          qc_dir = qc_dir,
          lib_path = lib_path)
}

#' @title Generate a report for a set of QC milestones
#' @description
#' This function allows the user to generate a report for a set of QC milestones on Github,
#' created with the \link{run_ghqc_create_app}, whose issues have been optionally updated with the \link{run_ghqc_update_app}.
#'
#' To generate a QC report, the user selects the set of QC milestones to include in the report.
#'
#' The user can optionally:
#'
#' 2) give a name for the pdf, else the report will be named after the remote repository and milestones
#' 3) give the directory in which to generate the pdf
#' 4) indicate whether the report should only include the summary table of QC issues for each milestone
#'
#' Finally, the user clicks "Generate QC Report" at the bottom of the pane.
#'
#' @param app_name the name of the app to run in the background
#' @param qc_dir the directory in which the app is run
#' @param lib_path the path to the ghqc package and its dependencies
#'
#' @examples
#' # example code
#' run_ghqc_report_app()
#'
#' @seealso \link{run_ghqc_create_app} and \link{run_ghqc_update_app}
#'
#' @export
run_ghqc_report_app <- function(app_name = "ghqc_report_app",
                                qc_dir = getwd(),
                                lib_path = "~/ghqc-rpkgs/") {
  run_app(app_name = app_name,
          qc_dir = qc_dir,
          lib_path = lib_path)
}

