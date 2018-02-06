import random


time=random.randrange(1,24)

print("현재 시각은 ", time)
ch=("True", "False")
weather=random.choice(ch)
print("현재 날씨는 ", weather)
if time>=6 and time<=9 and weather==True:
        print("종달새가 노래를 부릅니다.")
else:
        print("종달새가 노래를 부르지 않습니다.")
        
