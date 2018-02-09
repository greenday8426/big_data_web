import os
import sys
import urllib.request
import urllib.parse
from bs4 import BeautifulSoup
defaultURL='https://openapi.naver.com/v1/search/news.xml?'
# 새로운 API에서 사용하는 요청 변수를 각각의 변수에 담아둡니다.
sort='&sort=sim' # 유사도 순으로 검색
start='&start=1' # 검색시작
display='&display=100' #검색결과 출력건수
query='&query=' + urllib.parse.quote_plus(str(input("검색어를 입력하세요.:")))
#사용자에게 검색어를 입력받아 quote_plus 함수로 UTF-8 타입에 맞도록 변환시켜 줍니다.
fullURL=defaultURL+sort+start+display+query
print(fullURL)
file=open("저장경로와 파일명을 적어주세요","w",encoding='utf-8')
headers={
        'Host':'openapi.naver.com',
        'User-Agent':'curl/7.43.0',
        'Accept':'*/*',
        'Content-Type':'application/xml',
        'X-Naver-Client-Id':'014VqkiZDGAZIzLtMb7m',
        'X-Naver-Client-Secret':'cVJTbXqNe3'
        }
print(headers)
#HTTP 요청을 하기 전에 헤더 정보를 이용해 request 객체를 생성합니다. urllib 모듈에서 헤더 정보를 서버에 전달할 때
#사용하는 대표적인 방법 입니다.
req=urllib.request.Request(fullURL,headers=headers)
#생성된 request객체를 urlopen함수의 인수로 전달합니다. 이렇게 되면 헤더 정보를 포함하여 서버에게 HTTP 요청을 하게 됩니다.
f=urllib.request.urlopen(req)
resultXML=f.read()
xmlsoup=BeautifulSoup(resultXML, 'html.parser')
print(xmlsoup)
items=xmlsoup.find_all('item')
for item in items:
    file.write('---------------------\n')
    file.write('뉴스제목:'+item.title.get_text(strip=True)+ '\n')
    file.write('링크주소:'+item.originallink.get_text(strip=True)+'\n')
    file.write('요약내용:'+item.description.get_text(strip=True)+'\n')
    file.write('---------------------\n')
file.close()
