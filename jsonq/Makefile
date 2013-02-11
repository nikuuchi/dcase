BRANCH=-`git branch --contains=HEAD | grep "*" | head -1 | cut -c 3-`
BUILD=Debug
target=$(BUILD)$(BRANCH)
#target=Release
#target=Compressed

.PHONY : all
all:
	make -C $(target) all -j8 > /dev/null

.PHONY : clean
clean:
	make -C $(target) clean > /dev/null

.PHONY : install
install:
	make -C $(target) install -j8 > /dev/null

.PHONY : test
test:
	make -C $(target) test

.PHONY : dep
dep:
	mkdir -p $(target) && cd $(target) && cmake  .. -DCMAKE_BUILD_TYPE=$(BUILD)
