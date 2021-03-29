#include "table_symbole.h"

void ajouter_variable (char * id, char * type, int init) {
    table_symboles = realloc(table_symboles,(nb_variables + 1) * sizeof(struct variable));
    table_symboles[nb_variables].id = id;
    table_symboles[nb_variables].type = type;
    table_symboles[nb_variables].init = init;
    nb_variables += 1;
}

void afficher_table(void){
    int i;
    for (i = 0; i<nb_variables;i++){
        printf("%s %s %d\n",table_symboles[i].id,table_symboles[i].type,table_symboles[i].init);
    }
}

void initialiser_variable (char * id) {
    int i = 0;
    while (i < nb_variables && !strcmp(table_symboles[i].id,id)){
        i++;
    }
    if (i == nb_variables){
        printf("Erreur: la variable %s n'existe pas\n",id);
    }
    else {
        printf("Variable %s trouvée\n",id);
        printf("Val %d\n",table_symboles[i].init);
        table_symboles[i].init = 1;
        printf("Val %d\n",table_symboles[i].init);
    }
}
