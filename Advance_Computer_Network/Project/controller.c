#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define MAX_NODES 10
#define MESSAGE_SIZE 256
#define TOPOLOGY_FILE "topology"

int topology[MAX_NODES][MAX_NODES];
long last_read_positions[MAX_NODES] = {0};

//loading the topo file
void load_topology() {
  FILE *file = fopen(TOPOLOGY_FILE, "r");
  char ch;
  if (file == NULL) {
	perror("Error opening topology file");
	exit(EXIT_FAILURE);
	}
	memset(topology, 0, sizeof(topology));
	//printf("file content of %s\n",TOPOLOGY_FILE);
	//while((ch=fgetc(file))!=EOF){
	//	putchar(ch);

	//}
        //Creating an adjacency matrix of 10x10 from --> to unidirectional link
	int from, to;
	while (fscanf(file, "%d %d", &from, &to) != EOF) {
	topology[from][to] = 1;
	}
	fclose(file);
	}

//printing the Adjacency matrix
void print_matrix(){
   printf("Adjacency Matrix:\n");
   int k;
   for(k=0;k<MAX_NODES;k++){
   	int j;
	for(j=0;j<MAX_NODES;j++){
		printf("%d ",topology[k][j]);
	}
	printf("\n");
	}
}

	
void forward_messages() {
  int from;
  for (from = 0; from < MAX_NODES; from++) {
  	char input_file[20];
	sprintf(input_file, "output_%d", from);
	FILE *input = fopen(input_file, "r");
	if (input == NULL) 
	{
		//printf("Opened the output file: %s but it is NULL\n", input_file);
		continue;
	}
       fseek(input, last_read_positions[from], SEEK_SET);
       char buffer[MESSAGE_SIZE];
       while (fgets(buffer, MESSAGE_SIZE, input)) {
       		char type[20];
		int to;
		sscanf(buffer,"%s",type);
		//Handle regular messages(hello, dvector, in-distance
		if(strcmp(type, "hello")==0 || strcmp(type,"dvector")==0 || strcmp(type, "in-distance")==0){

		for (to = 0; to < MAX_NODES; to++) {
		     if (topology[from][to]) {				                        
	             	//printf("Forwarding from %d to %d\n",from,to);
			char output_file[20];
                        sprintf(output_file, "input_%d", to);
                        FILE *output =fopen(output_file, "a");
			if(output == NULL){
				perror("Error opening output file");
				//printf("Failed to open file: %s\n", output_file);
				continue;
		 	}
			fprintf(output, "%s",buffer);
			fclose(output);
			}
	             else{
		     	//printf("No link from %d to %d in topology.\n", from, to);
		     }
		   }
	          }
		  //Handle join message
		  else if(strcmp(type, "join")==0){
			int sender_id,source_id,parent_id,next_node;
			if(sscanf(buffer, "join %d %d %d %d",&sender_id,&source_id,&parent_id, &next_node)==4){
				if(next_node!=-1){
				char output_file[20];
				sprintf(output_file, "input_%d", next_node);
				FILE *output = fopen(output_file, "a");
				if (output == NULL) {
					perror("Error opening output file");
					continue;

				}
				fprintf(output, "%s", buffer);
				fclose(output);

				}}

			}
			//Handle data messages
			else if (strcmp(type, "data") == 0) {
				char message[256];
				int sender_id,source_id;
				if(sscanf(buffer, "data %d %d %[^\n]",&sender_id,&source_id,message)==3){
				//int to;
				//for (to = 0; to < MAX_NODES; to++) {
					//if (topology[from][to]) {
					if(sender_id!=-1){
						char output_file[20];
						sprintf(output_file, "input_%d", sender_id);

						FILE *output = fopen(output_file, "a");
						if (output == NULL) {
							perror("Error opening output file");

							continue;
						}
						fprintf(output, "%s",buffer);
						fclose(output);
						}
					}
			
			}
		}

		
	last_read_positions[from]=ftell(input);
	fclose(input);
	}
}




int main (int argc, char *argv[]){
   if (argc < 2) {
   	fprintf(stderr, "Usage: %s <duration>\n", argv[0]);
	exit(EXIT_FAILURE);
	}
   int duration = atoi(argv[1]);
   load_topology();
   //print_matrix();
   int i;
   for (i = 0; i < duration; i++) {
	forward_messages(); 
        sleep(1);
   }
   return 0;
}
