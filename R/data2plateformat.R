# Function format raw data to right plate format
#' @export
data2plateformat <- function (data,platetype = 96){


if(platetype==96){
    rawdata<-data[seq(1,8,1),seq(2,13,1)]
    rownames(rawdata)[seq(1,8,1)]<-LETTERS[seq(1,8,1)]
    colnames(rawdata)[seq(1,12,1)]<-c(seq(1,12,1))
    return(rawdata) }

if(platetype==24){
    rawdata<-data[seq(1,4,1),seq(2,7,1)]
    rownames(rawdata)[seq(1,4,1)]<-LETTERS[seq(1,4,1)]
    colnames(rawdata)[seq(1,6,1)]<-c(seq(1,6,1))
    return(rawdata)}

if(platetype==12){
    rawdata<-data[seq(1,3,1),seq(2,5,1)]
    rownames(rawdata)[seq(1,3,1)]<-LETTERS[seq(1,3,1)]
    colnames(rawdata)[seq(1,4,1)]<-c(seq(1,4,1))
    return(rawdata)}

if(platetype==6){
    rawdata<-data[seq(1,2,1),seq(2,4,1)]
    rownames(rawdata)[seq(1,2,1)]<-LETTERS[seq(1,2,1)]
    colnames(rawdata)[seq(1,3,1)]<-c(seq(1,3,1))
    return(rawdata) }

if(platetype==384){
    rawdata<-data[seq(1,16,1),seq(2,25,1)]
    rownames(rawdata)[seq(1,16,1)]<-LETTERS[seq(1,16,1)]
    colnames(rawdata)[seq(1,24,1)]<-c(seq(1,24,1))
    return(rawdata)}

}
