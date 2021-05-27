%{
#include <stdio.h>
#include <stdlib.h>
#include "table_symbole.c"
#include "instructions.c"

extern int num_line;

%}
%token tMAIN tCONST tINT tPRINT tEQ tPO tPF tAO tAF tPV tV tIF tAND tOR tEQ2 tDIFF tSUP tINF tNOT tWHILE tELSE tREF
%left tOR
%left tAND
%left tEQ2
%left tPLUS tMINUS
%left tMUL tDIV
%left tREF
%left tNOT

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
Body : tAO {empile_etat_tab_var();} Instructions {depile_etat_tab_var();} tAF
;
Instructions : Instruction Instructions | 
;
Instruction : Aff | Decl | Print | If | While;
;
Aff : tID tEQ E tPV {ajouter_instruction(5,adresse($1),adresse($3),-1); supprimer_temp();}
|tMUL E tEQ E tPV {ajouter_instruction(13,adresse($2),adresse($4),-1);supprimer_temp();supprimer_temp();}
;

E : tNB {char * temp = ajouter_temp(); ajouter_instruction(6,adresse(temp),$1,-1); $$ = temp; printf("%s = %d\n",temp,$1);}
| tID {char * temp = ajouter_temp(); ajouter_instruction(5,adresse(temp),adresse($1),-1); $$ = temp; printf("%s = %s\n",temp,$1);}
| E tPLUS E {ajouter_instruction(1, adresse($1), adresse($3), adresse($1)); supprimer_temp(); $$ = $1; printf("PLUS\n");}
| E tMUL E {ajouter_instruction(2, adresse($1), adresse($3), adresse($1)); supprimer_temp(); $$ = $1; printf("MUL\n");}
| E tMINUS E {ajouter_instruction(3, adresse($1), adresse($1), adresse($3)); supprimer_temp(); $$ = $1; printf("MINUS\n");}
| E tDIV E {ajouter_instruction(4, adresse($1), adresse($1), adresse($3)); supprimer_temp(); $$ = $1; printf("DIV\n");}
| tPO E tPF {$$ = $2;}
| tMINUS E %prec tREF {char * temp = ajouter_temp(); ajouter_instruction(6,adresse(temp),0,-1); ajouter_instruction(3,adresse($2),adresse(temp),adresse($2)); supprimer_temp(); $$ = $2; printf("INV\n");}
| tMUL E %prec tREF {ajouter_instruction(14,adresse($2),adresse($2),-1);$$ = $2; printf("DEREF\n");}
| tREF tID {char * temp = ajouter_temp(); ajouter_instruction(6,adresse(temp),adresse($2),-1); $$ = temp; printf("%s = %d\n",temp,adresse($2));printf("REF\n");}
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

If : tIF tPO Cond tPF {empile_if(); ajouter_instruction(8, adresse($3), -1, -1);supprimer_temp();} Body_if;


Body_if : Body {int tmp = depile_if(); patch_table(tmp,2);}
| Body tELSE {empile_else(); ajouter_instruction(7, -1, -1, -1); int tmp = depile_if(); patch_table(tmp,2);} Body {int tmp = depile_else(); patch_table(tmp,1);};

Cond : Cond tAND {printf("tAND\n");} Cond {ajouter_instruction(2, adresse($1), adresse($4), adresse($1)); supprimer_temp(); $$ = $1; printf("AND\n");}
| Cond tOR Cond {ajouter_instruction(1, adresse($1), adresse($3), adresse($1));
                 supprimer_temp();
                 char * temp = ajouter_temp();
                 ajouter_instruction(6,adresse(temp),0,-1);
                 ajouter_instruction(10,adresse($1),adresse($1),adresse(temp));
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
| tNOT Cond {char * temp = ajouter_temp(); ajouter_instruction(6,adresse(temp),0,-1); ajouter_instruction(11,adresse($2),adresse(temp),adresse($2)); supprimer_temp(); $$ = $2; printf("NOT\n");}
/*| E {char * temp = ajouter_temp();
     ajouter_instruction(6,adresse(temp),0,-1);
     ajouter_instruction(11,adresse($1),adresse(temp),adresse($1));
     supprimer_temp();
     char * temp2 = ajouter_temp();
     ajouter_instruction(6,adresse(temp2),0,-1);
     ajouter_instruction(11,adresse($1),adresse(temp2),adresse($1));
     supprimer_temp();
     $$ = $1;printf("EXPR\n");}*/
| tPO Cond tPF {$$ = $2;}
; 

While : tWHILE {empile_while();} tPO Cond tPF {empile_while(); ajouter_instruction(8,adresse($4),-1,-1);supprimer_temp();} Body {int tmp1 = depile_while(); int tmp2 = depile_while(); ajouter_instruction(7,tmp2,-1,-1); patch_table(tmp1,2);}; 

%%

int main(){return yyparse();}

int yyerror(char *s){ fprintf(stderr, "Erreur ligne %d: %s;\n",num_line, s) ; return 1; }


