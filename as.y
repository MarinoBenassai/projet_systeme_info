%{
#include <stdio.h>

string * variables_declares[] = [];
int adresses[] = [];

%}

%token tMAIN tCONST tINT tPRINT tEQ tPO tPF tAO tAF tPV tNB tID tV tIF tAND tOR tEQ2 tDIFF tSUP tINF tNOT tWHILE
%left tPLUS tMINUS
%left tMUL tDIV


%%

C : tINT tMAIN tPO tPF Body
;
Body : tAO Instructions tAF {printf("%d\n", test);}
;
Instructions : Instruction Instructions | 
;
Instruction : Aff | Decl | Print | If | While;
;
Aff : tID tEQ E tPV
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
Decl : tINT tIDs tEQ E tPV 
|tCONST tINT tIDs tEQ E tPV
|tINT tIDs tPV
|tCONST tINT tIDs tPV
{}
;
tIDs : tID tV tIDs
|tID
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


