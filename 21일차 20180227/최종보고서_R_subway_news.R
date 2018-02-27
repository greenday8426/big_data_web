install.packages("jsonlite")
libs<-c("ggplot2","ggmap","jsonlite")
#install.packages(libs)
install.packages(libs)
unlist(lapply(libs,require,character.only=TRUE))
#Loading required package:gglot2
#Loading required package:ggmap
#Loading required package:jsonlite
subway<-read.csv('c:\\easy_r/subway.csv', header=TRUE, stringsAsFactors=FALSE, fileEncoding="UTF-8")
str(subway)
#정수형 income_date 변수를 표준서식으로 변환
class(subway[ , "income_date"])<-"character"
subway[ , "income_date"]<-as.Date(subway[ , "income_date"],format="%Y%m%d")
unique(format(subway[ , "income_date"], "%Y"))

#2014년 자료 제외

idx<-format(subway[ ,"income_date"], "%Y")=="2014"
unique(format(subway[idx,"income_date"],"%m"))

subway2 <- subset(subway, subset = format(income_date, "%Y") != "2014")

#실제 사용 역 이름과 동일한지 확인
sort(unique(subway[ , 'stat_name']))
#역명과 노선번호 분리 후 역명 대체
idx <- grep( "\\(" , subway2[ , "stat_name"] ) 
unique(subway2[idx, "stat_name"])

stat_name <- subway2[ , "stat_name"] 
tmp <- sapply(subway2[idx, "stat_name"], strsplit, "\\(", USE.NAMES=FALSE) 
stat_renamed <- sapply(tmp, function(x) x[1]) 
subway2[idx, "stat_name"] <- stat_renamed

#각 자료의 연도, 월 정보를 새로운 변수로 정의하여 데이터프레임의 변수로 포함시키기 위해서 아래의 명령어를 수행한다.
year <- format(subway2[,"income_date"], "%Y") 
month <- format(subway2[,"income_date"], "%m") 
subway2 <- cbind(subway2, year, month) 

#자료의 해당 연도 및 월을 각각 year와 month 변수로 저장하고 이를 데이터프레임 subway2에 새로운 변수로 추가

#<subway_latlong.csv 파일 로딩 및 자료 정리>
#아래 코드를 이용하여 subway_latlong.csv 파일을 읽는다.
subname <- read.csv('c:\\easy_r/subway_latlong.csv', header=TRUE, stringsAsFactors=FALSE, skip=1, fileEncoding="UTF-8") 
str(subname)
#read.csv( ) 함수를 이용하여 csv 파일을 읽어 sybname 이름의 데이터 프레임으로 저장
#nsikp = 1은 파일의 첫 행을 읽지 않고 넘김. subway_latlong.csv 파일의 첫 행은 한글 변수명, 둘째 행은 영문 변수명으로 기록되어 중복을 방지

#subway.csv 파일로부터의 역명과 동일한 형식으로 주어지는지 확인을 위해 아래와 같이 역명을 출력하여 살펴본다.
head(sort(unique(subname[ , "STATION_NM"])), 10)

#head( )는 긴 내용의 객체를 처음 6개(옵션 조정을 통해 개수 변경 가능)만 출력하는 함수
#아래 코드를 통해 지하철 노선별 역명을 Line 이름의 리스트 객체에 저장하여 추후 분석을 활용한다.
Line <- tapply(subname[,"STATION_NM"], subname[,"LINE_NUM"], unique) 
sapply(Line, head)

#tapply(X, INDEX, FUN)은 벡터 X를 factor인 INDEX의 각 수준별로 함수 FUN을 일괄 적용하는 함수
#head( ) 함수를 리스트 객체 Line의 각 지하철 노선에 적용하여 노선별 포함된 역이름의 일부분을 출력


#<연도별, 역별 지하철 탑승객 수의 계산>
#여기서는 각 지하철역 및 연도별 탑승객 수를 합산하여 역간의 탑승객 수의 차이 및 연도별 탑승객 수 증감 추이를 살펴본다. 데이터 프레임의 특정 변수의 수준별 자료 요약에 이용되는 aggregate( ) 함수의 활용을 학습한다.
#아래의 코드는 역별 특정 연도의 탑승객 수를 합산하는 함수 agg_fun( )을 정의하고, 이를 활용하여 요약된 결과를 데이터 프레임에 저장하는 과정이다.
agg_fun <- function(vec, dat){ 
  sub_Line <- dat[dat[,"stat_name"] %in% vec, ] 
  tot <- aggregate(on_tot ~ year + stat_name, sub_Line, sum) 
  return( tot ) 
} 

total <- lapply(Line[1:8], FUN=agg_fun, dat=subway2) 
df1 <- lapply(total, xtabs, formula = on_tot ~ stat_name + year) 
lapply(df1, head)
#각 역마다 특정 연도의 탑승객 수를 전체 합산하는 함수 agg_fun( )를 정의
#- x %in% y는 x의 원소 중에서 y의 원소에 속하면 TRUE 아니면 FALSE의 논리값을 리턴
#- agg_fun( ) 내의 aggregate( ) 함수는 year 및 stat_name의 각 수준에 대하여 on_tot 값을 합산(sum)을 수행

#xtabs( ) 함수는 세로로 긴 데이터 프레임 total을 가로에 stat_name, 세로에 year의 각 수준으로 나타내는 테이블을 만들어 해당하는 on_tot 값을 출력한다.

#아래의 코드는 각 지하철역의 4개 년도 누적 탑승객 수를 계산하는 과정이다.
cum_total <- lapply(total, xtabs, formula = on_tot ~ stat_name) 
cum_total_vec <- unlist(cum_total) 
names(cum_total_vec) <- unlist(lapply(strsplit(names(cum_total_vec),"\\."), function(x) x[2])) 
line_num <- factor(rep(1:8, lapply(cum_total, length)), labels=paste0(1:8, "호선")) 
df2 <- data.frame(stat_name=names(cum_total_vec), line_num=line_num, on_tot=cum_total_vec, stringsAsFactors = FALSE) 
df2$stat_name<-factor(df2$stat_name, levels=df2$stat_name)

#lapply( ) 와 xtabs( )를 사용하여 각 역의 4개 연도의 탑승객 수를 계산하여 cum_total 이름의 리스트에 정장 후, 이를 cum_total_vec 이름의 벡터로 저장
#- unlist( )는 리스트 객체를 벡터 객체로 변환하는 함수
#paste0( ) 함수를 이용하여 각 지하철역의 노선 정보를 line_num 변수에 저장
#지하철 역명(stat_num), 노선명(line_num), 4개 년도 탑승자 수(on_tot)을 변수로 갖는 데이터 프레임 df2를 생성
#위의 과정에서 만들어진 데이터 프레임 df2를 막대그래프로 시각화하고 각 역의 색상을 노선별로 다르게 하여 노선 및 역별 누적 탑승객 수를 비교하기 용이하도록 한다.

plt <- ggplot(df2, aes(x=stat_name, y=on_tot, fill=line_num)) 
plt + theme_bw() + geom_bar(stat="identity", colour="white") + scale_x_discrete("지하철역", labels=NULL) + ylab("탑승객수") + scale_fill_discrete(name=c("노선"))

#ggplot( )를 이용하여 결과를 막대그래프로 시각화 함
#aes( ) 함수를 이용하여 x축 변수(x=stat_name), y 축 변수(y=on_tot), 노선별 색상(fill-line_num)을 지정한다.
#theme_bw( )는 그림의 배경을 흰색으로 설정
#geom_bar( )를 이용하여 막대그래프를 생성
#- stat="identity"는 y 축 변수의 값을 막대그래프의 높이로 지정. 디폴트는 도수(count)를 막대의 높이로 이용
#- colour_"white"는 막대의 경계색을 흰색으로 지정. 이는 막대 간의 여백을 추가하는 효과를 주어 그래프의 가독성을 높임
#- 주의 : ggplot2 패키지에 사용되는 함수는 색에 대한 영어명을 미국식의 color 대신 영국식의 colour를 사용해야 함
#그림 축에 대한 레이블 및 범례의 이름을 재지정
#- scale_x_discretr( )은 이산형 변수로 주어진 x축의 이름을 지정하고 labels=NULL을 설정하여 불필요한 역이름이 x축에 표기하지 않게 하여 번잡함을 없앰
#- ylab( ) 함수를 이용하여 y 축의 이름을 표기한다.
#- scale_fill_discrete( )은 이산형 변수로 주어진 색상에 대한 범례의 이름을 재지정하기 위해 사용




#<탑승객 수 기준 상위 / 하위 10개역 추출 및 정보 시각화>
# 본 편에서는 전 편에서 계산한 누적 탑승객 수를 기준으로 이용자 수가 많은 상위 10개 역 및 하위 10개 역을 추출하여 승객수 변화에 대한 패턴 차이가 있는지 시각화를 통해 비교한다.

#상위 10개역 추출
#아래 코드는 총 누적 탑승객 수를 기준으로 지하철역을 순서화하여 상위 10개 역을 추출하고, 탑승객 수를 막대그래프로 시각화하는 과정이다.

idx_top10 <- cum_total_vec >= sort(cum_total_vec, decreasing=TRUE)[10] 
cum_total_vec[idx_top10]

df3 <- subset(df2, subset = idx_top10) 
lim <- c(0, max(df2$on_tot)) 
plt <- ggplot(df3, aes(stat_name, y=on_tot, fill=line_num)) 
plt + geom_bar(stat="identity", colour="white") 
+ xlab("상위 10개 지하철역") + scale_y_continuous("탑승객수", lim=lim) 
+ scale_fill_discrete(name=c("노선"))







#탑승객 기준 상위 10개 역을 찾아 이에 대응하는 인덱스를 idx_top10에 저장
#10개 역 정보만을 추려 df3의 데이터 프레임으로 저장하여 이를 시각화에 이용
#- geom_bar( )는 aes( )에서 y로 선언된 변수 (y=on_tot)에 대한 막대그래프를 x로 선언된 값 위치에 시각화를 구현함
#- scale_y_continous( )는 연속형 변수로 선언된 y 축의 이름을 탑승객 수 이름으로 변경하고 lim=lim을 이용하여 y 축의 범위를 0부터 on_tot 변수의 최댓값으로 지정

#하위 10개 역추출
#위와 유사한 방식으로, 총 누적 탑승객 수 기준 하위 10개 역을 추출하고 이를 막대그래프로 시각화하는 과정은 아래와 같다.
#상위 및 하위 10개 역의 막대그래프를 동일한 범위로 시각화하여 탑승객 수의 비교를 용이하게 한다.
idx_bot10 <- cum_total_vec <= sort(cum_total_vec, decreasing=FALSE)[10] 
cum_total_vec[idx_bot10]
df4 <- subset(df2, subset = idx_bot10) 
plt <- ggplot(df4, aes(stat_name, y=on_tot, fill=line_num)) 
plt + geom_bar(stat="identity", colour="white") + xlab("하위 10개 지하철역") + scale_y_continuous("탑승객수", lim=lim) + scale_fill_discrete(name=c("노선"))


#탑승객 기준 하위 10개 역을 찾아 이를 df4에 저장하여 시각화
#상위 10개 역과 동일한 스케일로 그려 비교가 가능하게 한다.

#<2013년 상위 10개 역 월별 탑승객 추이>
#월별 탑승객의 추이를 확인하기 위해 각 10개 역별로 선 그래프를 활용하여 시각화하고 월별 이용자 수의 패턴을 확인한다.
stat_top10_2013 <- subset(subway2, subset = stat_name %in% names(cum_total_vec[idx_top10]) & year=="2013", select=c("stat_name", "on_tot", "month")) 
stat_top10_2013 <- aggregate(on_tot ~ month + stat_name, stat_top10_2013, sum)

#2013년도의 자료를 subway2로부터 추출하여 stat_top10_2013으로 저장한다.
#- aggregate( ) 함수를 이용하여 2013년도의 총 누적 승객수를 합산한다.
#위에서 생성된 stat_top10_2013을 선 그래프로 시각화하는 과정은 다음과 같다.
plt <- ggplot(stat_top10_2013, aes(x=month, y=on_tot, colour=stat_name, group=stat_name)) 
plt <- plt + theme_classic() + geom_line() + geom_point(size=6, shape=19, alpha=0.5) 
plt + scale_x_discrete("2013년", labels=paste0(unique(as.numeric(month)), 
                                              "월")) + ylab("월별 탑승객수") + scale_colour_discrete(name=c("지하철역"))

#geom_line( )을 이용하여 선 그래프를 그린다.
#- ggplot( )의 aes( ) 내에 group=stat_name을 지정함으로써 선 연결을 역별로 취하도록 지정
#geom_point( )를 이용하여 해당 값을 점으로 표현, size 옵션을 이용하여 크기를 조정하고, shape 옵션으로 점의 모양을 지정. alpha 값을 0에서 1사이 값으로 지정하여 투명도를 조정한다.
#theme_classic( )은 그래프의 배경을 클래식 모드로 전환
#scale_c_discrete( ) 함수는 이산형으로 정의된 x 축의 그래픽 옵션을 수행. labels=past0(unique(as.numeric(momth)), "월")을 사용하여 x 축의 틱마크값을 1월 ~12월로 재표현
#scale_colour_discrete( )은 색상 표현에 사용되는 이산형 변수(stat_name)를 나타내는 범례의 이름을 재지정

#<2013년 하위 10개 역 월별 탑승객 추이>
#위와 유사하게, 선 그래프를 활용하여 총 탑승객 수를 시각화하고 월별 이용자 수의 패턴을 확인한다.
#상위 10개 역의 경우 2월, 8월 및 9월에 탑승객 수의 일시적인 감소를 보이는 반면, 하위 10개 역에서는 이러한 현상이 뚜렷이 나타나지 않는다.

#특이사항으로는 마곡역의 경우, 계절에 상관없이 지속적으로 탑승객 수가 증가하는 현상을 볼 수 있다.이는 최근 마곡지구의 개벌로 인한 인구수 증가로 인하여 이용자가 증가하는 것으로 파악한다.
stat_bot10_2013 <- subset(subway2, subset = stat_name %in% names(cum_total_vec[idx_bot10]) & year=="2013", select=c("stat_name", "on_tot", "month")) 
stat_bot10_2013 <- aggregate(on_tot ~ month + stat_name, stat_bot10_2013, sum) 

plt <- ggplot(stat_bot10_2013, aes(x=month, y=on_tot, colour=stat_name, group=stat_name)) 
plt <- plt + theme_classic() + geom_line() + geom_point(size=6, shape=19, alpha=0.5) 
plt + scale_x_discrete("2013년", labels=paste0(unique(as.numeric(month)), "월")) + ylab("월별 탑승객수") + scale_colour_discrete(name=c("지하철역"))

#위 10개 역의 2013년 자료를 stat_bot10_2013에 저장하여 이를 선 그래프로 시각화
#상위 10개 역과 비교하여 월별 탑승객 수의 패턴이 상이함을 알 수 있음


#<노선별 역당 평균 탑승객 수의 계산 및 비교>
#본 자료는 각 노선의 모든 역을 포함하고 있지 않다.따라서 누적 승객수를 계산하는 것은 전체 노선 사용자를 나타내는데 적절치 않다.따라서 노선에 포함되는 역들의 평균 탐승객 수를 계산하여 이를 각 노선의 탑승객 수와 비교한다.
subway3 <- merge(subway2[, c("stat_name", "income_date", "on_tot", "year", "month")], subname[, c("STATION_NM","LINE_NUM","XPOINT_WGS","YPOINT_WGS")], by.x="stat_name", by.y="STATION_NM") 

tmp1 <- aggregate(on_tot ~ LINE_NUM + stat_name, subway3, sum, na.rm=TRUE) 
tmp2 <- aggregate(on_tot ~ LINE_NUM, tmp1, mean, na.rm=TRUE)
tmp2

#2개의 테이터 프레임 subway2및 subname2를 merge( ) 함수를 이용하여 병합한 후, 이를 subway3로 저장한다.
#- subway2의 변수 stat_name과 subname2의 변수 STATION_NM 이 동일하게 지하철역 이름이므로 by.x 및 by.y에 이를 지정하여 병합 시 해당 변수가 키(key)로 선언하여 이를 기준으로 병합을 수행한다.
#각 노선별 지하철역 평균 탑승객 수를 계산하여 tmp2 변수에 저장 후, 이를 파이 차트로 표현

# 함수 sum( ) 및 mean( )을 수행 시, 결측 값(NA)이 있으면 결과가 NA로 리턴된다. 따라서 결측값을 제외하고 합산 및 평균값을 계산하기 위해 na.rm=TRUE를 지정한다.

#파이 차트를 이용하여 노선별 탑승객 수를 시각화하여 상대 비교를 가능케 한다.
#시각적 효과를 살리기 위해 가급적 지하철 노선의 색상으로 맞추어준다.
col <- c("red", "springgreen2", "orange", "blue", "purple", "brown", "khaki","deeppink", "yellow", "deepskyblue")
pie(tmp2$on_tot, labels=paste0(unique(tmp2$LINE_NUM),"호선"), col=col, border="lightgray", main="노선별 평균 지하철 탑승객 수")


#각 노선의 색상을 col로 수동 지정하여 실제 지하철 노선의 색상에 근사하도록 표현했다.
#B 호선은 "분당선", I 호선은 "인천지하철 1호선"을 의미한다.

#<노선별 누적 승객 수의 상대 비교>
#각 노선에 대하여 월별 총 탑승객 수를 계산하여 이를 영역 차트(area chart)로 시각화하여 전체 탑승객 수에서 각 노선이 차지하는 비율의 추이를 시계열적으로 파악한다.
#단, 노선에 속하는 모든 역에 대한 정보가 없고 일부의 역만을 이용하고 있으므로 결과 해석에 주의를 요한다. 이 방법은 전체 자료가 있는 경우, 노선별 이용객 비율의 추이를 살펴보는 데 좋은 시각화 기법이다.

yearmonth <- paste(subway3$year, subway3$month, "01", sep="-")
yearmonth <- as.Date(yearmonth)
tmp3 <- cbind(subway3, yearmonth)
tmp3$LINE_NUM <- paste0(tmp3$LINE_NUM, "호선")
tmp4 <- aggregate(on_tot ~ LINE_NUM + yearmonth, tmp3, sum, na.rm=TRUE)
plt <- ggplot(tmp4, aes(x=yearmonth, y=on_tot, fill=LINE_NUM))
plt <- plt + geom_area(colour="white", size=0.2)
plt <- plt + scale_fill_manual(name="노선", values=col)
plt + theme_classic() + xlab("연") + ylab("누적승객수")

#각 노선에 대하여 월별 총 누적 탑승객 수를 계산하여 이를 tmp4에 저장한 후, 이를 영역 차트(area chart)로 시각화한다.
#geom_area( )를 이용하여 영역 차트를 표현
#scale_fill_manual( ) 함수를 이용하여 색상을 수동으로 지정함




#<구글맵을 활용한 지도 매핑>
#R은 지도 매핑을 위한 다양한 라이브러리를 제공한다. 구글맵은 고품질의 지도를 제공하며 위도 및 경도를 활용하여 위치를 손쉽게 특정할 수 있다.
#R에서 제공하는 ggmap 패키지를 활용하여 구글맵을 다운로드하고, 이를 R에서 시각화하는 기법을 배워본다. 또한 분석의 결과를 지도에 매핑하여 수치 결과를 지리 정보와 함께 시각화하는 방법을 예로 보여준다

#구글맵을 활용한 지도 매핑의 예시
#인터넷을 통해 구글맵을 다운로드하는 코드는 아래와 같다.
#수도권 지하철 정보를 시각화하기 위해 서울역(위도 37.55, 경도 126.97)을 중심으로 인근 지역을 구글로부터 다운로드해 이를 시각화한다.

#아래는 2012년 5월 8일 하루 동안 탑승한 인원을 각 역별로 수치화하고 이를 지하철역 위치에 크기에 비례하는 원으로 표현하는 코드다.

library(ggmap)
dat1 <- subset(subway3, income_date=="2012-05-08", select=c("XPOINT_WGS", "YPOINT_WGS", "on_tot", "stat_name", "LINE_NUM"))
Map_Seoul <- get_map(location=c(lat=37.55, lon=126.97), zoom=11, maptype="roadmap") # 서울역의 위도 경도
MM <- ggmap(Map_Seoul)
MM2 <- MM+geom_point(aes(x=YPOINT_WGS, y=XPOINT_WGS, size=on_tot, colour=as.factor(LINE_NUM)), data=dat1)
MM2 + scale_size_area(name=c("탑승객수")) + scale_colour_discrete(name=c("노선")) + labs(x="경도", y="위도")


#ggmap 패키지에서 제공하는 get_map( ) 함수를 이용하여 서울지역의 구글맵을 다운로드한다.
#- location에 위도 및 경도를 넣어 중심 위치를 지정했다. 위의 예제에서는 서울역의 위도 및 경도를 입력한 것이다.
#- zoom=11을 이용하여 지도 표시 레벨을 설정했다. 작은 값을 주면 넓은 영역이 표시되고 큰 값을 주면 작은 영역이 자세히 표현된다.
#- maptype을 terrain, satellite, roadmap, watercolor, hybrid 등으로 설정하면 다양한 형태의 지도로 구현할 수 있다.
# ggmap( )는 구글 지도를 시각화하는 함수다.
#geom_point( ) 및 scale_size_area( ) 함수를 이용하여 구글 지도 위에 특정한 날(2012년 5월 8일)에 각 역의 총 탑승객 수를 원의 크기에 비례하도록 시각화한 것이다.

#<2013년도 탑승객 수 상위 10개 역에 대한 지도 매핑>
#구글맵을 사용하여 상위 10개 역의 2013년도의 탑승객 수를 지도에 시각화한다.
#이때 누적 탑승객 수에 비례하게 원의 크기를 조절하여 각 역의 탑승객 수에 대한 정보를 시각적으로 전달한다.

#total <- lapply(Line[1:8], FUN=agg_fun, dat=subway2) 
lapply(total, xtabs, formula = on_tot ~ stat_name + year)


idx <- which(cum_total_vec >= sort(cum_total_vec, decreasing=TRUE)[10])
# 상위 10 개역의 2013 년도 탑승객
stat_top10_2013 <- subset(subway2, subset = year=="2013" & stat_name %in% names(cum_total_vec[idx]))
dat2 <- aggregate(on_tot ~ stat_name, stat_top10_2013, sum)
dat2 <- merge(dat2, subname, by.x="stat_name", by.y="STATION_NM")
MM3 <- MM + geom_point(aes(x=YPOINT_WGS, y=XPOINT_WGS, size=on_tot), alpha=0.5, data=dat2)
MM3 + scale_size_area(name=c("탑승객수"), max_size=15) + geom_text(aes(x=YPOINT_WGS, y=XPOINT_WGS, label=stat_name), colour="red", vjust=3, size=3.5, fontface="bold", data=dat2) + labs(x="경도", y="위도")

#scale_size_area( ) 함수에서 max_size를 이용하여 전체적인 원의 크기를 재조정한다.
#geom_text( ) 함수를 이용하여 각 역의 이름을 원 근방에 표기하여 가독성을 높인다.






#<뉴스 데이터의 활용>
#여기서부터는 JSON 파일 형태로 저장된 뉴스 자료를 이용하여 탑승객 수의 패턴 변화가 해당 시간 및 지역에서 발생한 이벤트와 연관이 있는지 살펴본다.

#이상점을 판단하기 위해 회귀분석을 이용한다.

#<회귀분석>
#회귀분석은 반응 변수를 다수의 설명 변수의 값에 의해 예측하는 모형을 제공한다.
#이번 포스팅에서 탑승객 수를 지하철역, 지하철 노선, 달, 요일의 요인에 의해 예측하는 모형을 적합한다. 탑승객 수를 예측하기 위한 모형으로 회귀분석은 그리 정교하다고 보긴 어렵다.
#하지만, 전반적인 패턴은 단순한 회귀분석을 통해 도출 가능하며 예측 모형으로 널리 쓰이기에 한번 다뤄보기로 한다.

#아래의 코드는 회귀 분석을 수행하기 위한 자료 정리 과정 및 회귀분석 수행 과정을 보여준다.
#탑승객 수가 월 효과, 요일 효과, 노선별 효과가 있다고 가정하고 있으며, 각 역의 특수성을 고려하여 회귀분석을 수행한다.

dat4_1 <- subset(subway2, subset= year=="2013", select=c("stat_name", "income_date", "on_tot"))
dat4_2 <- subset(subname, subset = STATION_NM %in% unique(dat4_1[,"stat_name"]), select=c(STATION_NM, LINE_NUM, XPOINT_WGS, YPOINT_WGS))
dat4 <- merge(dat4_1, dat4_2, by.x="stat_name", by.y="STATION_NM")
month <- format(dat4[,"income_date"], "%m")
day <- format(dat4[,"income_date"], "%a")
dat4 <- cbind(dat4, month, day)
head(dat4)

lm.res <- lm(on_tot ~ as.factor(stat_name) + as.factor(LINE_NUM) + month + day, data=dat4)


#회귀분석 수행을 위한 자료 정리 과정이다.
#- subset( ) 함수를 통해 2013년도 자료 및 사용 변수들을 subway2 및 subname2의 데이터 프레임으로부터 추려낸다.
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
#- 이에 대한 상자 그림을 통해 2개의 관측치가 매우 큰 잔차를 가짐을 확인할 수 있다.

#★ 높은 스튜던트 잔차를 갖는 2개의 이상점에 대한 정보를 idx에 저장한다.
#- 2개 모두 월드컵 경기장 역에서 관측되었으며 해당 일자는 2013년 10월 12일 및 26일 임을 확인

#위의 과정을 통해 탐지된 2개의 이상점이 모두 월드컵 경기장 역으로 나타났으므로, 해당 역의 탑승객 수의 시계열 그래프 상에서 해당 날짜의 탑승객 수가 얼마나 상이한지 시각적으로 살펴보는 과정은 아래와 같다.

dat_worldcup <- subset(dat4, subset= stat_name =="월드컵경기장") 
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






























