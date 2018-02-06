sel=int(input("입력진수 결정(16/10/8/2): "))
num1=input("첫번째 값 입력:")
num2=input("두번째 값 입력:")

if sel==10:
    print(bin(num1)&bin(num2))
    print(bin(num1)^bin(num2))
    


