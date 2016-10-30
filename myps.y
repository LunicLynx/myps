%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
int yylex(void);
void yyerror(char *);
%}

%union {
    char* name;
    char* sVal;
    int iVal;
    double dVal;
}

%token INT NUM STRING POINT PATH TERM
%token VAR
%token FOR TO STEP DO DONE 
%token LPAREN RPAREN LBRACE RBRACE COMMA COLON SEMICOLON
%token PICTURE START END  
%token OP_ASSIGN OP_BIND
%token OP_PLUS OP_MINUS OP_STAR OP_DIV OP_MOD
%token IDENTIFIER
%token COMMENT
%token INTEGER_LITERAL STRING_LITERAL REAL_LITERAL
%token PBEGIN PEND

%left OP_PLUS OP_MINUS
%left OP_STAR OP_DIV OP_MOD

%start program

%%

program
    : PICTURE STRING_LITERAL decls START commands END { printf("Akzeptiert\n"); }
    ;

decls
    : decl             
    | decls decl       
    ;

decl
    : VAR IDENTIFIER COLON type SEMICOLON 

type
    : INT 
    | NUM 
    | STRING 
    | POINT 
    | PATH 
    | TERM
    ;

commands
    : command          
    | commands command 
    ;

command
    : SEMICOLON 
    | stmt SEMICOLON
    ;

stmt
    : assign
    | bind
    | call
    | for
    | IDENTIFIER
    ;

for
    : FOR assign TO INTEGER_LITERAL STEP INTEGER_LITERAL DO commands DONE
    ;

assign
    : IDENTIFIER OP_ASSIGN expr
    ;

bind
    : IDENTIFIER OP_BIND expr
    ;

call
    : IDENTIFIER LPAREN expr_list RPAREN
    ;

expr_list
    : expr
    | expr_list COMMA expr
    ;

expr: literal 
    | PBEGIN expr_list PEND
    | IDENTIFIER 
    | call
    | expr OP_PLUS expr
    | expr OP_MINUS expr 
    | expr OP_STAR expr 
    | expr OP_DIV expr
    | expr OP_MOD expr  
    | block 
    | LPAREN expr RPAREN 
    | LPAREN IDENTIFIER COMMA expr RPAREN
    ;

block
    : LBRACE commands RBRACE
    ;

literal
    : point_literal
    | number_literal 
    | STRING_LITERAL
    ;

point_literal
    : LPAREN number_literal COMMA number_literal RPAREN
    ;

number_literal
    : INTEGER_LITERAL 
    | REAL_LITERAL
    ;


%%

void yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
}

int main(void){
    yyparse();
    return 0;
}