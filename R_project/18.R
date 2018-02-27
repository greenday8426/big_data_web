install.packages("googleVis")
Fruits
aggregate(Sales~Year,Fruits,sum)
aggregate(Sales~Fruit,Fruits,sum)
aggregate(Sales~Fruit,Fruits,max)
aggregate(Sales~Fruit+Year,Fruits,max)
mat1<-matrix(c(1,2,3,4,5,6),nrow=2,byrow=T)
mat1
apply(mat1,1,sum)
apply(mat1,2,sum)
apply(mat1[,c(2,3)],2,max)

list1<-list(Fruits$Sales)
list1
list2<-list(Fruits$Profit)
lapply(c(list1,list2),max)
sapply(c(list1,list2),max)
lapply(Fruits[,c(4,5)],max)
sapply(Fruits[,c(4,5)],max)
Fruits
tapply(Sales,Fruit,sum)
attach(Fruits)
tapply(Sales,Fruit,sum)
tapply(Sales,Year,sum)
vec1<-c(1,2,3,4,5)
vec2<-c(10,20,30,40,50)
vec3<-c(100,200,300,400,500)
mapply(sum,vec1,vec2,vec3)

data2<-read.csv("1-4호선승하차승객수.csv",header=T)
data2
tapply(data2[,c(3)],sum)
apply(data1[c(1:5),c(2:15)],1,sum)

apply(data2,2,sum)


mat1
a<-c(1,1,1)
sweep(mat1,2,a)
a<-c(1,2,3,4,5)
length(a)
Fruits
length(Fruits)
sort1<-Fruits$Sales
sort1
sort(sort1)
sort(sort1,decreasing = T)

setwd("c:\\easy_r")
install.packages("plyr")
library(plyr)
fruits<-read.csv("fruits_10.csv",header=T)
fruits
ddply(fruits,'name',summarise,sum_qty=sum(qty),sum_price=sum(price))
ddply(fruits,'name',summarise,max_qty=max(qty),min_price=min(price))
ddply(fruits,c('year','name'),summarise,max_qt=max(qty),min_price=min(price))
ddply(fruits,'name',transform,sum_qty=sum(qty),pct_qty=(100*qty)/sum(qty))
install.packages("dplyr")
setwd("c:\\easy_r")
data1<-read.csv("2013년_프로야구선수_성적.csv")
data1
data2<-filter(data1,경기>120)
data2
data3<-filter(data1,경기>120 & 득점>80)
data3
data4<-filter(data1,포지션%in%c('1루수','3루수'))
data4
select(data1,선수명,포지션,팀)
select(data1,순위:타수)
select(data1,-홈런,-타점,-도루)
data1%>%
  select(선수명,팀,경기,타수)%>%
  filter(타수>400)
data1%>%
  select(선수명,팀,경기,타수)%>%
  filter(타수>400)%>%
  arrange(타수)
data1%>%
  select(선수명,팀,경기,타수)%>%
  mutate(경기X타수=경기*타수)%>%
  arrange(경기x타수)

data1%>%
  group_by(팀)%>%
  summarise(average=mean(경기,na.rm=TRUE))
data1%>%
  group_by(팀)%>%
  summarise_each(funs(mean),경기,타수)

data1%>%
  group_by(팀)%>%
  summarise_each(funs(mean,n()),경기,타수)

data1%>%
  group_by(팀)%>%
  summarise_each(funs(mean,n()),경기,타수)

data1%>%
  group_by(팀)%>%
  summarise_each(funs(mean,n()),경기,타수)
install.packages("reshape2")

data1

install.packages("sqldf")
data1%>%
  group_by(팀)%>%
  summarise_each(funs(mean,n()),경기,타수)




install.packages("googleVis")
attach(Fruits)
Fruits
Fruits_2<-filter(Fruits,Expenses>80)
Fruits_2
Fruits_3<-filter(Fruits,Expenses>90 &Sales>90)
Fruits_3
Fruits_4<-filter(Fruits,Expenses>90 | Sales>80)
Fruits_4
Fruits_5<-filter(Fruits,Expenses%in%c(79,91))
Fruits_5
Fruits
select(Fruits,Fruit,Year,Sales)
install.packages("googleVis")
Fruits
aggregate(Sales~Year,Fruits,sum)
aggregate(Sales~Fruit,Fruits,sum)
aggregate(Sales~Fruit,Fruits,max)
aggregate(Sales~Fruit+Year,Fruits,max)
mat1<-matrix(c(1,2,3,4,5,6),nrow=2,byrow=T)
mat1
apply(mat1,1,sum)
apply(mat1,2,sum)
apply(mat1[,c(2,3)],2,max)

list1<-list(Fruits$Sales)
list1
list2<-list(Fruits$Profit)
lapply(c(list1,list2),max)
sapply(c(list1,list2),max)
lapply(Fruits[,c(4,5)],max)
sapply(Fruits[,c(4,5)],max)
Fruits
tapply(Sales,Fruit,sum)
attach(Fruits)
tapply(Sales,Fruit,sum)
tapply(Sales,Year,sum)
vec1<-c(1,2,3,4,5)
vec2<-c(10,20,30,40,50)
vec3<-c(100,200,300,400,500)
mapply(sum,vec1,vec2,vec3)

data2<-read.csv("1-4호선승하차승객수.csv",header=T)
data2
tapply(data2[,c(3)],sum)
apply(data1[c(1:5),c(2:15)],1,sum)

apply(data2,2,sum)
a<-aggregate(승차~노선번호, data2,sum)
sapply(a)
aggregate(하차~노선번호, data2,sum)
sapply(data2[,c(3,4)],sum)
sapply(data2[c(3,4),],sum)

sapply(data2[,c(3,4)],sum)
sapply(data2[c(3,4),],sum)
list1<-list(data2$승차)
list1
list2<-list(data2$하차)
list2
lapply(c(list1,list2),sum)
lapply(c(list1,list2),max)
lapply(Fruits[,c(4,5)],max)
list3<-aggregate(승차~노선번호, data2,sum)
list4<-aggregate(하차~노선번호, data2,sum)
attach(data2)
aggregate(승차+하차~노선번호, data2,sum)
aggregate(승차~노선번호, data2,sum)

tapply(data2[,c(3,4)],sum)
sapply(data2[c(3,4),],sum)
tapply(승차,노선번호,sum)
tapply(하차,노선번호,sum)
sapply(list1<-list(data2$승차)
       list1
       list2<-list(data2$하차)
       list2
       lapply(c(list1,list2),sum)data2[,c(3,4)],sum)
list1<-list(data2$승차)
list1
list2<-list(data2$하차)
list2
sapply(c(list1,list2),sum)

tapply(하차,노선번호,sum)

data1<-read.csv("data1.csv",header=T)
data1
apply(data1[-1],2,sum)
apply(data1[-1],1,sum)
apply(data1[10:14],2,sum)
apply(data1[10:14],2,sum)
apply(data1[c(2:5),c(10:14)],1,sum)

data1<-read.csv("data1.csv",header=T)
data1
apply(data1[-1],2,sum)
apply(data1[-1],1,sum)
apply(data1[10:14],2,sum)
apply(data1[c(2:5),c(10:14)],1,sum)

apply(data1[10:14],2,sum)
apply(data1[c(2:5),c(10:14)],1,sum)
d1<-apply(data1[c(2,7,12)],2,sum)
d1
d2<-apply(data1[c(2:5),c(2,7,12)],1,sum)
d2

sapply(data1[,c(-1)],sum)
sapply(data1[,c(10:14)],sum)
d1<-sapply(data1[,c(2,7,12)],sum)
d1
data2<-read.csv("1-4호선승하차승객수.csv",header=T)
data2
tapply(승차,노선번호,sum)
tapply(하차,노선번호,sum)
list1<-list(data2$승차)
list1
list2<-list(data2$하차)
list2
sapply(c(list1,list2),sum)
data2<-read.csv("1-4호선승하차승객수.csv",header=T)
Data2
tapply(승차,노선번호,sum)
tapply(하차,노선번호,sum)
list1<-list(data2$승차)
list1
list2<-list(data2$하차)
list2
sapply(c(list1,list2),sum)

data2<-read.csv("1-4호선승하차승객수.csv",header=T)
data2
tapply(승차,노선번호,sum)
tapply(하차,노선번호,sum)
list1<-list(data2$승차)
list2<-list(data2$하차)
sapply(c(list1,list2),sum)
sapply(data2[3:4],sum)



aggregate(승차~노선번호, data2,sum)
aggregate(하차~노선번호, data2,sum)


aggregate((승차+하차)/2~노선번호, data2,mean)
attach(data2)
data2
tapply(하차,노선번호,min)

sapply(data2[3],max)
sapply(data2[4],min)
aggregate((승차+하차)/2~노선번호, data2,mean)

tapply(승차+하차,노선번호,min)
aggregate(승차+하차~노선번호, data2,sum)
aggregate(승차~노선번호, data2,sum)
aggregate(하차~노선번호, data2,sum)
aggregate(승차~노선번호, data2,mean)
aggregate(하차~노선번호, data2,min)
aggregate(승차+하차~노선번호, data2,max)

install.packages("googleVis")
attach(Fruits)
Fruits
aggregate(Sales~Fruit,Fruits,sum,na.rm=T)
aggregate((Sales:Profit)~Fruit,Fruits,sum)

apply(data1[10:14],2,sum)
apply(data1[,c(10:14)],1,sum)
list1<-list(Fruits$Sales)
list1
list2<-list(Fruits$Profit)
list2
sapply(c(list1,list2),sum)


Fruits_2<-filter(Fruits,Expenses>80)
Fruits_2
Fruits_3<-filter(Fruits,Expenses>90 &Sales>90)
Fruits_3
Fruits_4<-filter(Fruits,Expenses>90 | Sales>80)
Fruits_4
Fruits_5<-filter(Fruits,Expenses%in%c(79,91))
Fruits_5
Fruits
select(Fruits,Fruit,Year,Sales)


install.packages("reshape2")
fruits
melt(fruits,id='year')
melt(fruits,id=c('year','name'))
melt(fruits,id=c('year','name'),variable.name='var_name',value.name = 'val_name')

mtest<-melt(fruits,id=c('year','name'),variable.name='var_name',value.name = 'val_name')
mtest
dcast(mtest,year+name~var_name)
dcast(mtest,year~var_name)
dcast(mtest,name~var_name,sum)
dcast(mtest,name~var_name,sum,subset(name=='apple'))
install.packages("stringr")
fruits<-c('apple','Apple','banana','pineapple')
str_detect(fruits,'A')
str_detect(fruits,'^a')
str_detect(fruits,'e$')
str_detect(fruits,'^[aA]')
str_detect(fruits,'[aA]')

str_detect(fruits,ignore.case('a'))
fruits
str_count(fruits,ignore.case('a'))
str_count(fruits,'a')
str_c("apple","banana")
str_c(fruits,collapse = "")
str_c(fruits,collapse = "-")

str_dup(fruits,3)
str_length('apple')
str_length(fruits)
str_locate('apple','a')
str_replace('apple','p','*')
str_replace_all('apple','p','*')
fruits<-str_c('apple','/','orange','/','banana')
fruits
str_split(fruits,"/")
fruits
str_sub(fruits,start=1,end=3)
str_sub(fruits,start=6,end=9)

Fruits
sqldf('SELECT Fruit,SUM(Sales)
      FROM Fruits
      GROUP BY Fruit')

