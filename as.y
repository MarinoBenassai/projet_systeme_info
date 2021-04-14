%{
#include <stdio.h>
#include <stdlib.h>
#include "table_symbole.c"
#include "instructions.c"

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
%type <str> E

%%

C : tINT tMAIN tPO tPF Body {creer_fichier(); afficher_table();afficher_instructions();}
;
Body : tAO Instructions tAF
;
Instructions : Instruction Instructions | 
;
Instruction : Aff | Decl | Print | If | While;
;
Aff : tID tEQ E tPV {initialiser_variable($1);}
;
E : tNB {char * temp = ajouter_temp(); ajouter_instruction(6,adresse(temp),$1,-1); $$ = temp; printf("%s = %d\n",temp,$1);}
| tID {char * temp = ajouter_temp(); ajouter_instruction(5,adresse(temp),adresse($1),-1); $$ = temp; printf("%s = %s\n",temp,$1);}
| E tPLUS E {ajouter_instruction(1, adresse($1), adresse($3), adresse($1)); supprimer_temp(); $$ = $1; printf("PLUS\n");}
| E tMUL E {ajouter_instruction(2, adresse($1), adresse($3), adresse($1)); supprimer_temp(); $$ = $1; printf("MUL\n");}
| E tMINUS E {ajouter_instruction(3, adresse($1), adresse($3), adresse($1)); supprimer_temp(); $$ = $1; printf("MINUS\n");}
| E tDIV E {ajouter_instruction(4, adresse($1), adresse($3), adresse($1)); supprimer_temp(); $$ = $1; printf("DIV\n");}
| tPO E tPF {$$ = $2;}
| tMINUS E %prec tMUL {char * temp = ajouter_temp(); ajouter_instruction(6,adresse(temp),0,-1); ajouter_instruction(3,adresse($2),adresse(temp),adresse($2)); supprimer_temp(); $$ = temp; printf("INV\n");}
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


