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

#09-5.연령대 및 성별 월급 차이-"성별 월급 차이는 연령대별로 다를까?"
#연령대 및 성별 월급 차이 분석하기

#1.연령대 및 성별 월급 평균표 만들기
sex_income<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg,sex) %>% 
  summarise(mean_income=mean(income))
sex_income

#2.그래프 만들기
ggplot(data=sex_income,aes(x=ageg,y=mean_income,fill=sex))+geom_col()+scale_x_discrete(limits=c("young","middle","old"))
#성별 막대 분리
ggplot(data=sex_income,aes(x=ageg,y=mean_income,fill=sex))+geom_col(position = "dodge")+scale_x_discrete(limits=c("young","middle","old"))

#나이 및 성별 월급 차이 분석하기
#성별 연령별 월급 평균표 만들기
sex_age<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age,sex) %>% 
  summarise(mean_income=mean(income))
head(sex_age)
#2.그래프 만들기
ggplot(data=sex_age, aes(x=age, y=mean_income, col=sex))+geom_line()