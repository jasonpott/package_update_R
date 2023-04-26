# Back up packages

find_origin <- function(x){
  y <- utils::packageDescription(x)[['Repository']]
  if(is.null(y)){
    username <- utils::packageDescription(x)[['RemoteUsername']]
    repo <- utils::packageDescription(x)[['GithubRepo']]
    y <- paste0('https://github.com/',username,'/',repo)
    if(is.null(username)){
      y <- utils::packageDescription(x)[['Author']]
    }
  }
  return(y)
}

# obtain Operating system
os <- Sys.info()['sysname'][[1]]

packages <- installed.packages() |>
  as.data.frame() |>
  dplyr::rowwise() |>
  dplyr::mutate(source = find_origin(Package))

if (os == "Windows"){
write.csv(packages, file = paste0(gsub(pattern = "W",replacement = "w",os), "_installed_packages.csv"))
} else {
  write.csv(packages, file = paste0(gsub(pattern = "M",replacement = "m",os), "_installed_packages.csv"))

}
