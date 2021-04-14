int * * table_instructions;
int nb_instructions;
char * nom_instructions[] = {"","ADD","MUL","SOU", "DIV", "COP", "AFC", "JMP", "JMF", "INF", "SUP", "EQU", "PRI"};

void ajouter_instruction (int code, int adresse1, int adresse2, int adresse3 );
void afficher_instructions(void);
