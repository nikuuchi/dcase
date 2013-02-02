app=Myapp

.PHONY : all
all: gen/$(app)Client.gen.k gen/$(app)Server.gen.k

.PHONY : clean
clean:
	rm -f gen/*.gen.k

API.idl: Syntax.IDL.k

gen/$(app)Client.gen.k: API.idl
	./API.idl app=$(app)Client
#output=js

gen/$(app)Server.gen.k: API.idl
	./API.idl app=$(app)Server
