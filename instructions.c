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

void afficher_instructions(void){
    int i;
    for (i = 0; i<nb_instructions;i++){
        printf("%d %d %d %d\n",table_instructions[i][0],table_instructions[i][1],table_instructions[i][2],table_instructions[i][3]);
    }
}

void creer_fichier(void){
    FILE * fPt1, * fPt2;
    
    fPt1 = fopen("./instructions.txt", "w");
    fPt2 = fopen("./instructions_text.txt", "w");
    int i;
    for (i = 0; i<nb_instructions; i++) {
        fprintf(fPt1,"%x %d %d %d\n",table_instructions[i][0],table_instructions[i][1],table_instructions[i][2],table_instructions[i][3]);
        fprintf(fPt2,"%s %d %d %d\n",nom_instructions[table_instructions[i][0]],table_instructions[i][1],table_instructions[i][2],table_instructions[i][3]);
    }

    fclose(fPt1);
    fclose(fPt2);


}
