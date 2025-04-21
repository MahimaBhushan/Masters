#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>

#define MAX_NODES 10
#define MESSAGE_SIZE 256
#define MAX_NODES 10
#define BUFFER_SIZE 256	
#define INFINITY -1
#define MAX_CHILDREN 10

int incoming_neighbors[MAX_NODES]; // Array to track incoming neighbors
int timestamps[MAX_NODES];         // Array to track the last hello message time
int routing_table[MAX_NODES];  //Distance to all nodes
int in_distance[MAX_NODES];   //Distance from all nodes
int next_hop[MAX_NODES];      //Next hop for each destination
int neighbor_indistances_dvec[MAX_NODES][MAX_NODES];
int multicast_parent[MAX_NODES];
int children[MAX_CHILDREN][MAX_CHILDREN];
time_t child_timestamps[MAX_CHILDREN][MAX_CHILDREN];
char data_message[MESSAGE_SIZE];  //data message for the sender
int sender_flag=0;
int receiver_flag=0;
int source_id=-1;
char data_message[MESSAGE_SIZE];  //Data message for the sender
int node_id;
int duration;
char input_file[20];
char output_file[20];


void send_dvector();



void send_hello() {
    FILE *output = fopen(output_file, "a");
    if (output == NULL) {
    	perror("Error opening output file");
	return;
	}
	fprintf(output, "hello %d\n", node_id);
	fclose(output);
	}

void initialize_neighbors() {
    int i;
    for (i = 0; i < MAX_NODES; i++) {
        incoming_neighbors[i] = 0; // No neighbors initially
	timestamps[i] = 0;         // No hello messages received yet
	}
   	}

void initialize_multicast(){
        //multicast_parent = -1;
	int i;
	int j;
	for(j=0;j<MAX_CHILDREN;j++){

	for(i=0;i<MAX_CHILDREN;i++){
		children[j][i]=-1;
		multicast_parent[i]=-1;
		child_timestamps[j][i]=0;
	}
	}


}


void initialize_neighbor_indistances_dvec(){
	int i;
	for(i=0;i<MAX_NODES;i++){
		int j;
		for(j=0;j<MAX_NODES;j++){
  			if(i==j){
			neighbor_indistances_dvec[i][j]=0;
			}
			else{
				neighbor_indistances_dvec[i][j]=-1;//Initialize with -1
				
				
			}
		
		}
	}

}


void send_join(int source_id){

	int min_distance = -1;
	int parent_candidate=-1;

	//find the neighbor with the shortest distance to the source
	
	int i;
	for( i=0;i<MAX_NODES;i++){

		if(incoming_neighbors[i] && in_distance[i] != -1){

			
			if(min_distance == -1 || neighbor_indistances_dvec[i][source_id]<min_distance){
			
				min_distance=neighbor_indistances_dvec[i][source_id];
				parent_candidate=i;
				
			}

		}

	}
	if(parent_candidate==-1){
//		printf("No valid parent found for joining the multicast tree of source %d\n",source_id);
		return;

	}

	multicast_parent[source_id]=parent_candidate;
	FILE *output=fopen(output_file,"a");
	if(output==NULL){
		perror("error opening output file");
		return;

	}
//	printf("Sending join message to the Node %d (Parent) for the Source %d\n",multicast_parent[source_id],source_id);
	fprintf(output,"join %d %d %d %d\n",node_id,source_id,multicast_parent[source_id],next_hop[multicast_parent[source_id]]);
	fclose(output);
}


void process_message(const char *buffer,int node_id,int mcast_source_id ){
        char type[20];
	int sender_id;
	int neighbor_distances[10];
	if(sscanf(buffer, "%s", type)!=1){
		fprintf(stderr, "Invalid message format: %s",buffer);
		return;
	}

	if(strcmp(type, "hello")==0){
           //check the id and then check in the incoming array list make it 1 
	   //reset the timer to 0, Also make sure to check the timer. If no update for > 30sec 
	   //remove that node from the incoming neighbout list
	   if(sscanf(buffer, "hello %d", &sender_id) == 1){
		//printf("Received hello message from Node : %d\n", sender_id);
		incoming_neighbors[sender_id]=1;
                timestamps[sender_id]=time(NULL);               
	        in_distance[sender_id]=1;
		//printf("Current time in seconds since epoch: %ld\n",timestamps[sender_id]);
	        return;
	
            }
	    else{
		fprintf(stderr, "Invalid hello message: %s",buffer);
	    }

	}
        else if(strcmp(type, "in-distance")==0){
		char distances_str[256];
		if(sscanf(buffer,"in-distance %d %[^\n]", &sender_id,distances_str)==2){
			//printf("Received in-distance message from Node: %d\n",sender_id);
			//parse the distance from the message
			char *token = strtok(distances_str, " ");
			int j;
			for(j=0;j<MAX_NODES;j++){
				if(token){
					neighbor_distances[j]=atoi(token);
					token=strtok(NULL, " ");
				}
				else{
					neighbor_distances[j]=-1; //default to infinity if not there
				}
			}
			int u;
			for(u=0;u<MAX_NODES;u++){
				neighbor_indistances_dvec[sender_id][u]=neighbor_distances[u];
			}
			//update the in_distance based on the neighbor's view
			int i;
			for(i=0;i<MAX_NODES;i++){
				if(i==node_id) continue; //skip self
				if(neighbor_distances[i] != -1 && in_distance[sender_id]!=-1){
					int new_distance=in_distance[sender_id]+neighbor_distances[i];
					if(in_distance[i]==-1 || new_distance<in_distance[i]){
						//printf("Updated distance to Node %d: %d -> %d\n", i, in_distance[i], new_distance);
						in_distance[i]=new_distance;
					}
				}
			}
		}
		else{
			fprintf(stderr, " Invalid in-distance message: %s\n", buffer);
		}

	}
	else if(strcmp(type, "dvector")==0){
		int originator_id;
		int received_distances[MAX_NODES];
		int in_neighbors[MAX_NODES];
		int num_neighbors=0;
		int i_am_in_neighbor=0;
		//Process "dvector" message
		if(sscanf(buffer, "dvector %d %d", &sender_id, &originator_id)==2){
			//printf("Received dvector message from Node %d (originated by Node %d)\n",sender_id,originator_id);
                        const char *data_start = strchr(buffer, ' ')+1;
			data_start=strchr(data_start, ' ')+1;// Skip "dvector sender_id originator_id"
			data_start=strchr(data_start, ' ')+1;

			char *token=strtok((char *)data_start," ");
			int i;
			//printf("recived distances for originator %d and node_id %d is:\n",originator_id,node_id);
			for(i=0;i<MAX_NODES;i++){
				if(token){
					received_distances[i]=atoi(token);
					token=strtok(NULL, " ");

				}
				else{
					received_distances[i]=-1;//use -1 unreachable
				}
				//printf("distance from node %d -> %d is %d\n",originator_id,i,received_distances[i]); 
			}

			//printf("Before skipping in-neighbors : token = '%s'\n",token);
			//skip the "in-neighbors" label
			if(token && strcmp(token, "in-neighbors")==0){
				//printf("Found 'in-neighbors' label, token='%s'\n",token);
				token=strtok(NULL, " ");
			}
			//parse in neighbors
			while(token !=NULL){
				in_neighbors[num_neighbors++]=atoi(token);
				//printf("rrrrrrrrrrrrrrrrrrrrrrrr neighbor is %d rrrrrrrrrrrrrr\n",in_neighbors[num_neighbors-1]);
				if(in_neighbors[num_neighbors-1]==node_id){
					//printf("pppppppppppppppppppppppppppp neighbor of originator %d is %dppppppppp and node id is %d",originator_id, in_neighbors[num_neighbors-1], node_id);
					i_am_in_neighbor=1;//check if the current node is in the in neighbor list
				}
				token=strtok(NULL, " ");
			}
			//printf("-----------------------------------------------------------------------------------------------------------------------------\n");
			//update the routing table if the current node is in the in neighbor list
			if(i_am_in_neighbor){
			//	printf("--------------------node_id is %d  and sender is %d  and originator is %d----------------------------------\n",node_id, sender_id, originator_id);
			//	printf("Node %d is an in-neighbor for Node %d. Updating routing table.\n",node_id,originator_id);
				int r;
			//	printf("************************************************\n");
				routing_table[originator_id]=1;
				next_hop[originator_id]=originator_id;
                          //      printf("printing the routing table for node %d\n",node_id);
			//	printf("====================================================================\n");
				for(r=0;r<MAX_NODES;r++){
					if((received_distances[r]) != -1 && (received_distances[r]) != 0){
 						int new_distance=received_distances[r]+1; //add one hop to accommade for the node_id to originator distance
						if(routing_table[r]==-1||new_distance<routing_table[r]){
			//				printf("Updated routing table: Node %d via %d -> Distance: %d\n",r,sender_id,new_distance);
			//				printf("host info: for node_id %d ---> %d the next hop is %d \n",node_id,r,originator_id);
							routing_table[r]=new_distance;
							next_hop[r]=originator_id;  //set next hop to originator 
						}
					}
			//		printf("%d\n",routing_table[r]);
				}
                               }
			else{

				//In particular, a node x will forward the dvector message originating from node z 
				//only if the message was sent by neighbor y, 
				//if the number of hops from z(org) to y(neigh) is less than the number of hops from z to any other neighbor of x (ties are broken in favor of least node id).
				int u;
				int min=-1;
				int temp=-1;
				int flood=0;
				for(u=0;u<MAX_NODES;u++){
					if(incoming_neighbors[u]==1){
						temp=neighbor_indistances_dvec[u][originator_id];	
			//			printf("yes neighbor is thereeeee ................  temp is %d\n",temp);
						if(temp!=-1){
							if(min!=-1){
							     if(temp<min)
							     {
			//					printf("min is now temp %d",temp);
								min=temp;
							     }
							     }
						
							else{
                                                             min=temp;
							}
						}
					}
					}

				
				
	                  //      printf("omgggggggggggggg min is %d \n",min);			
				if(min == neighbor_indistances_dvec[sender_id][originator_id]){
						flood=1;

				}
				if(flood==1){
                                //write this message onto the output_<node_id> file 
				//so this will now inturn send it to it's neighbors and so on.
     					char output_file_flood[50];
					sprintf(output_file_flood,"output_%d",node_id);
					//open the output file to append the distance vector message
					FILE *output = fopen(output_file, "a");
					if(output==NULL){
						perror("Error opening output file");
						return;
					}
			//		printf("okay coming hereeeeeeeeeeeeeeee\n");
					//Write the distnce vector information to the file
					char modified_buffer[1024];
					snprintf(modified_buffer, sizeof(modified_buffer),"dvector %d %d",node_id, originator_id);//Replace the sender id to node_id
					//Append distances
					int s;
					for(s=0;s<MAX_NODES;s++){
						char tempp[16];
						snprintf(tempp,sizeof(tempp)," %d",received_distances[s]);
						strcat(modified_buffer, tempp);
					}
					//Append in-neighbors
					strcat(modified_buffer," in-neighbors");
					int q;
					for(q=0;q<num_neighbors;q++){
						char tempq[16];
						snprintf(tempq,sizeof(tempq)," %d",in_neighbors[q]);
						strcat(modified_buffer, tempq);
					}

					//Now write the modified buffer to the output file
					fprintf(output, "%s\n",modified_buffer);
					fclose(output);

				}
		 }

			}

		
		else{
			fprintf(stderr,"Invalid dvector ssage format: %sn",buffer);
			return;
		}
	}

	else if(strcmp(type,"join")==0){
		int sender_id, source_id, parent_id, next_node;
		if(sscanf(buffer, "join %d %d %d %d",&sender_id,&source_id,&parent_id,&next_node)==4){
			//printf("Received join message from node %d for Source %d (Parent: %d, Next Node: %d)\n",sender_id,source_id,parent_id,next_node);
			//record the sender as the child if we are the parent
			
			if(node_id == parent_id){
				int mm;
				//children[for source]=children
				//for(mm=0;mm<MAX_CHILDREN;mm++){
					
					//if(children[mm]==-1){
						children[source_id][sender_id]=1;
						child_timestamps[source_id][sender_id]=time(NULL);
						//printf("Node %d added as a child\n", sender_id);
						//break;
					//}

				

				//If not already on the tree, send a join message to our parent
				 if(multicast_parent[source_id]==-1 && source_id!=parent_id){

					send_join(source_id);
				}
                         }
			
			else if(next_hop[parent_id]!=-1){

				//forward the join message to the next node towards the parent
				FILE *output = fopen(output_file, "a");
				//printf("________________yes i want to forward______________________________\n");
				if(output == NULL){

					perror("Error opening output file");
					return;

				}
				//printf("next hop is %d\n",next_hop[parent_id]);
				fprintf(output, "join %d %d %d %d\n", sender_id,source_id,parent_id,next_hop[parent_id]);
				fclose(output);

			}
			


		}

	}
	
        else if(strcmp(type,"data")==0){
		int sender_id, root_id;
		char received_data[BUFFER_SIZE];
		
		if(sscanf(buffer,"data %d %d %[^\n]",&sender_id,&root_id,received_data)==3){
			//printf("Received data message from Node %d (Root: %d): %s\n", sender_id, root_id, received_data);
			//forward the data to children
			int ff;
			for(ff=0;ff<MAX_CHILDREN;ff++){
				if(children[root_id][ff]!=-1){
					FILE *output=fopen(output_file,"a");
					if(output==NULL){
						perror("Error opening output file");
						return;

					}
					fprintf(output, "data %d %d %s\n",ff,root_id,received_data);
					fclose(output);

				}
			}

			//if the node is a receiver for this source, write the data to a file
			if(receiver_flag && root_id ==mcast_source_id){
				char recv_file[50];
				sprintf(recv_file,"%d_received_from_%d",node_id,mcast_source_id);
				FILE *recv_output =fopen(recv_file,"a");
				if(recv_output==NULL){
					perror("Error opening receiver file");
					return;
	
				}
				fprintf(recv_output,"%s\n",received_data);
				fclose(recv_output);

			}


		}


	
	}
	else{
		fprintf(stderr, "Unknown message type: %s", buffer);
	}
  
}
void check_inactive_children(){
	time_t current_time=time(NULL);
	int i;
	int k;
      for(k=0;k<MAX_CHILDREN;k++){
        for(i=0;i<MAX_CHILDREN;i++){
		if(children[k][i]!=-1 && difftime(current_time,child_timestamps[k][i])>30){
			//printf("Child %d is inactive, removing from the tree\n",children[k][i]);
			children[k][i]=-1;
			child_timestamps[k][i]=0;
		}
		}
	}
}

void send_data(int m_source_id){
       FILE *output = fopen(output_file,"a");
       if(output==NULL){
		perror("Error opening output file");
		return;

       }
       int p;
       for(p=0;p<MAX_NODES;p++){
          if(children[m_source_id][p]==1){
       	  fprintf(output, "data %d %d %s\n", p,m_source_id,data_message);
        }
       }
       fclose(output);

}


void read_input_file(const char *input_file, long *last_read_position,int node_id,int mcast_source_id){
	FILE *input = fopen(input_file, "r");
	if (input == NULL) {
	     return;
	}
	//fseek is used to move to the last read position
	fseek(input, *last_read_position, SEEK_SET);
	
	char buffer[BUFFER_SIZE];
	//process all new lines until the end of the file
	while(fgets(buffer,sizeof(buffer),input)){
		process_message(buffer,node_id,mcast_source_id);
	
	}
	//update the last_read_position using ftell after reading the file
	*last_read_position = ftell(input);
        fclose(input);
}

void refresh_parent(int source_id){
	//if(multicast_parent[source_id]!=-1){
		//printf("Refreshing join the Parent %d\n",multicast_parent[source_id]);
		send_join(source_id);
	//}
}

void remove_neighbor(int neighbor_id) {
    // Logic to remove the neighbor from routing tables
	incoming_neighbors[neighbor_id]=0;
	timestamps[neighbor_id]=0;
	in_distance[neighbor_id]=-1;
	//printf("Removing neighbor %d from the routing table\n", neighbor_id);


    // Invalidate all routes that use the removed neighbor as the next hop
        int i;
	for (i = 0; i < MAX_NODES; i++) {
              if (next_hop[i] == neighbor_id) {
	      //printf("Invalidating route to Node %d (was via neighbor %d)\n", i, neighbor_id);
              routing_table[i] = -1;  
	      // Set distance to infinity
              next_hop[i] = -1;      
	      }
         }
	send_dvector();
}
     

void check_inactive_neighbors() {
	time_t current_time = time(NULL);
	int i;
	for (i = 0; i < MAX_NODES; i++) {
		if (timestamps[i] != 0 && difftime(current_time, timestamps[i]) > 30) {
			//printf("Neighbor %d is inactive\n", i);
			remove_neighbor(i);
		}
	}
}


//Helper function to initialize the in-distance table
void initialize_in_distance_table(int node_id){
	int i;
	for(i=0;i<MAX_NODES;i++){
		if(i==node_id){
			in_distance[i]=0;
		}
		else{
			in_distance[i]=-1;
		}
	}
}


// Helper function to initialize routing table
void initialize_routing_table(int node_id) {
	int i;
	for (i = 0; i < MAX_NODES; i++) {
		if(i==node_id){
			routing_table[i]=0;   
			next_hop[i]=node_id;  //the next hop to itself is itself
		}
		else{
                	routing_table[i]=-1;
			next_hop[i]=-1;      //No next hop initially
		}
	}
}	

void send_in_distance(){
	FILE *output =fopen(output_file, "a");
	if(output==NULL){
		perror("Error opening output file");
		return;
	}
	fprintf(output, "in-distance %d", node_id);
	int i;
	
	for(i =0;i<MAX_NODES;i++){
		fprintf(output," %d",in_distance[i]);
	}
	fprintf(output,"\n");
	fclose(output);
}

void send_dvector(){
	FILE *output = fopen(output_file, "a");
	if(output == NULL){
		perror("Error opening output file");
		return;
	}
	int cc;
	int counter=0;
	for(cc=0;cc<MAX_NODES;cc++){
		if(incoming_neighbors[cc]==1){
			counter=1;
			break;
		}
	}
	if(counter==0){
		fclose(output);
		return;
	
	}
	//write the message to the file as in-neighbor exist
	fprintf(output,"dvector %d %d", node_id, node_id);
	int k;
	for(k=0;k<MAX_NODES;k++){
		fprintf(output, " %d",routing_table[k]);
	}
	fprintf(output, " in-neighbors");
	int y;
	for(y=0;y<MAX_NODES; y++){
		if(incoming_neighbors[y]==1){
			fprintf(output, " %d",y);//List in-neighbors
		}
	}
	
	fprintf(output,"\n");
	fclose(output);

}

    



int main(int argc, char *argv[]) {
       
       int cc=0;
       int source_idd;
        if (argc < 2) {
	                fprintf(stderr, "Usage: %s <node_id> <duration> [sender|receiver <args>]\n", argv[0]);
			exit(EXIT_FAILURE);
	}
	node_id = atoi(argv[1]);
	duration=atoi(argv[2]);
	if(argc>=4 && strcmp(argv[2],"sender")==0){
		cc=2;
		sender_flag=1;
		strncpy(data_message,argv[3],MESSAGE_SIZE-1);
		data_message[MESSAGE_SIZE-1]='\0';
		duration = atoi(argv[4]);
		//printf("Node %d is a sender, sending message : %s\n",node_id,data_message);
	}
	
	else if(argc>=5 && strcmp(argv[2],"receiver")==0){
		cc=3;
		receiver_flag=1;
		source_idd=atoi(argv[3]);
		duration = atoi(argv[4]);
		//printf("Node %d is a receiver, joining the tree of source %d\n",node_id,source_idd);
		send_join(source_idd); //Initial join message for receivers
	}

        initialize_neighbors();
	sprintf(input_file, "input_%d", node_id);
		     sprintf(output_file, "output_%d", node_id);
	//printf("Node %d starting, running for %d seconds.\n", node_id, duration);						 
	initialize_in_distance_table(node_id);
	initialize_routing_table(node_id);
	initialize_multicast();
	long last_read_position = 0;


	int i;
	for (i = 0; i < duration; i++) {
        	if (i % 5 == 0) {
	        	send_hello();
      			send_in_distance();
			send_dvector();
		if(receiver_flag){
			refresh_parent(source_idd); //send periodic join message to keep the tree alive
		
		}
		}
		if(i%10 ==0 && sender_flag){

			send_data(node_id);
		}
	        
		read_input_file(input_file, &last_read_position,node_id,source_idd);	
	        check_inactive_neighbors();
		
		check_inactive_children();
		sleep(1);
	}

	//printf("Node %d terminating.\n", node_id);
	return 0;
}
