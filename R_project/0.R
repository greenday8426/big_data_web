df1<-data.frame(name=c('사과','딸기','수박'), price=c(1800,1500,3000), qty=c(24,38,13))
df1<-data.frame(제품=name, 가격=price,판매량=qty)
df1
mean(df1$qty)
df1<-data.frame(no=c(1,2,3), name=c('apple','banana','peach'), price=c(100,200,300))
df1<-data.frame(NO=no, NAME=name,PRICE=price)
df1
df2<-data.frame(no=c(10,20,30), name=c('train','car','airplane'), price=c(1000,2000,3000))
df2<-data.frame(NO=no, NAME=name,PRICE=price)
df2
f<-data.frame(name=c('김길동','강길동','박길동'), kor=c(100,90,85), mat=c(90,95,98),eng=c(80,98,100))
s<-data.frame(name=name, kor=kor,mat=mat, eng=eng)
s
names(s)
nrow(S)
s[,c(1,2)]
s[,c(1,3)]
s[,c(1)]
s[c(1,2),]
s[c(3),]
s<-rbind(s,data.frame(name="최길동",kor=80, mat=90, eng=93))
s
f<-data.frame(name=c('강길동','박길동','최길동'), kor=c(100,90,92), mat=c(90,95,100))
f<-data.frame(name=name, kor=kor,mat=mat)
f
f<-cbind(f,data.frame(sci=c(80,90,93)))
f
ncol(f)
f[c(-2),]
f[,c(-1)]
f[c(1,4,2,3)]
t<-data.frame(name=c('강길동','박길동','최길동'), kor=c(100,90,92), mat=c(90,95,100))
t<-data.frame(name=name, kor=kor,mat=mat)
t
t<-cbind(t,data.frame(sci=c(80,90,93)))
t
ncol(t)
t[c(-2),]
t[,c(-1)]
t[c(1,4,2,3)]
s<-data.frame(name=c('김길동','강길동','박길동'), kor=c(100,90,85), mat=c(90,95,98),eng=c(80,98,100))
s<-data.frame(name=name, kor=kor,mat=mat, eng=eng)
s
names(s)
nrow(S)
s[,c(1,2)]
s[,c(1,3)]
s[,c(1)]
s[c(1,2),]
s[c(3),]
s<-rbind(s,data.frame(name="최길동",kor=80, mat=90, eng=93)
merge(s,t)
merge(s,t,all=T)
cbind(s,t)
cbind(t,s)
tt<-t[,c(1,2,3)]
tt
ss<-s[,c(1,2,3)]
ss
rbind(tt,ss)
rbind(ss,tt)