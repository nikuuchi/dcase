app=Myapp

.PHONY : all
all: gen/$(app)Client.gen.js gen/$(app)Client.gen.k gen/$(app)Server.gen.k

.PHONY : clean
clean:
	rm -f gen/*.gen.{js,k}

API.idl: Syntax.IDL.k

gen/$(app)Client.gen.k : API.idl
	./API.idl app=$(app)Client

gen/$(app)Client.gen.js : API.idl
	./API.idl app=$(app)Client format=js

gen/$(app)Server.gen.k : API.idl
	./API.idl app=$(app)Server
