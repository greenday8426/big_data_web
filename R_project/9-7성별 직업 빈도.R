#파일 경로 easy_r 로 잡아주기
setwd("c:\\easy_r")

#데이터 불러오기
raw_welfare<-read.spss(file="Koweps_hpc10_2015_beta1.sav",to.data.frame = T)
welfare<-raw_welfare
#데이터 검토하기
#head(welfare)
#tail(welfare)
#View(welfare)
#dim(welfare)
#str(welfare)
#summary(welfare)
#변수명 바꾸기
welfare<-rename(welfare,     
                sex=h10_g3,        #성별
                birth=h10_g4,      #태어난 연도
                marriage=h10_g10,  #혼인상태
                religion=h10_g11,  #종교
                income=p1002_8aq1,  #월급
                code_job=h10_eco9,  #직종 코드
                code_region=h10_reg7)  #지역코드



#09-7.성별 직업 빈도-"성별로 어떤 직업이 가장 많을까?"
#이상치 결측 처리
welfare$sex<-ifelse(welfare$sex==9,NA,welfare$sex)
#결측치 확인
table(is.na(welfare$sex))
#성별 항목 이름 부여
welfare$sex<-ifelse(welfare$sex==1,"male","female")
table(welfare$sex)

#월급 변수 검토 및 전처리
#1.변수 검토하기
class(welfare$income)
summary(welfare$income)
qplot(welfare$income)
qplot(welfare$income)+xlim(0,1000)
#2.전처리
summary(welfare$income)
welfare$income<-ifelse(welfare$income %in% c(0,9999),NA,welfare$income)
table(is.na(welfare$income))
welfare$job<-ifelse(welfare$job==9999,NA,welfare$job)
table(is.na(welfare$job))
#직업분류코드 목록 불러오기
library(readxl)
list_job <- read_excel("Koweps_Codebook.xlsx", col_names = T, sheet = 2)
head(list_job)
dim(list_job)

class(welfare$code_job)
table(welfare$code_job)


welfare <- left_join(welfare, list_job, id = "code_job")

welfare %>%
  filter(!is.na(code_job)) %>%
  select(code_job, job) %>%
  head(10)
job_income <- welfare %>%
  filter(!is.na(job) & !is.na(income)) %>%
  group_by(job) %>%
  summarise(mean_income = mean(income))

head(job_income)
#성별 직업 빈도 분석하기
#1.성별 직업 빈도표 만들기
#남성 직업 빈도 상위 10개 추출
job_male <- welfare %>%
  filter(!is.na(job) & sex == "male") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)

job_male
#여성 직업 빈도 상위 10개 추출
job_female <- welfare %>%
  filter(!is.na(job) & sex == "female") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)

job_female
#2.그래프 만들기
#남성 직업 빈도 상위 10개 직업
ggplot(data = job_male, aes(x = reorder(job, n), y = n)) +
  geom_col() +
  coord_flip()

#여성 직업 빈도 상위 10개 직업
ggplot(data = job_female, aes(x = reorder(job, n), y = n)) +
  geom_col() +
  coord_flip()

