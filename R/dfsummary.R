
#'@importFrom magrittr %>%
#'@importFrom dplyr filter select group_by
#'@export


dfsummary<-function(dataframe,y,grp_vector,rm_vector,nickname,rm="FALSE",param){

position <- NULL
zzz <- data.frame(stringsAsFactors= FALSE) ## An empty dataframe to dump result

## Removing rm_vector ####
filterdata<-dataframe
if("row" %in% colnames(filterdata)){filterdata<-dplyr::select(filterdata, -row)}
if("col" %in% colnames(filterdata)){filterdata<-dplyr::select(filterdata, -col)}
if("position" %in% colnames(filterdata)){filterdata<-dplyr::select(filterdata, -position)}

for (b in seq_along(rm_vector)) {
  ycolumn<-names(filterdata)[which(filterdata == (rm_vector[b]), arr.ind=TRUE)[, "col"]][1]
  if(is.na(ycolumn)){
    }else{filterdata <-filterdata %>% dplyr::filter (get(ycolumn) != (rm_vector[b]))}
}
rownames(filterdata)<-c(seq_along(rownames(filterdata)))

### order of filtering###
var<-c(grp_vector,y)
var<-var[!(duplicated(var))]

##catagorizing data columns #####
filterdata<- filterdata %>% dplyr::group_by(!!(as.name(var[1]))) %>% dplyr::select(var)

n<-ncol(filterdata)
for (q in seq(1,n,1)) {
  if (q==n){
    filterdata[, q] <- filterdata[,q]<-vapply(filterdata[,q],
                                              function(x) as.numeric(x),
                                              numeric(nrow(filterdata)))}
  else{
    filterdata[, q] <- vapply(filterdata[,q],
                              function(x) as.character(x),
                              character(nrow(filterdata)))}
}

colnames(filterdata)<-var
filterdata<-as.data.frame(filterdata)

###

runs<-c(seq(1,ncol(filterdata)-1,1))
exp<-""
ord<-""
cyc<-list("NA")

# grid layout of filter strategy ###
for (j in seq_along(runs)) {
  assign(paste0("F",runs[j]),unique(filterdata[,j]))
  cyc<-c(cyc,list(eval(print(as.symbol(paste0("F",j))))))
  exp<-paste0(exp,",",colnames(filterdata)[j],"=","F",j)
  ord<-paste0(ord, "," ,"grid$",colnames(filterdata)[j])
}

exp<-sub(",","",exp)
ord<-sub(",","",ord)
cyc<-cyc[-1]

grid<- eval(parse(text = paste("expand.grid", "(",exp, ")")))
grid<-eval(parse(text= paste("grid","[","order","(",ord,")",",","]")))
grid<-as.data.frame(grid)
rownames(grid)<-c(seq_along(rownames(grid)))
grid[] <- lapply(grid, as.character)

## params for strict summerizing #
df1<-data.frame()
vectorfilters<-colnames(grid)
strict<-as.character(param["strict"])
cutoff<-as.integer(param["cutoff"])
n<- as.integer(param["n"])

#### Filtering and summerizing ###
for (gr in seq_along(rownames(grid))) {
  df1<-filterdata
  vector2<-grid[gr,]

  for (i in seq_along(vector2)) {
    df1<-df1 %>% dplyr::filter (get(vectorfilters[i])==as.character(vector2[i]))
  }

  vv<-df1[,y]
  if(rm=="FALSE"){cal<- rmodd_summary(vv, rm = "FALSE")}
  if(rm=="TRUE"){ cal<- rmodd_summary(vv, rm = "TRUE", strict, cutoff,n) }

  calculations<-data.frame(label=nickname,N=cal[3],
                           Mean=round(cal[1],3),
                           SD=round(cal[4],3),
                           CV=round(abs(cal[5]),2))

  rownames(calculations)<-gr

  calculations<-cbind(grid[gr,],calculations)
  zzz = rbind(zzz,calculations)
}

return (zzz)

}

