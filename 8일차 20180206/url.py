import re
str1='''https://search.daum.net/search?nil_suggest=btn&nil_ch=&rtupcoll=&w=tot&m=&f=&lpp=&DA=SBC&sug=&sq=&o=&sugo=&q=reg
 ?nil_suggest=btn&nil_ch=&rtupcoll=&w=tot&m=&f=&lpp=&DA=SBC&sug=&sq=&o=&sugo=&q=reg'''
str2='''https://search.daum.net/search?'''

str3=str1'-'str2
m=p.match(str3)
print(m.group())
