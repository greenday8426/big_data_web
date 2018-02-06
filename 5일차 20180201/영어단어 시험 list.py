list_spell_re=["r","e"]
list_spell_serve=["s","e", "r","v","e"]

list_spell_reserve=(list_spell_re)+(list_spell_serve)
print(list_spell_reserve)


list_spell_reserve.remove("r")
list_spell_reserve.remove("e")
list_spell_reserve.insert(0, "o")
list_spell_reserve.insert(1, "b")

print(list_spell_reserve)
    
