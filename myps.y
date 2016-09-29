%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);
%}

%token INTEGER, REAL, IDENTIFIER, 
LPAREN, RPAREN, LBRACE, RBRACE, VAR, COMMA, COMMENT,
PICTURE, START, END, SEMICOLON, OP_ASSIGN, OP_BIND, OP_PLUS, OP_MINUS,
OP_STAR, OP_DIV, OP_MOD,
STRING, NUMBER, POINT, PATH, TERM,
INTEGER_LITERAL, STRING_LITERAL, REAL_LITERAL

%%

p:;

%%

void yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
}

int main(void){
    yyparse();
    return 0;
}