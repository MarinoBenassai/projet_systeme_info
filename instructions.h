int * * table_instructions;
int nb_instructions = 0;
char * nom_instructions[] = {"","ADD","MUL","SOU", "DIV", "COP", "AFC", "JMP", "JMF", "INF", "SUP", "EQU", "PRI","DEG","DED"};
int * pile_if;
int nb_if = 0;
int * pile_else;
int nb_else = 0;
int * pile_while;
int nb_while = 0;



void ajouter_instruction (int code, int adresse1, int adresse2, int adresse3 );
void afficher_instructions(void);
