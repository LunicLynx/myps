%{


#define LPAREN 10001

#include "y.tab.h"
%}

/* comment */
comment        %.*

/* operators */
assign         :=
bind           -\>
plus           \+
minus          \-
multi          \*
divide         \/
modulo         mod
lparen         \(
rparen         \)
lbrace         \{
rbrace         \}
semicolon      ;

/* keywords */
var            var
int_type       Int
num_type       Num
string_type    String
point_type     Point
path_type      Path
term_type      Term

/* indetifier */
identifier     [a-zA-Z][a-zA-Z0-9]*

/* numbers */
real           [+-]?[0-9]+\.[0-9]+?(E[+-]?[0-9]+)?
integer        [+-]?[0-9]+
string         \"[^\"]*\"

/* whitespace */
ws             [ \t\n]+

%%

{lparen}              {printf("asd"); yylval= 14; return (LPAREN);}
{ws}                  ;
{integer}             printf("INTEGER");
{real}                printf("REAL");
.                     return(yytext[0]);

%%

int yywrap(void) {
 return 1;
}