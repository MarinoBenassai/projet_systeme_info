%{
#include "as.tab.h"

int num_line = 1;
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
else	{return tELSE;}
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
"\n"	{num_line += 1;}
[ \t]    {}
","    {return tV;}
";"    {return tPV;}
{CHIFFRE}+([eE]{CHIFFRE}+)?    {yylval.nb = (int) atof(yytext);return tNB;}
{LETTRE}({CHIFFRE}|{LETTRE}|_)*    {yylval.str = malloc(yyleng*sizeof(char)); strcpy(yylval.str, yytext); return tID;}
"&"	{return tREF;}
. {fprintf(stderr, "Erreur ligne %d: Symbole inconnu: %s.\n",num_line,yytext);exit(1);}

%%

int yywrap(){return 1;}
//int main(){yylex(); return 0;}


