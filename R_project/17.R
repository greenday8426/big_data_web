setwd("c:\\easy_r")
library(ggplot2)
library(ggmap)
loc<-read.csv("서울시공영주차장정보.csv",header=T)
center<-c(mean(loc$LON),mean(loc$LAT))
kor<-get_map(center,zoom=11,maptype="roadmap")

kor.map<-ggmap(kor)+geom_point(data=loc,aes(x=LON,y=LAT),size=3,alpha=0.7)
kor.map+geom_text(data=loc,aes(x=LON,y=LAT+0.005,label=주차장명),size=3)
ggsave("c:\\easy_r/car.png",dpi=500)