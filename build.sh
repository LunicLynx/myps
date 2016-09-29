#!/bin/bash

yacc -y -d -t -v ./myps.y
lex -d -v ./myps.l
cc ./lex.yy.c ./y.tab.c
./a.out < ./input.myps