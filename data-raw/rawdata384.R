## code to prepare `rawdata384` dataset goes here

## retrieve paths for rawdata
path384data<-system.file("exdata","rawdata384.csv", package = "bioassays")

rawdata384<-read.csv(path384data,stringsAsFactors = FALSE,strip.white = TRUE,na.strings = c("NA",""),header = TRUE,skip=1)

usethis::use_data(rawdata384, overwrite = TRUE)
