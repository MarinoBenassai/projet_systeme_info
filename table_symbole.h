#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

struct variable {
    char * id;
    char * type;
    int init;
};

struct variable * table_symboles;
int nb_variables = 0;
int num_temp = 0;

void ajouter_variable (char * id, char * type, int init);
void afficher_table(void);
int adresse(char * id);
void initialiser_variable (char * id);

