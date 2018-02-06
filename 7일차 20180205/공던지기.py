h=int(input("높이를 입력하세요(m):"))
n=0
while(h>=0.00001):
    
    h*=0.5

    if h<0.00001:
        break

    n+=1





print("공이 튀긴 횟수는 %d 회입니다." %n)
