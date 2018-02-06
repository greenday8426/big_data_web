i=1

def high_score(list):
    if a>b and a>c and a>d and a>e and a>f:
        max=a
    elif b>a and b>c and b>d and b>e and b>f:
        max=b
    elif c>a and c>b and c>d and c>e and c>f:
        max=c
    elif d>a and d>b and d>c and d>e and d>f:
        max=d
    elif e>a and e>b and e>c and e>d and e>f:
        max=e
    elif f>b and f>c and f>d and f>e and f>a:
        max=f

    
    
    return max(["a","b","c","d","e","f"])
        


a=int(input("첫째 값 입력: "))
b=int(input("두번째 값 입력: "))
c=int(input("세번째 값 입력: "))
d=int(input("네번째 값 입력: "))
e=int(input("다섯번째 값 입력: "))
f=int(input("여섯번째 값 입력: "))

score=["a","b","c","d","e","f"]
for i in score:
    high_score(score)

print("최고 점수는 %d 입니다." %max)
