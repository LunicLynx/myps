%{
#include "myps.tab.h"
void yyerror(char *);
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

"("                       return LPAREN;
")"                       return RPAREN;
"{"                       return LBRACE;
"}"                       return RBRACE;
"<<"                      return PBEGIN;
">>"                      return PEND; 
","                       return COMMA;
":"                       return COLON;
";"                       return SEMICOLON;
"+"                       return OP_PLUS;
"-"                       return OP_MINUS;
"*"                       return OP_STAR;
"/"                       return OP_DIV;
":="                      return OP_ASSIGN;
"<-"                      return OP_BIND;
"mod"                     return OP_MOD;

"for"                     return FOR;
"to"                      return TO;
"step"                    return STEP;
"do"                      return DO;
"done"                    return DONE;

"Num"                     return NUM;
"Int"                     return INT;
"String"                  return STRING;
"Point"                   return POINT;
"Path"                    return PATH;
"Term"                    return TERM;

"var"                     return VAR;
"picture"                 return PICTURE;
"start"                   return START;
"end"                     return END;

{identifier}    {
        yylval.name = yytext;
        return IDENTIFIER;
    }

{sign}?{digits}"."{digits}?(E{sign}?{digits})?     {
        yylval.dVal = atof(yytext);
        return REAL_LITERAL;
    }

{sign}?{digits}               {
        yylval.iVal = atoi(yytext);
        return INTEGER_LITERAL;
    }

\"{str}\"    {             
        yylval.sVal = yytext;   
        return STRING_LITERAL;
    }

\%.*                      ; 

.                         yyerror("Unknown character");

%%

int yywrap(void) {
 return 1;
}