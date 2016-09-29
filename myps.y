%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
int yylex(void);
void yyerror(char *);
%}

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

%left OP_PLUS OP_MINUS
%left OP_STAR OP_DIV OP_MOD

%%

program: PICTURE STRING_LITERAL decls START commands END { exit(0);}
       ;

decls: decl             
     | decls decl       
     ;

decl: VAR IDENTIFIER COLON type SEMICOLON 

type: INT | NUM | STRING | POINT | PATH | TERM;

commands: command          
        | commands command 
        ;

command: SEMICOLON 
       | assign SEMICOLON
       | bind SEMICOLON
       | call SEMICOLON
       | for SEMICOLON
       ;

for: FOR assign TO INTEGER_LITERAL STEP INTEGER_LITERAL DO commands DONE;

assign: IDENTIFIER OP_ASSIGN expr;

bind: IDENTIFIER OP_BIND expr;

call: IDENTIFIER LPAREN args RPAREN

args: arg
    | args COMMA arg
    ;

arg: expr; 

expr: literal 
    | IDENTIFIER 
    | expr OP_PLUS expr
    | expr OP_MINUS expr
    | expr OP_STAR expr
    | expr OP_DIV expr
    | expr OP_MOD expr  
    | block 
    | LPAREN expr RPAREN 
    ;

block: LBRACE commands RBRACE;


literal: INTEGER_LITERAL | REAL_LITERAL | STRING_LITERAL;

%%

void yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
}

int main(void){
    yyparse();
    return 0;
}