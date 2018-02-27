df1<-data.frame(name=c('apple','banana','cherry'), price=c(300,200,100))
df2<-data.frame(name=c('apple','cherry','bherry'), qty=c(10,20,30))
df1
df2
merge(df1,df2)
merge(df1,df2,all=T)
cbind(df1,df2)
cbind(df2,df1)
df1
new<-data.frame(name="mange",price=400)
df1<-rbind(df1,new)
df1
df1<-rbind(df1,data.frame(name="berry",price=500))
df1
df1<-cbind(df1,data.frame(qty=c(10,20,30,40,50)))
df1
no<-c(1,2,3,4,5)
name<-c("서진수","주시현","최경우","이동근","윤정웅")
address<-c("서울","대전","포항","경주","경기")
tel<-c(1111,2222,3333,4444,5555)
hobby<-c("독서","미술","놀고먹기","먹고놀기","노는애감시하기")
member<-data.frame(NO=no, NAME=name, ADDRESS=address, TEL=tel,HOBBY=hobby)
member

member2<-subset(member,select=c(NO,NAME,TEL))
member2
member3<-subset(member,select=-TEL)
member3
colnames(member3)<-c("번호","이름","주소","취미")
member3
no<-c(1,2,3,4)
name<-c('Apple','Peach','Banana','Grape')
price<-c(500,200,100,50)
qty<-c(5,2,4,7)
sales<-data.frame(NO=no, NAME=name,PRICE=price,QTY=qty)
sales
df1<-data.frame(name=c('사과','딸기','수박'), price=c(1800,1500,3000), qty=c(24,38,13))
df1<-data.frame(제품=name, 가격=price,판매량=qty)
df1