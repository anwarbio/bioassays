## code to prepare `metafile96` dataset goes here
path96meta<-system.file("exdata","metafile96.csv", package = "bioassays")
metafile96<-read.csv(path96meta,stringsAsFactors = FALSE,strip.white = TRUE,na.strings = c("NA",""),header = TRUE)

usethis::use_data(metafile96, overwrite = TRUE)
