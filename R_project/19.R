exam<-read.csv("csv_exam.csv")
exam
head(exam)
head(exam,10)
tail(exam)
tail(exam,10)
View(exam)
dim(exam)
str(exam)
summary(exam)
install.packages("ggplot2")
midwest<-as.data.frame(ggplot2::midwest)
head(midwest)
tail(midwest)
View(midwest)
dim(midwest)
str(midwest)
summary(midwest)
install.packages("dplyr")
df_raw<-data.frame(var1=c(1,2,1),var2=c(2,3,2))
df_raw
df_new<-df_raw
df_new
df_new<-rename(df_new,v2=var2)
df_new
df_raw
df_new

install.packages("ggplot2")
midwest<-as.data.frame(ggplot2::midwest)
midwest
df_new<-midwest
df_new
df_new<-rename(df_new,city=cty)
df_new<-rename(df_new,highway=hwy)
df_new
df_raw
df_new
df<-data.frame(var1=c(4,3,8),var2=c(2,6,1))
df
df$var_sum<-df$var1+df$var2
df
df$var_mean<-(df$var1+df$var2)/2
df
midwest$total<-(midwest$cty+midwest$hwy)/2
head(midwest)
mean(midwest$total)
summary(midwest$total)
hist(midwest$total)

ifelse(midwest$total>=20,"pass","fail")
midwest$test<-ifelse(midwest$total>=20,"pass","fail")
head(midwest,20)
table(midwest$test)
qplot(midwest$test)

midwest$grade2<-ifelse(midwest$total>=30,"A", 
                  ifelse(midwest$total>=25,"B",
                         ifelse(midwest$total>=20,"C","D")))
head(midwest,20)
table(midwest$grade2)


midwest<-as.data.frame(ggplot2::midwest)
head(midwest)
tail(midwest)
View(midwest)
dim(midwest)
str(midwest)

df_new<-midwest
df_new
df_new<-rename(df_new,total=poptotal)
df_new<-rename(df_new,asian=popasian)
df_new

df_new$hundred<-((df_new$asian/df_new$total)*100)
hist(df_new$hundred)

mean(df_new$hundred)
library(ggplot2)
df_new$group<-ifelse(df_new$hundred>0.4872462,"large","small")

table(df_new$group)
qplot(df_new$group)

setwd("c:\\r_easy")
data1<-read.csv("2013년_프로야구선수_성적.csv")
data1