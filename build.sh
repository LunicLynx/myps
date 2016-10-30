#!/bin/bash

#yacc -y -d -t -v ./myps.y
#lex -d -v ./myps.l

bison -d ./myps.y
lex ./myps.l

g++ -o myps ./lex.yy.c ./myps.tab.c
./myps < ./input.myps