## code to prepare `rawdata96` dataset goes here

## retrieve paths for rawdata
path96data<-system.file("exdata","rawdata96.csv", package = "bioassays")

## read csv
rawdata96<-read.csv(path96data,stringsAsFactors = FALSE,strip.white = TRUE,na.strings = c("NA",""),header = TRUE,skip=1)

usethis::use_data(rawdata96, overwrite = TRUE)
