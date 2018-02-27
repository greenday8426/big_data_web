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






