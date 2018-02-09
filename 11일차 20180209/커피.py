import urllib.request
import urllib.parse
from bs4 import BeautifulSoup
a=input("검색 분류를 입력하세요. 1-뉴스 2-블로그 3-카페 ")
if a=="1":
    defaultURL = 'https://openapi.naver.com/v1/search/news.xml?'
    print(defaultURL)
elif a=="2":
    defaultURL = 'https://openapi.naver.com/v1/search/blog.xml?'
    print(defaultURL)
elif a=="3":
    defaultURL = 'https://openapi.naver.com/v1/search/cafearticle.xml?'
    print(defaultURL)

## 가져올 url 작성
# 새로운 API에서 사용하는 요청 변수를 각각의 변수에 담아줌 
sort = 'sort=sim' #검색 정렬 - 기본(유사도), date(날짜순) 
start = '&start=1' #검색시작위치 (1-1000)
display = '&display=100' #검색결과 출력건수 지정 (10-100)
query = '&query=' + urllib.parse.quote_plus(str(input("검색어를 입력하세요: ")))  # 사용자에게 검색어를 입력받아 quote_plus 함수로 UTF-8 타입에 맞도록 변환시켜 줍니다.
fullURL = defaultURL + sort + start + display + query
print(fullURL)

file = open("C:\\python36\\"+ str(input("파일명을 입력하세요"))+".txt", "w", encoding='utf-8') #저장 위치

headers={
        'Host':'openapi.naver.com',
        'User-Agent':'curl/7.43.0',
        'Accept':'*/*',
        'Content-Type':'application/xml',
        'X-Naver-Client-Id':'014VqkiZDGAZIzLtMb7m',
        'X-Naver-Client-Secret':'cVJTbXqNe3'
        }


req = urllib.request.Request(fullURL, headers=headers)
# 생성된 request객체를 uplopen함수의 인수로 전달, 이렇게 되면 헤더 정보를 포함하여 서버에게 HTTP 요청
f = urllib.request.urlopen(req) #response 
resultXML = f.read() #요청받은 내용 (관련정보를 담고있는 추상화된 클래스)

xmlsoup = BeautifulSoup(resultXML, 'html.parser') #parsing html 형태로 or lxml
xmlsoup
items = xmlsoup.find_all('item') 
#item 객체 모두 찾는 <item><title>
items
#개별 검색 결과이며, title, link, description, bloggername, bloggerlink을 포함
len(items)

for item in items:
    if a=="1":
        file.write('--------------------------\n')
        file.write('뉴스제목 : ' + item.title.get_text(strip=True) + '\n')
        file.write('내용요약 : ' + item.description.get_text(strip=True) + '\n')
        file.write('뉴스주소 : ' + item.link.get_text(strip=True) + '\n')   
        file.write('--------------------------\n')
    elif a=="2":
        file.write('--------------------------\n')
        file.write('블로그제목 : ' + item.title.get_text(strip=True) + '\n')
        file.write('내용요약 : ' + item.description.get_text(strip=True) + '\n')
        file.write('블로그주소 : ' + item.link.get_text(strip=True) + '\n')   
        file.write('--------------------------\n')
    elif a=="3":
        file.write('--------------------------\n')
        file.write('카페제목 : ' + item.title.get_text(strip=True) + '\n')
        file.write('내용요약 : ' + item.description.get_text(strip=True) + '\n')
        file.write('카페주소 : ' + item.link.get_text(strip=True) + '\n')   
        file.write('--------------------------\n')
#naver api는 요약내용 제공
file.close()
