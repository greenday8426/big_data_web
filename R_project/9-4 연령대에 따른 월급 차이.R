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

#09-4.연령대에 따른 월급 차이-"어떤 연령대의 월급이 가장 많을까?"
#연령대 변수 검토 및 전처리 하기

#파생변수 만들기-연령대
welfare<-welfare %>% 
  mutate(ageg=ifelse(age<30,"young",
                     ifelse(age<=59,"middle","old")))
table(welfare$ageg)
#1.연령대별 월급 평균표 만들기
ageg_income<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(mean_income=mean(income))
ageg_income
#2.그래프 만들기
ggplot(data=ageg_income,aes(x=ageg,y=mean_income))+geom_col()
#막대 정렬:초년, 중년, 노년 나이 순
ggplot(data=ageg_income,aes(x=ageg,y=mean_income))+geom_col()+scale_x_discrete(limits=c("young","middle","old"))