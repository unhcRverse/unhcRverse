# WARNING - Generated by {fusen} from /dev/dev_fusen.Rmd: do not edit by hand

#' check_github
#' 
#' check latest github version of R package
#' 
#' 
#' @param pkg
#' 
#' @importFrom utils packageVersion

#' 
#' @return list with the comparison between what is in the system and
#'  what is in github
#' 
#' @export


#' @examples
#' # No example - cf - 
#' ## https://github.com/r-lib/pkgcache#using-pkgcache-in-cran-packages
#' 
#' # check_github('vidonne/unhcrthemes')
check_github <- function(pkg) {
  #  withr::local_envvar(
  #     R_USER_CACHE_DIR = tempfile(),
  #     .local_envir = teardown_env()
  #   )
  #   
  # withr::defer(
  #     .Call(pkgcache__gcov_flush),
  #     teardown_env()
  #   )
  # @importFrom pak meta_update pkg_cache_add_file
  # pak::meta_update()
  # pak::pkg_cache_add_file() 
  installed_version <- tryCatch(packageVersion(gsub(".*/", "", pkg)), error=function(e) NA)
  url <- paste0("https://raw.githubusercontent.com/", pkg, "/master/DESCRIPTION")
  
  x <- readLines(url)
  remote_version <- gsub("Version:\\s*", "", x[grep('Version:', x)])
  
  res <- list(package = pkg,
              installed_version = installed_version,
              latest_version = remote_version,
              up_to_date = NA)
  
  if (is.na(installed_version)) {
    message(paste("##", pkg, "is not installed..."))
  } else {
    if (remote_version > installed_version) {
      msg <- paste("##", pkg, "is out of date...")
      message(msg)
      res$up_to_date <- FALSE
    } else if (remote_version == installed_version) {
      message(paste("Package", pkg, " is up-to-date with the last available version"))
      res$up_to_date <- TRUE
    }
  }
  
  return(res)
}




