import re
a='Raindrops# on* Roses, and Whiskers! on Kittens.'

r=re.compile(r"\b(\w+)\W")
print(r.findall(a))
