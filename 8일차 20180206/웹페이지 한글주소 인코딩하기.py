import urllib.parse

def input_query(): #urllib.parse.quote_plus 사용 안함
    q=str(input("검색어를 입력하세요:"))
    return "&query="+q
input_query()

def input_query():  #urllib.parse.quote_plus 사용함
    q=urllib.parse.quote_plus(str(input("검색어 입력하세요:")))
    return "&query="+q
input_query()
