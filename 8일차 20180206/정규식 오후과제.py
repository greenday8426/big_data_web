import re
str1='''https://search.daum.net/search?nil_suggest=btn&nil_ch=&rtupcoll=&w=tot&m=&f=&lpp=&DA=SBC&sug=&sq=&o=&sugo=&q=reg
 ?nil_suggest=btn&nil_ch=&rtupcoll=&w=tot&m=&f=&lpp=&DA=SBC&sug=&sq=&o=&sugo=&q=reg'''


r=re.compile('https://.+\?')

print("7번 ? 로 구분되는 변수 이전 부분(? 포함)")
print(r.findall(str1))

r=re.compile('https://[^?]+')
print("8번 ? 로 구분되는 변수 이전 부분(? 제외)")
print(r.findall(str1))



