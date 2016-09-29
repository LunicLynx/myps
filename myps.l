%{
#include "y.tab.h"
%}

digit                     [0-9]
digits                    [0-9]+

letter                    [a-zA-Z]
letters                   [a-zA-Z]+

identifier                [a-zA-Z][a-zA-Z0-9]*

sign                      [+-]

ws                        [ \t\n\r]+

str                       [^\"]*

%%

{ws}                      ;

"("                         return LPAREN;
")"                         return RPAREN;
"{"                         return LBRACE;
"}"                         return RBRACE;
","                         return COMMA;
":"                         return COLON;
";"                         return SEMICOLON;
"+"                        return OP_PLUS;
"-"                         return OP_MINUS;
"*"                         return OP_STAR;
"/"                         return OP_DIV;
":="                        return OP_ASSIGN;
"<-"                        return OP_BIND;
"mod"                       return OP_MOD;

"for"                       return FOR;
"to"                        return TO;
"step"                      return STEP;
"do"                        return DO;
"done"                      return DONE;

"Num"                       return NUM;
"Int"                       return INT;
"String"                    return STRING;
"Point"                     return POINT;
"Path"                      return PATH;
"Term"                      return TERM;

"var"                       return VAR;
"picture"                   return PICTURE;
"start"                     return START;
"end"                       return END;

{identifier}              return IDENTIFIER;

{sign}?{digits}"."{digits}?(E{sign}?{digits})? return REAL_LITERAL;
{sign}?{digits}           return INTEGER_LITERAL;
\"{str}\"                return STRING_LITERAL;

\%.*                      ; 

.                         yyerror("Unknown character");

%%

int yywrap(void) {
 return 1;
}