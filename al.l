%{
#include "as.tab.h"
%}

CHIFFRE [0-9]
LETTRE [a-zA-Z]
BLANC[  \n]

%%

main    {return tMAIN;}
const    {return tCONST;}
int    {return tINT;}
printf    {return tPRINT;}
if      {return tIF;}
while       {return tWHILE;}
&&        {return tAND;}
"||"      {return tOR;}
==     {return tEQ2;}
!=      {return tDIFF;}
"<"       {return tINF;}
">"       {return tSUP;}
!       {return tNOT;}
"+"    {return tPLUS;}
"-"    {return tMINUS;}
"*"   {return tMUL;}
"/"    {return tDIV;}
"="    {return tEQ;}
"("    {return tPO;}
")"    {return tPF;}
"{"    {return tAO;}
"}"    {return tAF;}
[   \n]    {}
","    {return tV;}
";"    {return tPV;}
{CHIFFRE}+([eE]{CHIFFRE}+)?    {yylval.nb = (int) atof(yytext);return tNB;}
{LETTRE}({CHIFFRE}|{LETTRE}|_)*    {yylval.str = malloc(yyleng*sizeof(char)); strcpy(yylval.str, yytext); return tID;}


%%

int yywrap(){return 1;}
//int main(){yylex(); return 0;}


