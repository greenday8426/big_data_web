import re

passw,idw,kname,ename,tel,hp,email,jumin,ip,sogae = '','','','','','','','','',''
r= re.compile(" [a-z][\w]{8,}"    )##ID 정규식
while True :
    str = input("ID입력")
    if r.search(str) == None:
         print("잘못입력")
         continue
    else :
         idw=str
         print(str)
         break   


r= re.compile( "[\w]{8,}"     )##Password 정규식
while True :
    str = input("Password입력")
    if r.search(str) == None:
         print("잘못입력")
         continue
    else :
         passw=str
         print(str)
         break   
