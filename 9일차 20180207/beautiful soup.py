Python 3.6.4 (v3.6.4:d48eceb, Dec 19 2017, 06:04:45) [MSC v.1900 32 bit (Intel)] on win32
Type "copyright", "credits" or "license()" for more information.
>>> html="""
<html>
    <head>
        <title> test web</title>
    </head>
    <body>
        <p align="center"> text contents1</p>
        <p align="right"> text contents2</p>
        <p align="left"> text contents3</p>
        <img src="C:python36\Koala.jpg" width="500" height="300">
    </body>
</html>"""
>>> from bs4 import BeautifulSoup
>>> bs=BeautifulSoup(html)

Warning (from warnings module):
  File "C:\python36\lib\site-packages\bs4\__init__.py", line 181
    markup_type=markup_type))
UserWarning: No parser was explicitly specified, so I'm using the best available HTML parser for this system ("html.parser"). This usually isn't a problem, but if you run this code on another system, or in a different virtual environment, it may use a different parser and behave differently.

The code that caused this warning is on line 1 of the file <string>. To get rid of this warning, change code that looks like this:

 BeautifulSoup(YOUR_MARKUP})

to this:

 BeautifulSoup(YOUR_MARKUP, "html.parser")

>>> bs=BeautifulSoup(html)
>>> print(bs.prettify() )
<html>
 <head>
  <title>
   test web
  </title>
 </head>
 <body>
  <p align="center">
   text contents1
  </p>
  <p align="right">
   text contents2
  </p>
  <p align="left">
   text contents3
  </p>
  <img height="300" src="C:python36\Koala.jpg" width="500"/>
 </body>
</html>
>>> bs.find('p')
<p align="center"> text contents1</p>
>>> bs.find('a')
>>> html="""
<html>
    <head>
        <title> test web</title>
    </head>
    <body>
        <p align="center"> text contents1</p>
        <p align="right"> text contents2</p>
        <p align="left"> text contents3</p>
        <img src="C:python36\Koala.jpg" width="500" height="300">
    </body>
</html>"""
>>> bs=BeautifulSoup(html)
>>> bs.find('p', align="center")
<p align="center"> text contents1</p>
>>> bs.find('p', align="right")
<p align="right"> text contents2</p>
>>> bs.find('p', align="left")
<p align="left"> text contents3</p>
>>> html="""
<html>
    <head>
        <title> test web</title>
    </head>
    <body>
        <p align="center"> text contents1</p>
        <p align="right"> text contents2</p>
        <p align="left"> text contents3</p>
        <img src="C:python36\Koala.jpg" width="500" height="300">
    </body>
</html>"""
>>> bs=BeautifulSoup(html)
>>> bs.find_all('p')
[<p align="center"> text contents1</p>, <p align="right"> text contents2</p>, <p align="left"> text contents3</p>]
>>> head_tag=bs.find('head')
>>> head_tag
<head>
<title> test web</title>
</head>
>>> head_tag.find('title')
<title> test web</title>
>>> head_tag.find('p') # 자신의 태그안에 없는 태그입니다.
>>> body_tag=bs.find('body')
>>> list1=body_tag.find_all(['p','img'])
>>> 
>>> for tag in list1:
	print(tag)

	
<p align="center"> text contents1</p>
<p align="right"> text contents2</p>
<p align="left"> text contents3</p>
<img height="300" src="C:python36\Koala.jpg" width="500"/>
>>> bs.find_all('p')
[<p align="center"> text contents1</p>, <p align="right"> text contents2</p>, <p align="left"> text contents3</p>]
>>> import re
>>> tags=bs.find_all(re.compile("^p"))
>>> tags
[<p align="center"> text contents1</p>, <p align="right"> text contents2</p>, <p align="left"> text contents3</p>]
>>> bs.find_all(align="center")
[<p align="center"> text contents1</p>]
>>> bs.find_all(width="500")
[<img height="300" src="C:python36\Koala.jpg" width="500"/>]
>>> import re
>>> bs.find_all(text=re.compile("text+"))
[' text contents1', ' text contents2', ' text contents3']
>>> body_tag=bs.find('body')
>>> p_tag=body_tag.find('p')
>>> p_tag.string
' text contents1'
>>> strings=body_tag.strings
>>> for string in strings:
	print(string)

	


 text contents1


 text contents2


 text contents3




>>> body_tag=bs.find('body')
>>> body_tag.get_text()
'\n text contents1\n text contents2\n text contents3\n\n'
>>> body_tag.get_text(strip=True)
'text contents1text contents2text contents3'
>>> body_tag.get.text('-',strip=True)
Traceback (most recent call last):
  File "<pyshell#43>", line 1, in <module>
    body_tag.get.text('-',strip=True)
AttributeError: 'function' object has no attribute 'text'
>>> body_tag.get_text('-',strip=True)
'text contents1-text contents2-text contents3'
>>> html="""
<html>
    <head>
        <title> test web</title>
    </head>
    <body>
        <p class="ptag black" align="center"> text contents1</p>
        <p class="ptag yellow" align="center"> text contents2</p>
        <p class="ptag red" align="center"> text contents3</p>
        <img src="C:python36\Koala.jpg" width="500" height="300">
    </body>
</html>"""
>>> bs=BeautifulSoup(html)
>>> p_tag=bs.find('p')
>>> p_tag['class']
['ptag', 'black']
>>> p_tag['class'][1]='white'
>>> p_tag['class']
['ptag', 'white']
>>> p_tag['id']='P-TAG'
>>> p_tag['id']
'P-TAG'
>>> p_tag['align']
'center'
>>> del p_tag['align']
>>> p_tag['align']
Traceback (most recent call last):
  File "<pyshell#55>", line 1, in <module>
    p_tag['align']
  File "C:\python36\lib\site-packages\bs4\element.py", line 1011, in __getitem__
    return self.attrs[key]
KeyError: 'align'
>>> 
