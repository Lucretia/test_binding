all: test_binding
#all: cpp/test

test_binding: test_binding.gpr ../../src/ada/test_binding.adb
	gprbuild -p -Ptest_binding.gpr

#	gnatmake -O1 -gnatceg -gnatL -gnatdZ -gnatdV -g tester2.adb -largs example.o -lstdc++ -cargs -fdump-class-hierarchy -ggdb

#example.o: example.cpp example.h
#	g++ -O1 -fdump-class-hierarchy -g -ggdb -c example.cpp

#cpp/test: cpp/test.o cpp/derived1.o cpp/base.o
#	g++ -O1 -fdump-class-hierarchy -g -ggdb cpp/test.o cpp/derived1.o cpp/base.o -o cpp/test

#cpp/test.o: cpp/test.cpp
#	g++ -O1 -fdump-class-hierarchy -g -ggdb -c cpp/test.cpp -o cpp/test.o

#cpp/derived1.o: cpp/derived1.cpp
#	g++ -O1 -fdump-class-hierarchy -g -ggdb -c cpp/derived1.cpp -o cpp/derived1.o

#cpp/base.o: cpp/base.cpp
#	g++ -O1 -fdump-class-hierarchy -g -ggdb -c cpp/base.cpp -o cpp/base.o


.PHONY: clean

clean:
	gprclean -Ptest_binding.gpr
	-rm obj/*.class
#	-rm cpp/*.o cpp/test cpp/*.class
#	-rm example.o
#	-rm *.class *.ali *.o

