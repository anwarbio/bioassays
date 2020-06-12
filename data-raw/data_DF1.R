## code to prepare `rawdata384` dataset goes here

## retrieve paths for rawdata
path96data<-system.file("exdata","rawdata96.csv", package = "bioassays")
path96meta<-system.file("exdata","metafile96.csv", package = "bioassays")

rawdata96 <- read.csv(path96data,stringsAsFactors = FALSE,strip.white = TRUE,na.strings = c("NA",""),header = TRUE,skip=1)
metafile96 <- read.csv(path96meta,stringsAsFactors = FALSE,strip.white = TRUE,na.strings = c("NA",""),header = TRUE)


rawdata<-bioassays::plate2df(bioassays::data2plateformat(rawdata96,platetype = 96))

plate_details <- list("compound" = "Taxol",
                      "concentration" = c(0.00,0.01,0.02,0.05,0.10,1.00,5.00,10.00),
                      "type" = c("S1","S2","S3","S4","S5","S6","S7","S8"),
                      "dilution" = 1)
plate_meta<- bioassays::plate_metadata(plate_details,metafile96,mergeby="type")

data_DF1<- dplyr::inner_join(rawdata,plate_meta,by=c("row","col","position"))
data_DF1<-bioassays::reduceblank(data_DF1, x_vector =c("All"),blank_vector = c("Blank"), "value")

usethis::use_data(data_DF1, overwrite = TRUE)
