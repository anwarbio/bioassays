## code to prepare `metafile384` dataset goes here

path384meta<-system.file("exdata","metafile384.csv", package = "bioassays")
metafile384<-read.csv(path384meta,stringsAsFactors = FALSE,strip.white = TRUE,na.strings = c("NA",""),header = TRUE)

usethis::use_data(metafile384, overwrite = TRUE)
