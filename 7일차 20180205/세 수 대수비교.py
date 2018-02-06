a,b='', 0
sum=0
suma,sumb,sumc,sumd=0,0,0,0
##메인(main) 코드 부분
while True:
    a=input("구입하려는 과일의 이름을 입력하세요. (입력을 종료하려면 q를 입력):")
    if a=='q':
        break
        
    b=int(input("구입하려는 과일의 개수를 입력하세요. (입력을 종료하려면 q를 입력):"))

  
    if a=='사과':
        suma+=1000*b
    elif a=='포도':
        
        sumb+=3000*b
        if b>=3:
            sum*=0.9
    elif a=='배':
        sumc+=2000*b
    elif a=='귤':
            umd+=500*b
 
        
sum=suma+sumb+sumc+sumd       
print("총 금액 %d를 구입했습니다." %sum)
    






