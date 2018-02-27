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

#09-9.지역별 연령대 비율-"노년층이 많은 지역은 어디일까?"
#지역 변수 검토 및 전처리하기
#변수 검토하기
class(welfare$code_region)
table(welfare$code_region)

#전처리
# 지역 코드 목록 만들기
list_region <- data.frame(code_region = c(1:7),
                          region = c("서울",
                                     "수도권(인천/경기)",
                                     "부산/경남/울산",
                                     "대구/경북",
                                     "대전/충남",
                                     "강원/충북",
                                     "광주/전남/전북/제주도"))
list_region

# welfare에 지역명 변수 추가 
welfare <- left_join(welfare, list_region, id = "code_region")

welfare %>%
  select(code_region, region) %>%
  head

#3.파생변수 만들기-나이
welfare$age<-2018-welfare$birth+1
#파생변수 만들기-연령대
welfare<-welfare %>% 
  mutate(ageg=ifelse(age<30,"young",
                     ifelse(age<=59,"middle","old")))
table(welfare$ageg)
#1.지역별 연령대 비율표 만들기
region_ageg <- welfare %>%
  group_by(region, ageg) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n / tot_group * 100, 2))

head(region_ageg)

#count() 함수 이용
region_ageg <- welfare %>%
  count(region, ageg) %>%
  group_by(region) %>%
  mutate(pct = round(n / sum(n) * 100, 2))
#2.그래프 만들기
ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() +
  coord_flip()

#3.노년층 비율 높은 순으로 막대 정렬하기
#노년층 비율 내림차순 정렬
list_order_old <- region_ageg %>%
  filter(ageg == "old") %>%
  arrange(pct)

list_order_old

# 지역명 순서 변수 만들기
order <- list_order_old$region
order
#order 변수 활용하여 그래프 그리기
ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits = order)

#4.연령대 순으로 막대 색깔 나열하기
class(region_ageg$ageg)
levels(region_ageg$ageg)
