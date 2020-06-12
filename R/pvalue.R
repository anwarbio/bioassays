
#'@importFrom magrittr %>%
#'@importFrom dplyr select
#'@importFrom stats pt
#'@export

pvalue<-function(dataframe,control,sigval){

# Initial setup ##
rowname <- newrowname <- NULL
zzz <- data.frame(stringsAsFactors= FALSE) ## An empty dataframe to dump result
fr<-data.frame(stringsAsFactors= FALSE) ## An empty dataframe to dump result

ctrlcolumn<-names(dataframe)[which(dataframe == control, arr.ind=TRUE)[, "col"]][1]
ctrlcolno<-which( colnames(dataframe)==ctrlcolumn )

if(length(which(dataframe[,ctrlcolno]==control))==1){

  df1<-dataframe
  df1$rowname<-rownames(df1)
  ctrlrows<- as.numeric(which(df1[,ctrlcolumn]==control))
  nonctrlrows<-as.numeric(which(df1[,ctrlcolumn]!=control))
  numb<-nlevels(as.factor(df1[,as.character(ctrlcolumn)]))-1

  df1$newrowname<-"NA"
  df1[ctrlrows,]$newrowname<-as.numeric(df1[ctrlrows,]$rowname)-numb
  df1[nonctrlrows,]$newrowname<-as.numeric(df1[nonctrlrows,]$rowname)+1

  rownames(df1)<-as.numeric(df1$newrowname)
  df1<-dplyr::select(df1,c(-rowname,-newrowname))
  df1 <- df1[ order(row.names(df1)), ]


    for (z in seq_along(rownames(df1))) {

      fr <- df1[z,]
      if(fr[1,ctrlcolno]==control){
        n1<-fr$N
        s1<-fr$SD
        m1<-fr$Mean
        pval<-"control "
        sig<-" "
      }else{

        if(fr[1,ctrlcolno]!=control){
          n2<-fr$N
          s2<-fr$SD
          m2<-fr$Mean
          se <- sqrt( (1/n1 + 1/n2) * ((n1-1)*s1^2 + (n2-1)*s2^2)/(n1+n2-2) )
          df <- n1+n2-2
          t <- (m1-m2)/se
          pval<-stats::pt(-abs(t), df)
          if (pval< sigval) {sig<-"Yes"}
          if (pval>=sigval) {sig <-" "
          pval <- round(pval,3)}
          ifelse (pval<0.001,pval <- "< 0.001", pval<-round(pval,4))
          #pval<-round(stats::pt(-abs(t), df),6)
        }
      }

      fr$pvalue <- pval
      fr$significance <-sig

      zzz<-rbind(zzz,fr)
    }
  rownames(zzz)<-c(seq(1,nrow(zzz),1))
return(zzz)

}else{
   sss<-dataframe[,seq(1,ctrlcolno,1)]
  sss<-dplyr::select(sss,-as.symbol(ctrlcolumn))

#########################

expcolumn<-which(colnames(dataframe)=="label")-1
if(ctrlcolno != expcolumn){stop("Error: Control is not the approprite one for the analysis")}
############################
runs<-c(seq(1,ncol(sss),1))
exp<-""
ord<-""


for (j in seq_along(runs)) {
  assign(paste0("F",runs[j]),unique(sss[,j]))
  exp<-paste0(exp,",",colnames(sss)[j],"=","F",j)
  ord<-paste0(ord, "," ,"grid$",colnames(sss)[j])
}

exp<-sub(",","",exp)
ord<-sub(",","",ord)


grid<- eval(parse(text = paste("expand.grid", "(",exp, ")")))
grid<-eval(parse(text= paste("grid","[","order","(",ord,")",",","]")))
grid<-as.data.frame(grid)
rownames(grid)<-c(seq(1,nrow(grid),1))
grid[] <- lapply(grid, as.character)

###############
df1<-data.frame()
vectorfilters<-colnames(grid)

for (gr in seq(1,nrow(grid),1)) {

  df1<-dataframe
  vector2<-grid[gr,]

  for (i in seq_along(vector2)) {
    df1<-df1 %>% dplyr::filter (get(vectorfilters[i])==as.character(vector2[i]))
  }

  df1$rowname<-rownames(df1)

  ctrlrows<- as.numeric(which(df1[,ctrlcolumn]==control))
  nonctrlrows<-as.numeric(which(df1[,ctrlcolumn]!=control))
  numb<-nlevels(as.factor(df1[,as.character(ctrlcolumn)]))-1

  df1$newrowname<-"NA"
  df1[ctrlrows,]$newrowname<-as.numeric(df1[ctrlrows,]$rowname)-numb
  df1[nonctrlrows,]$newrowname<-as.numeric(df1[nonctrlrows,]$rowname)+numb

  rownames(df1)<-as.numeric(df1$newrowname)
  df1<-dplyr::select(df1,c(-rowname,-newrowname))
  df1 <- df1[ order(row.names(df1)), ]


  for (z in seq(1,nrow(df1),1)) {

    fr <- df1[z,]
    if(fr[1,ctrlcolno]==control){
      n1<-fr$N
      s1<-fr$SD
      m1<-fr$Mean
      pval<-"control "
      sig<-" "
    }else{

      if(fr[1,ctrlcolno]!=control){
        n2<-fr$N
      s2<-fr$SD
      m2<-fr$Mean
      se <- sqrt( (1/n1 + 1/n2) * ((n1-1)*s1^2 + (n2-1)*s2^2)/(n1+n2-2) )
      df <- n1+n2-2
      t <- (m1-m2)/se
      pval<-stats::pt(-abs(t), df)
      if (pval<sigval) {sig<-"Yes"}
      if (pval>sigval){sig <-" "
      pval <- round(pval,3)}
      ifelse(pval<0.001,pval<-"< 0.001", pval<-round(pval,4))
      #pval<-round(stats::pt(-abs(t), df),6)
      }
  }

   fr$pvalue <- pval
   fr$significance <-sig

  zzz<-rbind(zzz,fr)

}
}
  rownames(zzz)<-c(seq(1,nrow(zzz),1))
  return(zzz)
}
}
