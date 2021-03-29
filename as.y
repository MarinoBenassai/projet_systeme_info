%{
#include <stdio.h>
#include <stdlib.h>
#include "table_symbole.c"
%}
%token tMAIN tCONST tINT tPRINT tEQ tPO tPF tAO tAF tPV tV tIF tAND tOR tEQ2 tDIFF tSUP tINF tNOT tWHILE
%left tPLUS tMINUS
%left tMUL tDIV

%union {
    char * str;
    int nb;
}

%token <nb> tNB
%token <str> tID


%%

C : tINT tMAIN tPO tPF Body {afficher_table();}
;
Body : tAO Instructions tAF
;
Instructions : Instruction Instructions | 
;
Instruction : Aff | Decl | Print | If | While;
;
Aff : tID tEQ E tPV {initialiser_variable($1);}
;
E : tNB
| tID 
| E tPLUS E 
| E tMUL E 
| E tMINUS E 
| E tDIV E 
| tPO E tPF 
| tMINUS E %prec tMUL
;
Decl : tINT tIDs tPV 
|tCONST tINT tIDs tPV
;
tIDs : tID tV tIDs {ajouter_variable ($1, "int", 0);}
|tID tEQ E tV tIDs {ajouter_variable ($1, "int", 1);}
|tID {ajouter_variable ($1, "int", 0);}
|tID tEQ E {ajouter_variable ($1, "int", 1);}
;
Print : tPRINT tPO tID tPF tPV
|tPRINT tPO tNB tPF tPV
;

If : tIF tPO Cond tPF Body ;

Cond : Cond tAND Cond | Cond tOR Cond | E tEQ2 E | E tDIFF E | E tSUP E | E tINF E | tNOT Cond ;

While : tWHILE tPO Cond tPF Body
; 

%%

int main(){return yyparse();}

int yyerror(char *s){ fprintf(stderr, "%s\n", s) ; return 1; }


