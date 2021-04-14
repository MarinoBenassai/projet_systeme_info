all : as.tab.c lex.yy.o
	gcc lex.yy.o as.tab.c -Wall -o executable

lex.yy.o : lex.yy.c
	gcc -c lex.yy.c -Wall

lex.yy.c : al.l
	flex al.l

as.tab.c : as.y
	bison -d -v as.y

clean :
	rm *.yy.c
	rm *.tab.c
	rm *.tab.h
	rm *.o

