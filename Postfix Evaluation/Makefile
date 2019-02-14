ASM = nasm
CC = gcc
CFLAGS = -Wall -m32 -Wno-implicit-function-declaration
LDFLAGS = -m32

.PHONY: all clean

all: postfix-eval

postfix-eval: postfix-eval.o macro.o

postfix-eval.o: postfix-eval.asm
	$(ASM) -I/usr/share/sasm/include/ -f elf32 -o $@ $<

macro.o: /usr/share/sasm/NASM/macro.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	-rm -f *~
	-rm -f postfix-eval.o postfix-eval
