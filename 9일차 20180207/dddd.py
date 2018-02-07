math_score = [90,80,70,50,60]
def list_avg(numlist):
    for number in numlist:
        sum = sum + number
        avg = sum/len(numlist)

    return avg

result=list_avg(math_score)
print(result)



a=int(input("첫번째 숫자 입력: "))
b=int(input("두번째 숫자 입력: "))

def sub_number(a,b):
    
    return a-b

result=sub_number(a,b)
print("두 수의 차 result는",result, "입니다.")

