#include "instructions.h"

void ajouter_instruction (int code, int adresse1, int adresse2, int adresse3 ){
    table_instructions = realloc(table_instructions,(nb_instructions + 1) * 4 * sizeof(int));
    int * instruction = malloc(4 * sizeof(int));
    instruction[0] = code;
    instruction[1] = adresse1;
    instruction[2] = adresse2;
    instruction[3] = adresse3;
    table_instructions[nb_instructions] = instruction;
    nb_instructions += 1;
}

void empile_if (void){
    pile_if = realloc(pile_if,(nb_if + 1) * sizeof(int));
    pile_if[nb_if] = nb_instructions;
    nb_if += 1;
    printf("IF empile\n");
}

int depile_if (void){
    nb_if -= 1;
    printf("IF depile\n");
    return pile_if[nb_if];
}

void patch_table(int adresse_if){
    table_instructions[adresse_if][2] = nb_instructions;
    printf("Table patchee\n");
}


void afficher_instructions(void){
    int i;
    for (i = 0; i<nb_instructions;i++){
        printf("%d %d %d %d\n",table_instructions[i][0],table_instructions[i][1],table_instructions[i][2],table_instructions[i][3]);
    }
}

void creer_fichier(void){
    FILE * fPt1, * fPt2;
    
    fPt1 = fopen("./instructions.txt", "w");
    fPt2 = fopen("./interpreter/input.txt", "w");
    int i;
    for (i = 0; i<nb_instructions; i++) {
        fprintf(fPt1,"%x %d",table_instructions[i][0],table_instructions[i][1]);
        fprintf(fPt2,"%s %d",nom_instructions[table_instructions[i][0]],table_instructions[i][1]);
        if (table_instructions[i][2] != -1) {
            fprintf(fPt1," %d",table_instructions[i][2]);
            fprintf(fPt2," %d",table_instructions[i][2]);
        }
        if (table_instructions[i][3] != -1) {
            fprintf(fPt1," %d",table_instructions[i][3]);
            fprintf(fPt2," %d",table_instructions[i][3]);
        }
        fprintf(fPt1,"\n");
        fprintf(fPt2,"\n");
    }

    fclose(fPt1);
    fclose(fPt2);


}
