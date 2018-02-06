##변수 선언 부분
select, answer, numStr, num1, num2=0,0,"",0,0

##메인(main) 코드 부분
select=int(input("1.수식 계산기 2.두 수 사이 합계:"))

if select==1:
    numStr=input("***수식을 입력하세요 : ")
    answer=eval(numStr)
    print("%s 결과는 %5.1f 입니다. " %(numStr, answer))
elif select==2:
    num1=int(input("*** 첫 번째 숫자를 입력하세요: "))
    num2=int(input("*** 두 번째 숫자를 입력하세요: "))
    for i in range(num1, num2+1):
        answer=answer+i
    print("%d+...+%d는 %d입니다." %(num1, num2, answer))
else:
    print("1 또는 2만 입력해야 합니다.")
