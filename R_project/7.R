setwd("c:\\easy_r")
install.packages("KoNLP")
install.packages("wordcloud")
install.packages("stringr")
library(KoNLP)
library(wordcloud)
library(stringr)
useSejongDic()
txt<-readLines("noh.txt")
nouns<-sapply(txt,extractNoun,USE.NAMES = F)
nouns
head(unlist(nouns),30)
cdata<-unlist(nouns)
nouns<-str_renouns_all(cdata,"[^[:alpha:]]","")
nouns<-gsub(" ","",nouns)
txt<-readLines("nohgsub.txt")
txt
cnt_txt<-length(txt)
cnt_txt
i<-1
for(i in 1:cnt_txt){
  nouns<-gsub((txt[i]),"",nouns)
}
nouns

nouns<-Filter(function(x){nchar(x)>=2},nouns)
write(unlist(nouns),"noh_2.txt")
rev<-read.table("noh_2.txt")
nrow(rev)
wordcount<-table(rev)
head(sort(wordcount,decreasing = T),30)
library(RColorBrewer)
palete<-brewer.pal(9,"Set1")
wordcloud(names(wordcount),freq=wordcount,scale=c(5,0.5),rot.per = 0.25,min.freq=1,random.order = F,random.color=T,colors=palete)
legend(0.3,1, "故노무현 대통령님 연설문 분석",cex=0.8,fill=NA,border=NA,bg="white",text.col="red",text.font=2,box.col="red")

