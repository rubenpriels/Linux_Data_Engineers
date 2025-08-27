# Makefile

- [Makefile](#makefile)
  - [vooorbeeld 1](#vooorbeeld-1)
  - [vooorbeeld 2](#vooorbeeld-2)

## vooorbeeld 1

```bash
.PHONY: all clean

all: true false
true: true.c booleans.h
    gcc -o true true.c
false: false.c booleans.h
    gcc -o false false.c
clean:
    rm -vf true false
```

## vooorbeeld 2

```bash
sources := $(wildcard *.c)
objects := $(patsubst %.c,%.o,$(sources))
executables := true false

CC := gcc
CFLAGS := -Wall -O

.PHONY: all clean mrproper

all: $(executables)

%: %.o
    $(CC) $(CFLAGS) -o $@ $<

%.o: %.c booleans.h
    $(CC) $(CFLAGS) -c $<

clean:
    rm -vf $(objects)

mrproper: clean
    rm -vf $(executables)
```
