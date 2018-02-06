
num=input("16진수 한 글자를 입력하세요. ")
if (('A'<=num <='F') or ('0'<= num <= '9') or (num>='a' and num<='f')):
   
    
    print("10진수 ==> %d" %int(num,16))


else:
    print("16진수가 아닙니다.")


