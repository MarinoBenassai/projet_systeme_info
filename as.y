%{
#include <stdio.h>
#include <stdlib.h>
#include "table_symbole.c"
#include "instructions.c"

%}
%token tMAIN tCONST tINT tPRINT tEQ tPO tPF tAO tAF tPV tV tIF tAND tOR tEQ2 tDIFF tSUP tINF tNOT tWHILE
%left tOR
%left tAND
%left tEQ2
%left tPLUS tMINUS
%left tMUL tDIV

%union {
    char * str;
    int nb;
}

%token <nb> tNB
%token <str> tID
%type <str> E
%type <str> Cond

%%

C : tINT tMAIN tPO tPF Body {creer_fichier(); afficher_table();afficher_instructions();}
;
Body : tAO Instructions tAF
;
Instructions : Instruction Instructions | 
;
Instruction : Aff | Decl | Print | If | While;
;
Aff : tID tEQ E tPV {initialiser_variable($1); ajouter_instruction(5,adresse($1),adresse($3),-1); supprimer_temp();}
;
E : tNB {char * temp = ajouter_temp(); ajouter_instruction(6,adresse(temp),$1,-1); $$ = temp; printf("%s = %d\n",temp,$1);}
| tID {char * temp = ajouter_temp(); ajouter_instruction(5,adresse(temp),adresse($1),-1); $$ = temp; printf("%s = %s\n",temp,$1);}
| E tPLUS E {ajouter_instruction(1, adresse($1), adresse($3), adresse($1)); supprimer_temp(); $$ = $1; printf("PLUS\n");}
| E tMUL E {ajouter_instruction(2, adresse($1), adresse($3), adresse($1)); supprimer_temp(); $$ = $1; printf("MUL\n");}
| E tMINUS E {ajouter_instruction(3, adresse($1), adresse($1), adresse($3)); supprimer_temp(); $$ = $1; printf("MINUS\n");}
| E tDIV E {ajouter_instruction(4, adresse($1), adresse($1), adresse($3)); supprimer_temp(); $$ = $1; printf("DIV\n");}
| tPO E tPF {$$ = $2;}
| tMINUS E %prec tMUL {char * temp = ajouter_temp(); ajouter_instruction(6,adresse(temp),0,-1); ajouter_instruction(3,adresse($2),adresse(temp),adresse($2)); supprimer_temp(); $$ = $2; printf("INV\n");}
;
Decl : tINT tIDs tPV
|tCONST tINT tIDs tPV
;
tIDs : ID_declaration tV tIDs 
      |ID_declaration
;


ID_declaration : tID {ajouter_variable ($1, "int", 0);}
                | tID tEQ E {supprimer_temp(); ajouter_variable ($1, "int", 1);};



Print : tPRINT tPO tID tPF tPV {ajouter_instruction(12,adresse($3),-1,-1);}
|tPRINT tPO tNB tPF tPV {}
;

If : tIF tPO Cond tPF {empile_if(); ajouter_instruction(8, adresse($3), -1, -1);} Body {int tmp = depile_if(); patch_table(tmp);};

Cond : Cond tAND Cond {ajouter_instruction(2, adresse($1), adresse($3), adresse($1)); supprimer_temp(); $$ = $1; printf("AND\n");}
| Cond tOR Cond {ajouter_instruction(1, adresse($1), adresse($3), adresse($1));
                 supprimer_temp();
                 char * temp = ajouter_temp();
                 ajouter_instruction(6,adresse(temp),0,-1);
                 ajouter_instruction(10,adresse($1),adresse(temp),adresse($1));
                 $$ = $1; printf("OR\n");}
| E tEQ2 E {ajouter_instruction(11, adresse($1), adresse($3), adresse($1)); supprimer_temp(); $$ = $1; printf("EQU\n");}
| E tDIFF E {ajouter_instruction(11, adresse($1), adresse($3), adresse($1));
             supprimer_temp();
             char * temp = ajouter_temp();
             ajouter_instruction(6,adresse(temp),0,-1);
             ajouter_instruction(11,adresse($1),adresse(temp),adresse($1));
             supprimer_temp();
             $$ = $1;printf("DIFF\n");}
| E tSUP E {ajouter_instruction(10, adresse($1), adresse($1), adresse($3)); supprimer_temp(); $$ = $1; printf("SUP\n");}
| E tINF E {ajouter_instruction(9, adresse($1), adresse($1), adresse($3)); supprimer_temp(); $$ = $1; printf("INF\n");}
| tNOT Cond %prec tAND {char * temp = ajouter_temp(); ajouter_instruction(6,adresse(temp),0,-1); ajouter_instruction(11,adresse($2),adresse(temp),adresse($2)); supprimer_temp(); $$ = $2; printf("NOT\n");}
| E {char * temp = ajouter_temp();
     ajouter_instruction(6,adresse(temp),0,-1);
     ajouter_instruction(11,adresse($1),adresse(temp),adresse($1));
     supprimer_temp();
     char * temp2 = ajouter_temp();
     ajouter_instruction(6,adresse(temp2),0,-1);
     ajouter_instruction(11,adresse($1),adresse(temp2),adresse($1));
     supprimer_temp();
     $$ = $1;printf("EXPR\n");}
| tPO Cond tPF {$$ = $2;}; 

While : tWHILE tPO Cond tPF Body
; 

%%

int main(){return yyparse();}

int yyerror(char *s){ fprintf(stderr, "%s\n", s) ; return 1; }


