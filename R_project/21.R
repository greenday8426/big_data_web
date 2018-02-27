
setwd("c:\\easy_r")
exam<-read.csv("csv_exam.csv")
exam
exam %>%filter(class==1)
exam %>%filter(class==2)
exam %>% filter(class!=1)
exam %>% filter(class!=3)
exam %>% filter(math>50)
exam %>% filter(math<50)
exam %>%filter(class==1 & math>=50)
exam %>%filter(class==1 & english>=80)
exam %>%filter(math>=90 | english>=90)
exam %>%filter(math<90 | english<50)
exam %>%filter(class==1|class==2|class==5)
exam %>%filter(class%in%c(1,3,5))
class1<-exam%>%filter(class==1)
class2<-exam %>% filter(class==2)
mean(class1$math)
mean(class2$math)

mpg
class1<-mpg%>%filter(displ<=4)
class2<-mpg %>% filter(displ>=5)
mean(class1$hwy)
mean(class2$hwy)

class1<-mpg%>%filter(manufacturer=="audi")
class2<-mpg%>%filter(manufacturer=="toyota")
mean(class1$cty)
mean(class2$cty)

class1<-mpg %>%filter(manufacturer%in%c("chevrolet","ford","honda"))
mean(class1$hwy)

mpg<-as.data.frame(ggplot2::mpg)
exam%>%select(math)
exam%>%select(english)
exam%>%select(class,math,english)
exam%>%select(-math)
exam%>%select(-math,-english)
exam%>%filter(class==1) %>% select(english)
exam %>% 
  filter(class==1)
  select(english)
exam%>%
  select(id,math) %>%
  head
exam%>%
  select(id,math) %>%
  head(10)

df<-mpg%>%
  select(class,cty) %>%
  head
df
mpg %>% 
  filter(class=="suv" |class=="compact")
select(english)

class1<-df%>%filter(class=="suv")
class2<-df%>%filter(class=="compact")
mean(class1$cty)
mean(class2$cty)

exam %>% arrange(math)
exam %>% arrange(desc(math))
exam %>% arrange(class,math)
mpg
mpg %>% filter(manufacturer=="audi")%>% 
  arrange(desc(hwy)) %>% 
  head(5)

exam
exam %>% 
  mutate(total=math+english+science)%>%
  head
exam %>% 
  mutate(total=math+english+science,
         mean=(math+english+science)/3)%>%
exam %>% 
mutate(test=ifelse(science>=60, "pass","fail"))%>%
head
exam %>% 
  mutate(total=math+english+science) %>% 
  arrange(total) %>% 
  head

mpg<-as.data.frame(ggplot2::mpg)
mpg_new<-mpg
mpg_new<-mpg_new%>%mutate(total=hwy+cty)
mpg_new<-mpg_new%>%mutate(mean=total/2)
mpg_new%>%arrange(desc(mean)) %>% 
  head(3)
mpg %>% 
  mutate(total=cty+hwy, mean=total/2) %>% 
  arrange(desc(mean)) %>% 
  head(3)

exam %>% 
  summarise(mean_math=mean(math))

exam %>% 
  group_by(class) %>% 
  summarise(mean_math=mean(math))
exam %>% 
  group_by(class) %>% 
  summarise(mean_math=mean(math),
            sum_math=sum(math),
            median_math=median(math),
            n=n())

exam %>% 
  group_by(manufacturer,drv) %>% 
  summarise(mean_math=mean(math),
            sum_math=sum(math),
            median_math=median(math),
            n=n())
mpg %>% 
  group_by(manufacturer,drv) %>% 
  summarise(mean_cty=mean(cty)) %>% 
  head(10)

mpg %>% 
  group_by(manufacturer) %>% 
  filter(class=="suv") %>% 
  mutate(tot=(cty+hwy)/2) %>% 
  summarise(mean_tot=mean(tot)) %>% 
  arrange(desc(mean_tot)) %>% 
  head(5)




midwest<-as.data.frame(ggplot2::midwest)
mpg
mpg %>% 
  group_by(class) %>% 
  summarise(mean_cty=mean(cty)) 
mpg %>% 
  group_by(class) %>% 
  summarise(mean_cty=mean(cty))%>% 
  arrange(desc(mean_cty))

mpg %>% 
  group_by(manufacturer) %>% 
  summarise(mean_hwy=mean(hwy))%>% 
  arrange(desc(mean_hwy)) %>% 
  head(3)

mpg %>% 
  group_by(manufacturer) %>% 
  filter(class=="compact") %>% 
  summarise(n=n())%>% 
  arrange(desc(n))
  
  arrange(desc(mean_hwy)) %>% 
  head(3)


test1<-data.frame(id=c(1,2,3,4,5),midterm=c(60,80,70,90,85))
test2<-data.frame(id=c(1,2,3,4,5),final=c(70,83,65,95,80))
total<-left_join(test1,test2,by="id")
total
name<-data.frame(class=c(1,2,3,4,5), teacher=c("kim","lee","park","choi","jung"))
name
exam_new<-left_join(exam,name,by="class")
exam_new

group_a<-data.frame(id=c(1,2,3,4,5),test=c(60,80,70,90,85))
group_b<-data.frame(id=c(6,7,8,9,10),test=c(70,83,65,95,80))
group_all<-bind_rows(group_a,group_b)
group_all

mpg
fuel<-data.frame(fl=c("c","d","e","p","r"),price_fl=c(2.35,2.38,2.11,2.76,2.22),stringsAsFactors = F)
fuel
mpg<-left_join(mpg,fuel,by="fl")
mpg

mpg%>%
  select(model,fl,price_fl) %>%
  head(5)

midwest<-as.data.frame(ggplot2::midwest)
midwest
midwest<-midwest %>% 
  mutate(poppercent=(poptotal-popadults)/poptotal*100) %>% 
  mutate(grade=ifelse(poppercent>=40,"large",
                      ifelse(poppercent>=30,"middle","small")))
table(midwest$grade)
midwest %>% 
  mutate(asianratio=(popasian/poptotal)*100) %>%
  arrange(asianratio) %>% 
  select(state,county,asianratio) %>% 
  head(10)
exam
exam %>% select(class,math,english)
exam %>% select(id,math) %>% 
  head
mpg   
mpg_new<-mpg %>% select(class,cty) %>% 
  head
mpg_new %>% filter(class=="suv"|class=="compact")

var1<-c(1,2,3,4,5)
plot(var1)
var2<-c(2,2,2)
plot(var2)
x<-matrix(c(40,52,33,51),2,2)
barplot(x, main="나를 중시하는 경향",names=c("가족도 중요하지만 \n 나를 먼저 생각한다","물건을 충동적으로\n 구매하는 경우가 많다"),col=c("pink","gray"),ylim=c(0,100))

x<-matrix(c(40,52,33,51),2,2)
barplot(x, horiz=T, main="나를 중시하는 경향",names=c("가족보다 \n 나를 먼저","충동구매\n 확률"),col=c("pink","gray"),xlim=c(0,100))

x<-matrix(c(40,52,33,51),2,2)
barplot(x, beside=T, main="나를 중시하는 경향",names=c("가족보다 \n 나를 먼저","충동구매\n 확률"),col=c("pink","gray"),xlim=c(0,60),horiz=T)

score<-c(65,90,98,88,78,60,59,72,82,84,86,92,77,72)
hist(score,main="histogram of score")

age<-c(28,35,40,32,36,39,41,38,33,30,27,34,35,43)
hist(age,main="histogram of age")

p1<-c(24,18,17,9,8)
f_day<-c("취직-24","친구/이성-18","학업성적-17","결혼-9","외모-8")
f_label<-paste(f_day,"%")
pie3D(p1,main="20대 최근 관심", col=rainbow(length(p1)),cex=0.5,labels=f_label,explode=0.05)
legend(0.5,1,c("취직","친구/이성","학업성적","결혼","외모"),cex=0.6,fill=rainbow(length(p1)))

p1<-c(24,18,17,9,8)
f_day<-c("24","18","17","9","8")
f_label<-paste(f_day,"%")
pie(p1,main="20대 최근 관심",radius=1,init.angle = 90,col=rainbow(length(p1)),label=f_label)
legend(1,1.5,c("취직","친구/이성","학업성적","결혼","외모"),cex=0.3,fill=rainbow(length(p1)))

v1<-c(37.4,50.3,63.6,67.2,81.1)
v2<-c(82.2,88.1,84.7,77.2,56.3)
boxplot(v1,v2,main="미디어 이용율",col=c("blue","yellow"),names=c("TV 이용률","스마트폰 이용율"),horizontal = T)

p1<-c(10,20,30,40,50)
f_day<-round(p1/sum(p1)*100,1)
f_label<-paste(f_day,"%")
pie3D(p1,main="3D Pie Chart", col=rainbow(length(p1)),cex=0.5,labels=f_label,explode=0.05)
legend(0.5,1,c("MON","TUE","WED","THU","FRI"),cex=0.6,fill=rainbow(length(p1)))


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
barplot(peach,main="나를 중시하는 경향",names.arg=c("MON","TUE","WED","THU","FRI"),col=colors)


