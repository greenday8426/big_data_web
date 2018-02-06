ss=input("문자열 입력==>")
print("출력 문자열==>", end='')

if ss.startswith('(')==False :
    print("(", end='')

print(ss, end='')
if ss.endswith(')')==False:
    print(")", end='')

