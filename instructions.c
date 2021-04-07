#include "instructions.h"

void ajouter_instruction (int code, int adresse1, int adresse2, int adresse3 ){
    table_instructions = realloc(table_instructions,(nb_instructions + 1) * 4 * sizeof(int));
    int instruction[] = {code,adresse1,adresse2,adresse3};
    table_instructions[nb_instructions] = instruction;
    nb_instructions += 1;
}

void afficher_instructions(void){
    int i;
    for (i = 0; i<nb_instructions;i++){
        printf("%d %d %d %d\n",table_instructions[i][0],table_instructions[i][1],table_instructions[i][2],table_instructions[i][3]);
    }
}
