
setwd("c:\\easy_r")
install.packages("KoNLP")
install.packages("wordcloud")
install.packages("stringr")
library(KoNLP)
library(wordcloud)
library(stringr)
useSejongDic()
txt<-readLines("도서검색색.txt")
place<-sapply(txt,extractNoun,USE.NAMES = F)
place
head(unlist(place),30)


cdata<-unlist(place)
place<-str_replace_all(cdata,"[^[:alpha:]]","")

place<-gsub(" ","",place)
txt<-readLines("성형부작용gsub.txt")
txt
cnt_txt<-length(txt)
cnt_txt
i<-1
for(i in 1:cnt_txt){
  place<-gsub((txt[i]),"",place)
}
place

place<-Filter(function(x){nchar(x)>=2},place)
write(unlist(place),"도서검색색_2.txt")
rev<-read.table("도서검색색_2.txt")
nrow(rev)
wordcount<-table(rev)
head(sort(wordcount,decreasing = T),30)
library(RColorBrewer)
palete<-brewer.pal(9,"Set1")
wordcloud(names(wordcount),freq=wordcount,scale=c(5,1),rot.per = 0.25,min.freq=2,random.order = F,random.color=T,colors=palete)
legend(0.3,1, "성형 부작용1",cex=0.8,fill=NA,border=NA,bg="white",text.col="red",text.font=2,box.col="red")