source_all <- function(folder, recursive = FALSE){ 
  files <- list.files(folder, pattern = "[.][rR]$", 
                      full.names = TRUE, recursive = recursive)
  
  src <- invisible(lapply(files, source))
}