examples = \
	lsearch \
	intarray \
	genarray

all_tests=$(wildcard features/*.cpp)

CFLAGS = -I src
CXXFLAGS = -std=c++14 -I src

TARGETS = $(addprefix examples/, $(examples))
TESTS = $(patsubst %.cpp,%,$(all_tests))

all: $(TARGETS) tests

tests: $(TESTS)

features/SetValue: features/SetValue.o
	$(CXX) -c -o src/genarray.o src/genarray.c
	$(CXX) $(CXXFLAGS) -lCatch2 -lCatch2Main -o $(@) src/genarray.o $(^)
	$(@) --success

features/Insert: features/Insert.o
	$(CXX) -c -o src/genarray.o src/genarray.c
	$(CXX) $(CXXFLAGS) -lCatch2 -lCatch2Main -o $(@) src/genarray.o $(^)
	$(@) --success

features/Remove: features/Remove.o
	$(CXX) -c -o src/genarray.o src/genarray.c
	$(CXX) $(CXXFLAGS) -lCatch2 -lCatch2Main -o $(@) src/genarray.o $(^)
	$(@) --success

clean:
	$(RM) $(TESTS) features/*.o examples/*.o src/*.o

.PHONY: all tests clean

examples/lsearch: examples/lsearch.o src/util.o
	gcc -o $(@) $(^)

examples/intarray: examples/intarray.o src/intarray.o
	gcc -o $(@) $(^)

examples/genarray : examples/genarray.o src/genarray.o
	gcc -o $(@) $(^)


