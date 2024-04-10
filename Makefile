examples = \
	lsearch \
	intarray \
	genarray

examples/%: examples/%.o src/%.o
	$(CC) $(CFLAGS) -o $(@) $(^)

all_tests=$(wildcard features/*.cpp)

CFLAGS = -I src
CXXFLAGS = -std=c++14 -I src
LDFLAGS = -lCatch2 -lCatch2Main

TARGETS = $(addprefix examples/, $(examples))
TESTS = $(patsubst %.cpp,%,$(all_tests))

targets: $(TARGETS) $(TESTS)

all: targets test memtest

test: $(TESTS)
	@for test in $^ ; do [ ! -x $${test} ] && echo "FAILED: $${test} not found." || $${test} --success ; done

memtest: $(TESTS)
	@for test in $^; do [ -x $${test} ] && echo "MEMTEST: $${test}" && valgrind --leak-check=full -s $${test} --success 2>&1 | sed -n -e "/MEMTEST:/p;/LEAK SUMMARY/,/ERROR SUMMARY/p" ; done

clean:
	$(RM) $(TESTS) features/*.o{,pp} examples/*.o src/*.o{,pp}

.PHONY: all clean tests memtest

include Makefile.rules

examples/lsearch: examples/lsearch.o src/util.o
	$(CC) -o $(@) $(^)
