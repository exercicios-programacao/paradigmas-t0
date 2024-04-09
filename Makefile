examples = \
	lsearch \
	intarray \
	genarray

CFLAGS = -I src

TARGETS = $(addprefix examples/, $(examples))

all: $(TARGETS)

clean:
	$(RM) $(tests) examples/*.o src/*.o

.PHONY: all clean

examples/lsearch: examples/lsearch.o src/util.o
	gcc -o $(@) $(^)

examples/intarray: examples/intarray.o src/intarray.o
	gcc -o $(@) $(^)

examples/genarray : examples/genarray.o src/genarray.o
	gcc -o $(@) $(^)
