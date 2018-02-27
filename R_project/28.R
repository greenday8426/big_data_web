#<뉴스 데이터의 활용>
#여기서부터는 JSON 파일 형태로 저장된 뉴스 자료를 이용하여 탑승객 수의 패턴 변화가 해당 시간 및 지역에서 발생한 이벤트와 연관이 있는지 살펴본다.

#이상점을 판단하기 위해 회귀분석을 이용한다.

#<회귀분석>
#회귀분석은 반응 변수를 다수의 설명 변수의 값에 의해 예측하는 모형을 제공한다.
#이번 포스팅에서 탑승객 수를 지하철역, 지하철 노선, 달, 요일의 요인에 의해 예측하는 모형을 적합한다. 탑승객 수를 예측하기 위한 모형으로 회귀분석은 그리 정교하다고 보긴 어렵다.
#하지만, 전반적인 패턴은 단순한 회귀분석을 통해 도출 가능하며 예측 모형으로 널리 쓰이기에 한번 다뤄보기로 한다.

#아래의 코드는 회귀 분석을 수행하기 위한 자료 정리 과정 및 회귀분석 수행 과정을 보여준다.
#탑승객 수가 월 효과, 요일 효과, 노선별 효과가 있다고 가정하고 있으며, 각 역의 특수성을 고려하여 회귀분석을 수행한다.

dat4_1 <- subset(subway2, subset= year=="2013", select=c("stat_name", "income
_date", "on_tot"))
dat4_2 <- subset(subname, subset = STATION_NM %in% unique(dat4_1[,"stat_name
"]), select=c(STATION_NM, LINE_NUM, XPOINT_WGS, YPOINT_WGS))
dat4 <- merge(dat4_1, dat4_2, by.x="stat_name", by.y="STATION_NM")
month <- format(dat4[,"income_date"], "%m")
day <- format(dat4[,"income_date"], "%a")
dat4 <- cbind(dat4, month, day)
head(dat4)

lm.res <- lm(on_tot ~ as.factor(stat_name) + as.factor(LINE_NUM) + month + day, data=dat4)


#회귀분석 수행을 위한 자료 정리 과정이다.
#- subset( ) 함수를 통해 2013년도 자료 및 사용 변수들을 subway2 및 subname2의 데이터 프레임
으로부터 추려낸다.
#- merge( ) 함수를 이용하여 두 데이터 프레임을 역 이름을 기준으로 병합하고 dat4 이름의 데이터 프레임으로 저장하여 이를 회귀분석에 활용한다.

#lm( ) 함수를 이용하여 회귀분석 수행
#- 반응 변수를 on_tot(탑승객 수)로 설정
#- 설명 변수로 stat_name(역이름), LINE_NUM(노선), month(월), day(요일)로 설정

#<잔차분석을 통한 이상점 탐지>
#회귀분석의 잔차(residual)는 모형에서 벗어난 이상점을 탐지하는데 사용될 수 있다.
#이를 위해 스튜던트 잔차(studentized residual)을 계산하여 극단값을 갖는 역 및 해당 날짜를 찾는 과정은 아래와 같다.

stdres <- rstandard(lm.res)
boxplot(stdres, outline=TRUE)

idx <- order(abs(stdres), decreasing=TRUE)[1:2] 
dat4[idx,]


row_index_out <- rownames(dat4[idx,])

#★ 회귀분석 결과가 저장된 lm.res 리스트 객체에서 스튜던트 잔차(studentized residuals)를 계산하여 stdres에 저장한다.
- 이에 대한 상자 그림을 통해 2개의 관측치가 매우 큰 잔차를 가짐을 확인할 수 있다.

#★ 높은 스튜던트 잔차를 갖는 2개의 이상점에 대한 정보를 idx에 저장한다.
#- 2개 모두 월드컵 경기장 역에서 관측되었으며 해당 일자는 2013년 10월 12일 및 26일 임을 확인

#위의 과정을 통해 탐지된 2개의 이상점이 모두 월드컵 경기장 역으로 나타났으므로, 해당 역의 탑승객 수의 시계열 그래프 상에서 해당 날짜의 탑승객 수가 얼마나 상이한지 시각적으로 살펴보는 과정은 아래와 같다.

dat_worldcup <- subset(dat4, subset= stat_name == "월드컵경기장") 
dat_worldcup <- dat_worldcup[order(dat_worldcup$income_date),] 
dat_out <- subset(dat_worldcup, subset=rownames(dat_worldcup) %in% row_index_out) 
plot(on_tot ~ income_date, data=dat_worldcup, type="l", ylab="탑승객수", xlab="") 
points(on_tot ~ income_date, data=dat_out, col="red", pch=19) 
text(x=dat_out$income_date, y=dat_out$on_tot, labels=dat_out$income_date, adj=c(1.1, 1.1), cex=0.8)

#★ 2013년도 "상암월드컵" 역의 탑승객 자료만 추출하여 이를 시간순으로 선 그래프를 이용하여 시각화
#- 전체 패턴에 비해 해당 일자에 대한 탑승객의 수가 비정상적으로 급증했음을 알 수 있다.

#<뉴스 자료의 로딩 및 뉴스검색>
#위에서 탐지한 2개의 이상점은 2013년 10월 12일, 2013년 10월 26일 모두 월드컵 경기장 역에서 관측되었다.
#뉴스 파일을 통해 해당 일자에 상암 월드컵 경기장에 특정 이벤트가 있는지 살펴본다.
#이를 위해 JSON 파일 형태로 저장된 뉴스 파일을 R을 통해 읽고 이를 활용해 뉴스검색을 한다.

#2013년도 뉴스 파일은 news_2013.json 이름으로 저장되어 있을 것이다.
#이를 R에서 불러들이기 위해 jsonlite 패키지의 fromJSON( ) 함수를 이용한다.

#파일의 용량이 13GB로 대용량이므로 이를 한 번에 읽을 경우 시스템 사양에 따라 오류가 발생하거나 가능한 경우에도 속도가 매우 느리므로 이를 부분적으로 읽어 특정 키워드가 있는 뉴스만 선별하여 저장하도록 한다.


library(jsonlite) 
filestream <- file("c:/t_temp/news_2013.json", open="r") 
batches <- list(); 
i <- 1; iter <- 0 
while(length(records <- readLines(filestream, n = 10000, encoding="UTF-8"))){ 
  iter <- iter + 1 
  message("Batch ", iter, ": found ", length(records), " lines of json...") 
  idx <- grep("상암월드컵|20131012|20131026", records) 
  if( length(idx)==0 ) next 
  json <- paste0("[", paste0(substring(records[idx], 2), collapse=","), "]") 
  batches[[i]] <- fromJSON(json, validate=TRUE) 
  i <- i+1 
} 
close(filestream) 
res <- rbind.pages(batches) 
write.table(res, file="Data/news_res.txt")


#★ 뉴스 데이터가 저장된 news_2013.json 파일은 13GB의 대용량 자료로써 R에서 한꺼번에 로딩하는 경우 메모리 부족 문제가 발생할 가능성이 매우 높다.
#- 이를 해결하기 위해 readLines( ) 함수를 이용하여 라인별로 읽어들이는 방법을 취한다.
#- n=10000 은 파일을 1만 줄씩 읽게 하는 것
#- grep("상암월드컵|20131012|20131026", records) 함수를 이용하여, 읽어들인 텍스트(records)로부터 "상암월드컵", "20131012", "20131026"의 문자열이 있는지 확인한 후, 텍스트 라인에 이들 키워드가 있으며 이를 batches 이름의 리스트에 저장하고 없으면 저장하지 않는다.

#★ JSON 파일은 대괄호([ , ])로 모든 내용이 묶여 있으며, 각각의 뉴스 파일은 content, date, title의 3개 키(key)로 구성되어 중괄호 ({ ,})로 묶여 있다.
#- 이는 파이썬의 dict 객체가 list로 묶여 있는 것과 동일한 형식이다.
#- 10000줄씩 읽어들이는 테스트를 JSON 파일 형식으로 변환하는 과정이 while 문 내에 구현된다.
#☆ jsonlite 패키지에서 제공하는 fromJSON( ) 함수를 이용하여 JSON 형식의 파일을 R로 읽음

#★ 위의 과정은 시스템에 따라 수분 이상이 걸리므로(현실은 10분 이상) 키워드를 통해 스크리닝 한 결과를 news_res.txt 파일로 저장하여 이후 분석하고 이를 불러들여 사용한다.

#검색을 위해 저장된 파일을 R로 불러들인다. 데이터 프레임 res에 내용이 저장

res <- read.table("c:\\easy_r/news_res.txt", stringsAsFactors = FALSE, fileEncoding="UTF-8")


#날짜(date)가 20131012이고 뉴스 내용(cintent)에 상암 월드컵 문자열이 있는 뉴스를 검색하여 이를 출력한다.
#뉴스 검색 결과, 브라질과 축구 국가대표팀의 평가전이 당일 오후 8시 상암 월드컵 경기장에서 있었음을 알 수 있다.

srch1 <- which(res[,3]=="20131012") 
srch1_2 <- grep("상암월드컵", res[srch1,1]) 
cat(paste0(res[srch1[srch1_2],1], collapse = "\n\n===============================\n\n"))


#★ 뉴스 생성 날짜가 2013년 10월 26일인 자료를 추출하고, 해당 뉴스 중에서 내용에 "상암월드컵"이라는 단어가 있는 뉴스를 검색하여 모두 출력한다.

#★ past0( ) 함수를 통해 검색된 뉴스 내용을 모두 병합하되 collapse를 이용하여 구분선을 사이에 두어 cat( )으로 출력시 가독성을 높일 수 있다.

#★ 뉴스검색 결과, 브라질과의 축구 국가대표팀의 평가전이 당일 오후 8시 상암 월드컵 경기장에서 있었음을 확인할 수 있다.

#날짜(date)가 20131012이고 뉴스 내용(content)에 상암 월드컵 문자열이 있는 뉴스를 검색하여 이를 출력한다.

#뉴스검색 결과, 당일 상담 월드컵 경기장에서 FC 서울과 중국 광저우 에버그란데 간의 아시아축구연맹(AFC) 챔피언스 리그 결승 1차전이 열렸음을 알 수 있다.

srch2 <- which(res[,3]=="20131026") 
srch2_2 <- grep("상암월드컵", res[srch2,1]) 
cat(paste0(res[srch2[srch2_2],1], collapse = "\n\n===============================\n\n"))
#★ 뉴스 생성 날짜가 2013년 10월 26일인 자료를 추출하고, 해당 뉴스 중에서 내용에 "상암월드컵"이라는 단어가 있는 뉴스를 검색하여 모두 출력한다.

#★ past0() 함수를 통해 검색된 뉴스 내용을 모두 병합하되 collapse를 이용하여 구분선을 사이에 두어 cat( )으로 출력, 가독성을 높인다.

#★ 뉴스검색 결과가, 당일 상암 월드컵 경기장에서 FC 서울과 중국 광저우 에버그란데 간의 아시아축구 연맹(AFC) 챔피언스 리그 결승 1차전이 열렸음을 알 수 있다.



           
           
           
           




