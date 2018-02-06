class human:
    name="서진수"
    def intro(self):
        print('제 이름은 서주원 입니다.')
class child(human): #human 클래스를 상속받아 child 클래서를 만듭니다.
    def hello(self):
        print('저는 %s 2세입니다.' %self.name)

jinsu=child() #child 클래스를 인스턴스로 생성합니다
jinsu.hello() #jinsu 인스턴스의 hello() 함수를 생성합니다.

class father:
    s_name='서주원'
    def intrd(self):
        print("나는 %s의 아빠입니다" %self.s_name)

class tall:
    height=180
    def hgt(self):
        print("제 키는 %s cm입니다" %self.height)

class child(father, tall):
    name="서진수"
    def hello(self):
        print("안녕하세요 %s 입니다" %self.name)

jinsu=child()
jinsu.hello()
jinsu.hgt()
jinsu.intrd()
