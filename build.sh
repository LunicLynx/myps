#!/bin/bash

yacc -d ./myps.y
lex ./myps.l
cc ./lex.yy.c ./y.tab.c
./a.out < ./input.myps