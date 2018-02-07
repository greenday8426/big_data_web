import re

kname,number, address,birth  = '','','',''

r= re.compile( "^[가-힣]{1,5}$"    ) ##한글이름  정규식
while True :
    str = input("한글이름입력")
    if r.search(str) == None:
         print("잘못입력")
         continue
    elif str=='q':
        break
    else :
         kname=str
         print(str)
         break

r= re.compile( '^[1,2][0,9][0,1,9][\d]{3}[0,1][\d]{2}$'     )##학번 정규식
while True :
    str = input("학번입력")
    if r.search(str) == None:
         print("잘못입력")
         continue
    elif str=='q':
        break
    else :
         number=str
         print(str)
         break
        
r= re.compile( "^[서울, 대전, 대구, 부산, 광주, 인천, 울산, 경북, 경남, 충북, 충남, 제주, 강원, 전북, 전남][가-힇,\w]{1,17}$"    ) ##주소  정규식
while True :
    str = input("주소 입력")
    if r.search(str) == None:
         print("잘못입력")
         continue
    elif str=='q':
        break
    else :
         address=str
         print(str)
         break

r= re.compile( '^[\d]{2}[0,1][\d][0-3][\d]$'     )##생년월일 정규식
while True :
    str = input("생년월일 입력")
    if r.search(str) == None:
         print("잘못입력")
         continue
    elif str=='q':
        break
    else :
         birth=str
         print(str)
         break
        
