setwd("c:\\easy_r")
install.packages("KoNLP")
install.packages("wordcloud")
install.packages("RColorBrewer")

library(KoNLP)
library(wordcloud)

alert<-readLines("oracle_alert_testdb.log")
error_1<-gsub(" ","_",alert)

head(unlist(error_1),20)
error_2<-unlist(error_1)
error_2<-Filter(function(x) {nchar(x)>=5},error_2)

error_3<-grep("^ORA-+",error_2,value=T)
head(unlist(error_3),20)
write(unlist(error_3),"alert_testdb2.log")
rev<-read.table("alert_testdb2.log")
nrow(rev)
errorcount<-table(rev)
head(sort(errorcount,decreasing = T),20)

library(RColorBrewer)
palete<-brewer.pal(9,"Set1")
wordcloud(names(errorcount),freq=errorcount,scale=c(5,0.5),rot.per = 0.25,min.freq=3,random.order = F,random.color=T,colors=palete)

legend(0.3,1, "Oracle Alert Log File 분석 결과",cex=0.8,fill=NA,border=NA,bg="white",text.col="red",text.font=2,box.col="red")
