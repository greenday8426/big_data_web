#파일 경로 easy_r 로 잡아주기
setwd("c:\\easy_r")

#데이터 불러오기
raw_welfare<-read.spss(file="Koweps_hpc10_2015_beta1.sav",to.data.frame = T)
welfare<-raw_welfare
#데이터 검토하기
head(welfare)
tail(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)
#변수명 바꾸기
welfare<-rename(welfare,     
                sex=h10_g3,        #성별
                birth=h10_g4,      #태어난 연도
                marriage=h10_g10,  #혼인상태
                religion=h10_g11,  #종교
                income=p1002_8aq1,  #월급
                code_job=h10_eco9,  #직종 코드
                code_region=h10_reg7)  #지역코드

#09-3.나이와 월급의 관계-"몇 살 때 월급을 가장 많이 받을까?"-분석절차
#1.변수 검토하기
class(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth)
#2.전처리
#이상치 확인
summary(welfare$birth)
table(is.na(welfare$birth))
#이상치 결측 처리
welfare$birth<-ifelse(welfare$birth==9999,NA,welfare$birth)
table(is.na(welfare$birth))
#3.파생변수 만들기-나이
welfare$age<-2018-welfare$birth+1
summary(welfare$age)
qplot(welfare$age)

#나이와 월급의 관계 분석하기-1.나이에 따른 월급 평균표 만들기
age_income<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income=mean(income))
head(age_income)
#2.그래프 만들기
ggplot(data=age_income,aes(x=age,y=mean_income))+geom_line()