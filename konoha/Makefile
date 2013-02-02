
files=API.idl

.PHONY : all
all: $(files)

.PHONY : clean
clean:
	-rf *.gen.k

API.idl: Syntax.IDL.k
	minikonoha API.idl app=MyappClient #output=js
	minikonoha API.idl app=MyappServer #output=js
