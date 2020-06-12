## code to prepare `rawdata24` dataset goes here

path24data<-system.file("exdata","rawdata24well.csv", package = "bioassays")

rawdata24<-read.csv(path24data,stringsAsFactors = FALSE,strip.white = TRUE,na.strings = c("NA",""),header = TRUE, skip=1)

usethis::use_data(rawdata24, overwrite = TRUE)
