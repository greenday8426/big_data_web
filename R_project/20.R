var1<-c(1,2,3,4,5)
plot(var1)
var2<-c(2,2,2)
plot(var2)
x<-1:3
y<-3:1
plot(x,y)
x<-1:3
y<-3:1
plot(x,y,xlim=c(1,10),ylim = c(1,5),
     xlab="x축 값",ylab="Y축 값",
     main="Plot Test")
plot.new()
dev.new()
v1<-c(100,130,120,160,150)
plot(v1,type='o',col='red',ylim=c(0,200),
     axes = FALSE,ann=FALSE)
axis(1,at=1:5,
lab=c("MON","TUE","WED","THU","FRI"))
axis(2,ylim=c(0,200))
title(main="FRUIT",col.main="red",font.main=4)
title(xlab="DAY",col.lab="black")
title(ylab="PRICE",col.lab="blue")

par(mfrow=c(nr,nc))
v1
par(mfrow=c(1,3))
plot(v1,type="o")
plot(v1,type="s")
plot(v1,type="l")
v1
par(mfrow=c(1,3))
pie(v1)
plot(v1,type="o")
barplot(v1)
a<-c(1,2,3)
plot(a,xlab="aaa")
par(mgp=c(0,1,0))
plot(a,xlab="aaa")
par(mgp=c(3,1,0))
plot(a,xlab="aaa")
par(oma=c(2,1,0,0))
plot(a,xlab="aaa")
par(oma=c(0,2,0,0))
plot(a,xlab="aaa")

par(mfrow=c(1,1))
v1<-c(1,2,3,4,5)
v2<-c(5,4,3,2,1)
v3<-c(3,4,5,6,7)
plot(v1,type="S",col="red",ylim=c(1,5))
par(new=T)
plot(v2,type="o",col="blue",ylim=c(1,5))
par(new=T)
plot(v3,type="l",col="green")

v1<-c(1,2,3,4,5)
v2<-c(5,4,3,2,1)
v3<-c(3,4,5,6,7)
plot(v1,type="S",col="red",ylim=c(1,10))
lines(v2,type="o",col="blue",ylim=c(1,5))
lines(v3,type="l",col="green",ylim=c(1,15))

v1<-c(1,2,3,4,5)
v2<-c(5,4,3,2,1)
v3<-c(3,4,5,6,7)
plot(v1,type="S",col="red",ylim=c(1,10))
lines(v2,type="o",col="blue",ylim=c(1,5))
lines(v3,type="l",col="green",ylim=c(1,15))
legend(4,9,c("v1","v2","v3"),cex=0.9,col=c("red","blue","green"),lty=1)

y<-c(3,4,5,6,7)
plot(y)
y<-c(2,2,2)
plot(y)
x<-c(10,20,30,40,50,60,70,80,90)
y<-10:2
plot(x,y)
x<-1:3
y<-3:1
plot(x,y,xlim=c(1,10),ylim = c(1,5),
     xlab="x축 값",ylab="Y축 값",
     main="Plot Test")
x<-c(2,4,6,8)
y<-c(16,17,19,18)
plot(x,y,xlim=c(0,10),ylim = c(15,20),
     xlab="x축 값",ylab="Y축 값",
     main="Plot Test")

par(mgp=c(2,1,0))
plot(a,xlab="aaa")
par(mgp=c(4,2,0))
plot(a,xlab="aaa")
par(mgp=c(4,2,1))
plot(a,xlab="aaa")

par(oma=c(4,0,0,0))
plot(a,xlab="aaa")
par(oma=c(0,4,0,0))
plot(a,xlab="aaa")
par(oma=c(0,0,4,0))
plot(a,xlab="aaa")
par(oma=c(0,0,0,4))
plot(a,xlab="aaa")

v1<-c(100,130,120,160,150)
plot(v1,type='o',col='red',ylim=c(0,200),
     axes = FALSE,ann=FALSE)
axis(1,at=1:5,
     lab=c("MON","TUE","WED","THU","FRI"))
axis(2,ylim=c(0,200))
title(main="FRUIT",col.main="red",font.main=4)
title(xlab="DAY",col.lab="black")
title(ylab="PRICE",col.lab="blue")

x<-c("A","B","C","D","F")
y<-c(5,7,7,6,1)
plot(x,y,type="l",col="red",ylim = c(0,8), xlab="학점(점)",ylab="학생수(명)",main="학점별 학생수")

v1<-c(100,130,120,160,150)
plot(v1,type='o',col='red',ylim=c(0,200),axes = FALSE,ann=FALSE)
axis(1,at=1:5,
     lab=c("MON","TUE","WED","THU","FRI"))
axis(2,ylim=c(0,200))
title(main="FRUIT",col.main="red",font.main=4)
title(xlab="DAY",col.lab="black")
title(ylab="PRICE",col.lab="blue")


barplot(x)

par(mfrow=c(1,1))
v1<-c(1,2,3,4,5)
v2<-c(5,4,3,2,1)
v3<-c(3,4,5,6,7)
plot(v1,type="S",col="red",ylim=c(1,5))
par(new=T)
plot(v2,type="o",col="blue",ylim=c(1,5))
par(new=T)
plot(v3,type="l",col="green")


x<-c(1,2,3,4,5)
barplot(x,horiz=T)

x<-matrix(c(5,4,3,2),2,2)
barplot(x,beside=T,names=c(5,3),col=c("green","yellow"))
x

x<-matrix(c(5,4,3,2),2,2)
barplot(x,names=c(5,3),col=c("green","yellow"))

x<-matrix(c(5,4,3,2),2,2)
par(oma(1,0.5,1,0.5))
barplot(x,names=c(5,3),beside=T,col=c("green","yellow"),horiz = T)

v1<-c(100,120,140,160,180)
v2<-c(120,130,150,140,170)
v3<-c(140,170,120,110,160)
qty<-data.frame(BANANA=v1,CHERRY=v2,ORANGE=v3)
qty
barplot(as.matrix(qty),main="Fruit's Sales QTY",beside=T,col=rainbow(nrow(qty)),ylim(0,400))
legend(14,400,c("MON","TUE","WED","THU","FRI"),cex=0.8,fill=rainbow(nrow(qty)))

barplot(t(qty),main="Fruit's Sales QTY",ylim(0,900),col=rainbow(length(qty)),space=0.1,cex.axis = 0.8,las=1,names.arg=c("MON","TUE","WED","THU","FRI"),cex=0.8)
legend(0.2,800,names(qty),cex=0.7,fill=rainbow(length(qty)))
plot.new()

peach<-c(180,200,250,198,170)
colors<-c()
for(i in 1:length(peach))
{if (peach[i]>=200)
    {colors<-c(colors,"red")}
 else if(peach[i]>=180)
     {colors<-c(colors,"yellow")}
 else
     {colors<-c(colors,"green")}
  
}
barplot(peach,main="Peach Sales QTY",names.arg=c("MON","TUE","WED","THU","FRI"),col=colors)

height<-c(182,175,167,172,163,178,181,166,159,155)
hist(height,main = "histogram of height")

par(mfrow=c(1,2),oma=c(2,2,0.1,0.1))
hist<-c(1,1,2,3,3,3)
hist(hist)
plot(hist,main="Plot")

par(mfrow=c(1,1),oma=c(0.5,0.5,0.1,0.1))
p1<-c(10,20,30,40)
pie(p1,radius=1)
pie(p1,radius=1,init.angle = 90)
pie(p1,radius=1,init.angle = 90,col=rainbow(length(p1)),label=c("Week1","Week2","Week3","Week4"))

pct<-round(p1/sum(p1)*100,1)
lab<-paste(pct,"%")
pie(p1,radius=1,init.angle = 90,col=rainbow(length(p1)),labels = lab)
legend(1,1.1,c("Week1","Week2","Week3","Week4"),cex=0.5,fill=rainbow(length(p1)))

pct<-round(p1/sum(p1)*100,1)
lab1<-c("Week1","Week2","Week3","Week4")
lab2<-paste(lab1,"\n",pct,"%")
pie(p1,radius=1,init.angle = 90,col=rainbow(length(p1)),labels = lab)
legend(1,1.1,c("Week1","Week2","Week3","Week4"),cex=0.5,fill=rainbow(length(p1)))

install.packages("plotrix")
p1<-c(10,20,30,40,50)
f_day<-round(p1/sum(p1)*100,1)
f_label<-paste(f_day,"%")
pie3D(p1,main="3D Pie Chart", col=rainbow(length(p1)),cex=0.5,labels=f_label,explode=0.05)
legend(0.5,1,c("MON","TUE","WED","THU","FRI"),cex=0.6,fill=rainbow(length(p1)))

v1<-c(10,12,15,11,20)
v2<-c(5,7,15,8,9)
v3<-c(11,20,15,18,13)
boxplot(v1,v2,v3,col=c("blue","yellow","pink"),names=c("Blue","Yellow","Pink"),horizontal = T)

df<-data.frame(sex=c("M","F",NA,"M","F"),score=c(5,4,3,4,NA))
df
is.na(df)
table(is.na(df))
table(is.na(df$sex))
table(is.na(df$score))
mean(df$score)
sum(df$score)
df_nomiss<-df %>% filter(!is.na(score))
mean(df_nomiss$score)
sum(df_nomiss$score)
df_nomiss<-df%>% filter(!is.na(score)&!is.na(sex))
df_nomiss

df_nomiss2<-na.omit(df)
df_nomiss2
mean(df$score,na.rm=T)
sum(df$score,na.rm=T)

exam<-read.csv("csv_exam.csv")
exam[c(3,8,15),"math"]<-NA
exam %>% summarise(mean_math=mean(math))
exam %>% summarise(mean_math=mean(math,na.rm=T))

exam %>% summarise(mean_math=mean(math,na.rm=T),sum_math=sum(math,na.rm=T),median_math=median(math,na.rm=T))
mean(exam$math,na.rm=T)
exam$math<-ifelse(is.na(exam$math),55,exam$math)
table(is.na(exam$math))
exam
exam
mean(exam$math)
mpg<-as.data.frame(ggplot2::mpg)
mpg[c(65,124,131,153,212),"hwy"]<-NA
is.na(mpg)
table(is.na(mpg$drv))
table(is.na(mpg$hwy))
mean(mpg$score)
sum(mpg$score)
mpg
mpg %>% 
  filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(mean_hwy=mean(hwy))
  
  
  summarise(mean_math=mean(math,na.rm=T))

mpg %>% summarise(mean_math=mean(math,na.rm=T),sum_math=sum(math,na.rm=T),median_math=median(math,na.rm=T))
mean(mpg$math,na.rm=T)

outlier<-data.frame(sex=c(1,2,1,3,2,1),score=c(5,4,3,4,2,6))

outlier
table(outlier$sex)
table(outlier$score)

outlier$sex<-ifelse(outlier$sex==3,NA,outlier$sex)
outlier
outlier$score<-ifelse(outlier$score>5,NA,outlier$score)
outlier
outlier %>% filter(!is.na(sex)&!is.na(score)) %>% 
  group_by(sex) %>% 
  summarise(mean_score=mean(score))

mpg<-as.data.frame(ggplot2::mpg)
boxplot(mpg$hwy)
boxplot(mpg$hwy)$stats

mpg$hwy<-ifelse(mpg$hwy<12|mpg$hwy>37,NA,mpg$hwy)
table(is.na(mpg$hwy))

mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy=mean(hwy,na.rm=T))

mpg
mpg[c(10,14,58,93),"drv"]<-"k"
mpg[c(29,43,129,203),"cty"]<-c(3,4,39,42)
table(mpg$drv)
mpg$drv<-ifelse(mpg$drv %in% c("4","f","r"),mpg$drv,NA)
table(mpg$drv)

boxplot(mpg$cty)$stats

mpg$cty<-ifelse(mpg$cty<9|mpg$cty>26, NA,mpg$cty)
boxplot(mpg$cty)






v1<-c(5,7,7,6,1)
plot(v1,type='o',col='red',ylim=c(0,8),axes = FALSE,ann=FALSE)
axis(1,at=1:5,
     lab=c("A","B","C","D","F")))
axis(2,ylim=c(0,200))
title(main="FRUIT",col.main="red",font.main=4)
title(xlab="DAY",col.lab="black")
title(ylab="PRICE",col.lab="blue")

mpg<-as.data.frame(ggplot2::mpg)
boxplot(mpg$hwy)