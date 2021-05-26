#include "table_symbole.h"

extern int num_line;

void ajouter_variable (char * id, char * type, int init) {
    table_symboles = realloc(table_symboles,(nb_variables + 1) * sizeof(struct variable));
    table_symboles[nb_variables].id = id;
    table_symboles[nb_variables].type = type;
    table_symboles[nb_variables].init = init;
    nb_variables += 1;
}

void afficher_table(void){
    /*int i;
    printf("\n------------------------\n");
    printf("nb_variables = %d\n",nb_variables);
    for (i = 0; i<nb_variables;i++){
        printf("%s %s %d\n",table_symboles[i].id,table_symboles[i].type,table_symboles[i].init);
    }
    printf("------------------------\n");*/
}

int adresse(char * id){
    afficher_table();

    int i = 0;
    while (i < nb_variables && strcmp(table_symboles[i].id,id)){
        i++;
    }
    if (i == nb_variables){
        fprintf(stderr, "Erreur ligne %d: la variable %s n'existe pas\n",num_line,id);
        exit(1);
    }
    else{
        return i;
    }
}

char * nom_var (int adresse){
   if (adresse < 0 || adresse >= nb_variables){
      fprintf(stderr, "Erreur ligne %d: l'adresse %d est invalide.\n",num_line,adresse);
      exit(1);
   }
   else{
      return table_symboles[nb_variables].id;
   }
}

void initialiser_variable (char * id) {
    int i = 0;
    while (i < nb_variables && !strcmp(table_symboles[i].id,id)){
        i++;
    }
    if (i == nb_variables){
        fprintf(stderr, "Erreur ligne %d: la variable %s n'existe pas\n",num_line,id);
        exit(1);
    }
    else {
        printf("Variable %s trouvée\n",id);
        printf("Val %d\n",table_symboles[i].init);
        table_symboles[i].init = 1;
        printf("Val %d\n",table_symboles[i].init);
    }
}

char * ajouter_temp(){
    printf("Ajout temp\n");
    char * id = malloc(sizeof(char) * (4 + 12 + 1));
    sprintf(id, "%d", num_temp);
    strcat(id,"temp");
    ajouter_variable (id, "int", 1);
    num_temp += 1;
    afficher_table();
    return id;
}

void supprimer_temp(){
    printf("Supression temp\n");
    nb_variables -= 1;
}


