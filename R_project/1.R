setwd("c:\\easy_r")
install.packages("KoNLP")
install.packages("wordcloud")
library(KoNLP)
library(wordcloud)
useSejongDic()
data1<-readLines("seoul_new.txt")
data1
data2<-sapply(data1,extractNoun,USE.NAMES=F)
data2
head(unlist(data2),30)
data3<-unlist(data2)
gsub("변경전 글자","변경후 글자","원본데이터")
data3<-gsub("\\d+","",data3)
data3<-gsub("서울시","",data3)
data3<-gsub("서울","",data3)
data3<-gsub("요청","",data3)
data3<-gsub("제안","",data3)
data3<-gsub(" ","",data3)
data3<-gsub("-","",data3)
data3
write(unlist(data3),"seoul_2.txt")
place<-read.table("seoul_2.txt")
place
nrow(place)
wordcount<-table(place)
wordcount
head(sort(wordcount,decreasing =T),20)
data3<-gsub("OO","",data3)
data3<-gsub("개선","",data3)
data3<-gsub("문제","",data3)
data3<-gsub("관리","",data3)
data3<-gsub("민원","",data3)
data3<-gsub("이용","",data3)
data3<-gsub("관련","",data3)
data3<-gsub("시장","",data3)
txt<-readLines("gsubfile.txt")
txt
cnt_txt<-length(txt)
cnt_txt
for(i in 1:cnt_txt){}
write(unlist(data3),"seoul_3.txt")
data4<-read.table("seoul_3.txt")
wordcount(sort(wordcount, decreasing=T),20)
wordcount<-table(data4)
head(sort(wordcount, decreasing=T),20)
library(RColorBrewer)
palete<-brewer.pal(9,"Set3")
wordcloud(names(wordcount),freq=wordcount,scale=c(5,1),rot.per = 0.25,min.freq=1,+random.order = F,random.color=T,colors=palete)
wordcloud(names(wordcount),freq=wordcount,scale=c(5,1),rot.per =0.25,min.freq=1,random.order = F,random.color=T,colors=palete)
legend(0.3,1, "서울시 응답소 요청사항 분석",cex=0.8,fill=NA,border=NA,bg="white",text.col="red",text.font=2,box.col="red")
mergeUserDic(data.frame("서진수","ncn"))
mat1<-matrix(c(1,2,3,4))
mat1
mat2<-matrix(c(1,2,3,4),nrow=2)
mat2
mat3<-matrix(c(1,2,3,4),nrow=2,byrow=T)
mat3
mat3
mat3[,1]
mat3[1,1]
mat4<-matrix(c(1,2,3
               ,4,5,6
               ,7,8,9),nrow=3,byrow=T)
mat4
mat4<-rbind(mat4,c(11,12,13))
mat4
mat5<-matrix(c('a','b','c','d'),nrow=2,byrow=T)
mat5
mat5<-cbind(mat5,c('e','f'))
mat5
colnames(mat5)<-c('First','Second','Third')
mat5
seasons<-matrix(c('봄','여름','가을','겨울'),nrow=2)
seasons
seasons<-matrix(c('봄','여름','가을','겨울'),nrow=2,byrow=T)
seasons
seasons[,2]
seasons<-matrix(c('봄','여름','가을','겨울'),nrow=2,byrow=T)
seasons[,2]
seasons
seasons[,2]
seasons<-matrix(c('봄','여름','가을','겨울'),nrow=2,byrow=T)
seasons
seasons_2<-rbind(seasons,c('초봄','초가을'))

seasons_2     
seasons_3<-cbind(seasons_2,c('초여름','초겨울','한겨울'))
seasons_3
m<-matrix(c(1,2,3,4,5,6,7,8),nrow=4)
m
m<-matirx(c(1,2,3,5,6,7),nrow=3)
m
m[,1]
m
m[2,]
colnames(m)<-c("A","B")
m
list1<-list(name='James Seo', address='Seoul', tel='010-8709-4712', pay=500)
pay=500
list1
m<-rbind(mm,c(9,10,11,12))
mm
list1$name
list1[1:2]
list1$birth<-'1975-10-23'
list1
list1$name<-c('Seojinsu','James Seo')
list1$name
list1$name<-NULL
list1
s<-list(ko='90', ma='100', en='98')
s
s$sc<-'100'
s
s$en
s[2:3]
s$en<-c('95')
s
s$sc<-NULL
s

sum<-s$ko+s$en+s$ma+s$sc
sum

m<-matrix(c(1,2,3,4,5,6,7,8),nrow=4)
m
m<-matirx(c(1,2,3,5,6,7),nrow=3)
m
m[,1]
m
m[2,]
colnames(m)<-c("A","B")
mm<-cbind(m,c(9,10,11,12))
mm
n<-matrix(c(1,2,3,4,5,6,7,8),nrow=2,byrow=T)
n
n[1,]
n[,4]
s<-list(ko=90, ma=100, en=98)
s
s$sc<-100
s
s$en
s[2:3]
s$en<-c(95)
s
sum<-s$ko+s$en+s$ma+s$sc
sum
s
n<-matrix(c(1,2,3,4,5,6,7,8),nrow=2,byrow=T)
n
n[1,]
n[,4]
nn<-rbind(n,c(9,10,11,12))
nn
colnames(n)<-c("A","B","C","D")
n
l<-matrix(c(J,A,V,A,C,A,F,E),nrow=2,byrow=T)
l
stewd("c:\\easy_r")
setwd("c:\\easy_r")
install.packages("KoNLP")
install.packages("wordcloud")
install.packages("stringr")
library(KoNLP)
library(wordcloud)
library(stringr)
useSejongDic()
txt<-readLines("remake2.txt")
place<-sapply(txt,extractNoun,USE.NAMES = F)
place
head(unlist(place),30)


cdata<-unlist(place)
place<-str_replace_all(cdata,"[^[:alpha:]]","")

place<-gsub(" ","",place)
txt<-readLines("성형수술gsub.txt")
txt
cnt_txt<-length(txt)
cnt_txt
i<-1
for(i in 1:cnt_txt){
  place<-gsub((txt[i]),"",place)
}
place

place<-Filter(function(x){nchar(x)>=2},place)
write(unlist(place),"remake_3.txt")
rev<-read.table("remake_4.txt")
nrow(rev)
wordcount<-table(rev)
head(sort(wordcount,decreasing = T),30)
library(RColorBrewer)
palete<-brewer.pal(9,"Set1")
wordcloud(names(wordcount),freq=wordcount,scale=c(5,1),rot.per = 0.25,min.freq=2,random.order = F,random.color=T,colors=palete)
legend(0.3,1, "성형부작용",cex=0.8,fill=NA,border=NA,bg="white",text.col="red",text.font=2,box.col="red")

v1<-c(1:10)

v1
