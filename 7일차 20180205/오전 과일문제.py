apple_price = 1000
grape_price = 3000
pear_price = 2000
orange_price = 500
apple_num = 0
grape_num = 0
pear_num = 0
orange_num = 0
total = 0
sale = False
while True:
    fruit = input("구입 하려는 과일의 이름을 입력하세요 (입력을 종료하려면 q를 입력) : ")
    if fruit == "q":
        break
    else:
        num = int(input("과일의 개수를 입력해주세요"))
        if fruit == "사과":
            apple_num += num
            total += apple_price * num
        elif fruit == "포도":
            grape_num += num
            total += grape_price * num
        elif fruit == "배":
            pear_num += num
            total += pear_price * num
        elif fruit == "귤":
            orange_num += num
            total += orange_price * num
if grape_num >= 3:
    total *= 0.7
orange_num += int(orange_num / 10) * 2

print("귀하는 ", end="")
if apple_num > 0:
    print("사과 -> %d 개   " % apple_num, end="")
if grape_num > 0:
    print("포도 -> %d 개   " % grape_num, end="")
if pear_num > 0:
    print("배 -> %d 개    " % pear_num, end="")
if orange_num > 0:
    print("귤 -> %d 개    " % orange_num, end="")
print("총 가격은 %d원 입니다. " % total)
