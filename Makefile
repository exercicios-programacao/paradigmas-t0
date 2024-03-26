tests = \
	tests/lsearch \
	tests/intarray \

#	tests/genericarray \
#	tests/doublearray \
#	tests/strarray

CFLAGS = -I src

all: $(tests)

clean:
	$(RM) $(tests) tests/*.o src/*.o

.PHONY: all clean

tests/lsearch: tests/lsearch.o src/util.o
	gcc -o $(@) $(^)

tests/intarray: tests/intarray.o src/intarray.o
	gcc -o $(@) $(^)

tests/genericarray: tests/genericarray.o src/dynarray.o
	gcc -o $(@) $(^)

tests/doublearray: tests/doublearray.o src/dynarray.o
	gcc -o $(@) $(^)

tests/genarray: tests/strarray.o src/genarray.o
	gcc -o $(@) $(^)

