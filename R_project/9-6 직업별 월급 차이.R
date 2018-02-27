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

#09-6.직업별 월급 차이-"어떤 직업이 월급을 가장 많이 받을까?"
#1.변수 검토하기
class(welfare$code_job)
table(welfare$code_job)
#2.전처리
#직업분류코드 목록 불러오기
library(readxl)
setwd("c:\\easy_r")
list_job<-read_excel("Koweps_Codebook.xlsx",col_names = T,sheet=2)
head(list_job)

#welfare에 직업명 결합
welfare<-left_join(welfare,list_job,id="code_job")
##Joining, by="code_job"
welfare %>% 
  filter(!is.na(code_job)) %>% 
  select(code_job,job) %>% 
  head(10)

#직업별 월급 차이 분석하기
#1.직업별 월급 평균표 만들기
job_income<-welfare %>% 
  filter(!is.na(job)&!is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income=mean(income))
head(job_income)
#2.상위 10개 추출
top10<-job_income %>% 
  arrange(desc(mean_income)) %>% 
  head(10)
top10
#3.그래프 만들기
ggplot(data=top10,aes(x=reorder(job,mean_income),y=mean_income))+geom_col()+coord_flip()
#4.하위 10위 추출
bottom10<-job_income %>% 
  arrange(mean_income) %>% 
  head(10)
bottom10
#5.그래프 만들기
ggplot(data=bottom10,aes(x=reorder(job,-mean_income),y=mean_income))+geom_col()+coord_flip()+ylim(0,850)

