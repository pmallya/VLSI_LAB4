module ROUTER4x4 #(WL = 16, ADDR = 4)(
input logic clk,
input logic reset_b,

input logic [1:0] X [15:0],
input logic [1:0] Y [15:0],

input logic [WL-1 : 0] src_input [15:0],
output logic [WL-1 : 0] dest_output [15:0],

input logic [15:0] src_bustorouter_valid_in , // input valid signal
output logic [15:0] src_routertobus_ready_out , // output ready signal

output logic [15:0] dest_routertobus_valid_out,  // output valid signal
input logic [15:0] dest_bustorouter_ready_in   // input ready signal
);

 logic [1:0] X_1 [3:0];
 logic [1:0] X_2 [3:0];
 logic [1:0] X_3 [3:0];
 logic [1:0] X_4 [3:0];

 logic [1:0] Y_1 [3:0];
 logic [1:0] Y_2 [3:0];
 logic [1:0] Y_3 [3:0];
 logic [1:0] Y_4 [3:0];
 
 logic [15:0] local_input_1 [3:0] ;
 logic [15:0] local_input_2 [3:0] ;
 logic [15:0] local_input_3 [3:0] ;
 logic [15:0] local_input_4 [3:0] ;
 
 logic [15:0] local_output_1 [3:0] ;
 logic [15:0] local_output_2 [3:0] ;
 logic [15:0] local_output_3 [3:0] ;
 logic [15:0] local_output_4 [3:0] ;
 
 logic [3:0] l_bustorouter_valid_in_1 ;
 logic [3:0] l_bustorouter_valid_in_2 ;
 logic [3:0] l_bustorouter_valid_in_3 ;
 logic [3:0] l_bustorouter_valid_in_4 ;
 
 logic [3:0] l_routertobus_ready_out_1 ;
 logic [3:0] l_routertobus_ready_out_2 ;
 logic [3:0] l_routertobus_ready_out_3 ;
 logic [3:0] l_routertobus_ready_out_4 ;
 
 logic [3:0] l_routertobus_valid_out_1 ;
 logic [3:0] l_routertobus_valid_out_2 ;
 logic [3:0] l_routertobus_valid_out_3 ;
 logic [3:0] l_routertobus_valid_out_4 ;
 
 logic [3:0] l_bustorouter_ready_in_1 ;
 logic [3:0] l_bustorouter_ready_in_2 ;
 logic [3:0] l_bustorouter_ready_in_3 ;
 logic [3:0] l_bustorouter_ready_in_4 ;
 
 logic [WL -1 : 0] N_bustorouter_data_in_1 [3:0]; //packet data (input to locals of router)
 logic [WL -1 : 0] N_bustorouter_data_in_2 [3:0]; //packet data (input to locals of router)
 logic [WL -1 : 0] N_bustorouter_data_in_3 [3:0]; //packet data (input to locals of router)
 logic [WL -1 : 0] N_bustorouter_data_in_4 [3:0]; //packet data (input to locals of router)
 
 logic [WL -1 : 0] N_routertobus_data_out_1 [3:0]; // packet data (output from locals of router)
 logic [WL -1 : 0] N_routertobus_data_out_2 [3:0]; // packet data (output from locals of router)
 logic [WL -1 : 0] N_routertobus_data_out_3 [3:0]; // packet data (output from locals of router)
 logic [WL -1 : 0] N_routertobus_data_out_4 [3:0]; // packet data (output from locals of router)

 logic [WL -1 : 0] S_bustorouter_data_in_1 [3:0]; //packet data (input to locals of router)
 logic [WL -1 : 0] S_bustorouter_data_in_2 [3:0]; //packet data (input to locals of router)
 logic [WL -1 : 0] S_bustorouter_data_in_3 [3:0]; //packet data (input to locals of router)
 logic [WL -1 : 0] S_bustorouter_data_in_4 [3:0]; //packet data (input to locals of router)
 
 logic [WL -1 : 0] S_routertobus_data_out_1 [3:0]; // packet data (output from locals of router)
 logic [WL -1 : 0] S_routertobus_data_out_2 [3:0]; // packet data (output from locals of router)
 logic [WL -1 : 0] S_routertobus_data_out_3 [3:0]; // packet data (output from locals of router)
 logic [WL -1 : 0] S_routertobus_data_out_4 [3:0]; // packet data (output from locals of router)

 logic [3:0] N_bustorouter_valid_in_1 ; // input valid signal
 logic [3:0] N_bustorouter_valid_in_2 ; // input valid signal
 logic [3:0] N_bustorouter_valid_in_3 ; // input valid signal
 logic [3:0] N_bustorouter_valid_in_4 ; // input valid signal
 
 logic [3:0] N_routertobus_ready_out_1 ; // output ready signal
 logic [3:0] N_routertobus_ready_out_2 ; // output ready signal
 logic [3:0] N_routertobus_ready_out_3 ; // output ready signal
 logic [3:0] N_routertobus_ready_out_4 ; // output ready signal

 logic [3:0] N_routertobus_valid_out_1;  // output valid signal
 logic [3:0] N_routertobus_valid_out_2;  // output valid signal
 logic [3:0] N_routertobus_valid_out_3;  // output valid signal
 logic [3:0] N_routertobus_valid_out_4;  // output valid signal
 
 logic [3:0] N_bustorouter_ready_in_1 ;  // input ready signal
 logic [3:0] N_bustorouter_ready_in_2 ;  // input ready signal
 logic [3:0] N_bustorouter_ready_in_3 ;  // input ready signal
 logic [3:0] N_bustorouter_ready_in_4 ;  // input ready signal

 logic [3:0] S_bustorouter_valid_in_1 ; // input valid signal
 logic [3:0] S_bustorouter_valid_in_2 ; // input valid signal
 logic [3:0] S_bustorouter_valid_in_3 ; // input valid signal
 logic [3:0] S_bustorouter_valid_in_4 ; // input valid signal
 
 logic [3:0] S_routertobus_ready_out_1 ; // output ready signal
 logic [3:0] S_routertobus_ready_out_2 ; // output ready signal
 logic [3:0] S_routertobus_ready_out_3 ; // output ready signal
 logic [3:0] S_routertobus_ready_out_4 ; // output ready signal

 logic [3:0] S_routertobus_valid_out_1 ; // output ready signal
 logic [3:0] S_routertobus_valid_out_2 ; // output ready signal
 logic [3:0] S_routertobus_valid_out_3 ; // output ready signal
 logic [3:0] S_routertobus_valid_out_4 ; // output ready signal
 
 logic [3:0] S_bustorouter_ready_in_1 ;  // input ready signal
 logic [3:0] S_bustorouter_ready_in_2 ;  // input ready signal
 logic [3:0] S_bustorouter_ready_in_3 ;  // input ready signal
 logic [3:0] S_bustorouter_ready_in_4 ;  // input ready signal

//----------------------------------------------------------------------------------
//X and Y of each 4x1
//----------------------------------------------------------------------------------
assign X_1[0] = X[0];
assign X_1[1] = X[1];
assign X_1[2] = X[2];
assign X_1[3] = X[3];
assign X_2[0] = X[4];
assign X_2[1] = X[5];
assign X_2[2] = X[6];
assign X_2[3] = X[7];
assign X_3[0] = X[8];
assign X_3[1] = X[9];
assign X_3[2] = X[10];
assign X_3[3] = X[11];
assign X_4[0] = X[12];
assign X_4[1] = X[13];
assign X_4[2] = X[14];
assign X_4[3] = X[15];

assign Y_1[0] = Y[0];
assign Y_1[1] = Y[1];
assign Y_1[2] = Y[2];
assign Y_1[3] = Y[3];
assign Y_2[0] = Y[4];
assign Y_2[1] = Y[5];
assign Y_2[2] = Y[6];
assign Y_2[3] = Y[7];
assign Y_3[0] = Y[8];
assign Y_3[1] = Y[9];
assign Y_3[2] = Y[10];
assign Y_3[3] = Y[11];
assign Y_4[0] = Y[12];
assign Y_4[1] = Y[13];
assign Y_4[2] = Y[14];
assign Y_4[3] = Y[15];

//----------------------------------------------------------------------------------
//Source Inputs to Local of each 4x1
//----------------------------------------------------------------------------------

// Local_input_1
// src_input to Local_in -- 0 to 0
assign local_input_1[0] = src_input[0];
assign l_bustorouter_valid_in_1[0] = src_bustorouter_valid_in[0];
assign src_routertobus_ready_out[0] = l_routertobus_ready_out_1[0];

// src_input to Local_in -- 1 to 1
assign local_input_1[1] = src_input[4];
assign l_bustorouter_valid_in_1[1] = src_bustorouter_valid_in[4];
assign src_routertobus_ready_out[4] = l_routertobus_ready_out_1[1];

// src_input to Local_in -- 2 to 2
assign local_input_1[2] = src_input[8];
assign l_bustorouter_valid_in_1[2] = src_bustorouter_valid_in[8];
assign src_routertobus_ready_out[8] = l_routertobus_ready_out_1[2];

// src_input to Local_in -- 3 to 3
assign local_input_1[3] = src_input[12];
assign l_bustorouter_valid_in_1[3] = src_bustorouter_valid_in[12];
assign src_routertobus_ready_out[12] = l_routertobus_ready_out_1[3];

// Local_input_2

// src_input to Local_in -- 4 to 0
assign local_input_2[0] = src_input[1];
assign l_bustorouter_valid_in_2[0] = src_bustorouter_valid_in[1];
assign src_routertobus_ready_out[1] = l_routertobus_ready_out_2[0];

// src_input to Local_in -- 5 to 1
assign local_input_2[1] = src_input[5];
assign l_bustorouter_valid_in_2[1] = src_bustorouter_valid_in[5];
assign src_routertobus_ready_out[5] = l_routertobus_ready_out_2[1];

// src_input to Local_in -- 6 to 2
assign local_input_2[2] = src_input[9];
assign l_bustorouter_valid_in_2[2] = src_bustorouter_valid_in[9];
assign src_routertobus_ready_out[9] = l_routertobus_ready_out_2[2];

// src_input to Local_in -- 7 to 3
assign local_input_2[3] = src_input[13];
assign l_bustorouter_valid_in_2[3] = src_bustorouter_valid_in[13];
assign src_routertobus_ready_out[13] = l_routertobus_ready_out_2[3];

// Local_input_3

// src_input to Local_in -- 8 to 0
assign local_input_3[0] = src_input[2];
assign l_bustorouter_valid_in_3[0] = src_bustorouter_valid_in[2];
assign src_routertobus_ready_out[2] = l_routertobus_ready_out_3[0];

// src_input to Local_in -- 9 to 1
assign local_input_3[1] = src_input[6];
assign l_bustorouter_valid_in_3[1] = src_bustorouter_valid_in[6];
assign src_routertobus_ready_out[6] = l_routertobus_ready_out_3[1];

// src_input to Local_in -- 10 to 2
assign local_input_3[2] = src_input[10];
assign l_bustorouter_valid_in_3[2] = src_bustorouter_valid_in[10];
assign src_routertobus_ready_out[10] = l_routertobus_ready_out_3[2];

// src_input to Local_in -- 11 to 3
assign local_input_3[3] = src_input[14];
assign l_bustorouter_valid_in_3[3] = src_bustorouter_valid_in[14];
assign src_routertobus_ready_out[14] = l_routertobus_ready_out_3[3];

// Local_input_4

// src_input to Local_in -- 12 to 0
assign local_input_4[0] = src_input[3];
assign l_bustorouter_valid_in_4[0] = src_bustorouter_valid_in[3];
assign src_routertobus_ready_out[3] = l_routertobus_ready_out_4[0];

// src_input to Local_in -- 13 to 1
assign local_input_4[1] = src_input[7];
assign l_bustorouter_valid_in_4[1] = src_bustorouter_valid_in[7];
assign src_routertobus_ready_out[7] = l_routertobus_ready_out_4[1];

// src_input to Local_in -- 14 to 2
assign local_input_4[2] = src_input[11];
assign l_bustorouter_valid_in_4[2] = src_bustorouter_valid_in[11];
assign src_routertobus_ready_out[11] = l_routertobus_ready_out_4[2];

// src_input to Local_in -- 15 to 3
assign local_input_4[3] = src_input[15];
assign l_bustorouter_valid_in_4[3] = src_bustorouter_valid_in[15];
assign src_routertobus_ready_out[15] = l_routertobus_ready_out_4[3];

//----------------------------------------------------------------------------------
//Destination Outputs to Local_out of each 4x1
//----------------------------------------------------------------------------------

// Local_output_1

// Local to Local_out -- 0 to 0 
assign dest_output[0] = local_output_1[0];
assign dest_routertobus_valid_out[0] = l_routertobus_valid_out_1[0];
assign l_bustorouter_ready_in_1[0] = dest_bustorouter_ready_in[0];

// Local to Local_out -- 1 to 1
assign dest_output[4] = local_output_1[1];
assign dest_routertobus_valid_out[4] = l_routertobus_valid_out_1[1];
assign l_bustorouter_ready_in_1[1] = dest_bustorouter_ready_in[4];

// Local to Local_out -- 2 to 2
assign dest_output[8] = local_output_1[2];
assign dest_routertobus_valid_out[8] = l_routertobus_valid_out_1[2];
assign l_bustorouter_ready_in_1[2] = dest_bustorouter_ready_in[8];

// Local to Local_out -- 3 to 3
assign dest_output[12] = local_output_1[3];
assign dest_routertobus_valid_out[12] = l_routertobus_valid_out_1[3];
assign l_bustorouter_ready_in_1[3] = dest_bustorouter_ready_in[12];

// Local_output_2

// Local to Local_out -- 4 to 0 
assign dest_output[1] = local_output_2[0];
assign dest_routertobus_valid_out[1] = l_routertobus_valid_out_2[0];
assign l_bustorouter_ready_in_2[0] = dest_bustorouter_ready_in[1];

// Local to Local_out -- 5 to 1
assign dest_output[5] = local_output_2[1];
assign dest_routertobus_valid_out[5] = l_routertobus_valid_out_2[1];
assign l_bustorouter_ready_in_2[1] = dest_bustorouter_ready_in[5];

// Local to Local_out -- 6 to 2
assign dest_output[9] = local_output_2[2];
assign dest_routertobus_valid_out[9] = l_routertobus_valid_out_2[2];
assign l_bustorouter_ready_in_2[2] = dest_bustorouter_ready_in[9];

// Local to Local_out -- 7 to 3
assign dest_output[13] = local_output_2[3];
assign dest_routertobus_valid_out[13] = l_routertobus_valid_out_2[3];
assign l_bustorouter_ready_in_2[3] = dest_bustorouter_ready_in[13];

// Local_output_4

// Local to Local_out -- 8 to 0 
assign dest_output[2] = local_output_3[0];
assign dest_routertobus_valid_out[2] = l_routertobus_valid_out_3[0];
assign l_bustorouter_ready_in_3[0] = dest_bustorouter_ready_in[2];

// Local to Local_out -- 9 to 1
assign dest_output[6] = local_output_3[1];
assign dest_routertobus_valid_out[6] = l_routertobus_valid_out_3[1];
assign l_bustorouter_ready_in_3[1] = dest_bustorouter_ready_in[6];

// Local to Local_out -- 10 to 2
assign dest_output[10] = local_output_3[2];
assign dest_routertobus_valid_out[10] = l_routertobus_valid_out_3[2];
assign l_bustorouter_ready_in_3[2] = dest_bustorouter_ready_in[10];

// Local to Local_out -- 11 to 3
assign dest_output[14] = local_output_3[3];
assign dest_routertobus_valid_out[14] = l_routertobus_valid_out_3[3];
assign l_bustorouter_ready_in_3[3] = dest_bustorouter_ready_in[14];

// local_output_4

// Local to Local_out -- 12 to 0 
assign dest_output[3] = local_output_4[0];
assign dest_routertobus_valid_out[3] = l_routertobus_valid_out_4[0];
assign l_bustorouter_ready_in_4[0] = dest_bustorouter_ready_in[3];

// Local to Local_out -- 13 to 1
assign dest_output[7] = local_output_4[1];
assign dest_routertobus_valid_out[7] = l_routertobus_valid_out_4[1];
assign l_bustorouter_ready_in_4[1] = dest_bustorouter_ready_in[7];

// Local to Local_out -- 14 to 2
assign dest_output[11] = local_output_4[2];
assign dest_routertobus_valid_out[11] = l_routertobus_valid_out_4[2];
assign l_bustorouter_ready_in_4[2] = dest_bustorouter_ready_in[11];

// Local to Local_out -- 15 to 3
assign dest_output[15] = local_output_4[3];
assign dest_routertobus_valid_out[15] = l_routertobus_valid_out_4[3];
assign l_bustorouter_ready_in_4[3] = dest_bustorouter_ready_in[15];


//----------------------------------------------------------------------------------
//South to North Connection of each router
//----------------------------------------------------------------------------------

// For 4x1 1 to 2

// South to North -- 1 to 2 for [0 to 4]
assign N_bustorouter_data_in_2[0] = S_routertobus_data_out_1[0];
assign N_bustorouter_valid_in_2[0] = S_routertobus_valid_out_1[0];
assign S_bustorouter_ready_in_1[0] = N_routertobus_ready_out_2[0];

// South to North -- 1 to 2 for [1 to 5]
assign N_bustorouter_data_in_2[1] = S_routertobus_data_out_1[1];
assign N_bustorouter_valid_in_2[1] = S_routertobus_valid_out_1[1];
assign S_bustorouter_ready_in_1[1] = N_routertobus_ready_out_2[1];

// South to North -- 1 to 2 for [2 to 6]
assign N_bustorouter_data_in_2[2] = S_routertobus_data_out_1[2];
assign N_bustorouter_valid_in_2[2] = S_routertobus_valid_out_1[2];
assign S_bustorouter_ready_in_1[2] = N_routertobus_ready_out_2[2];

// South to North -- 1 to 2 for [3 to 7]
assign N_bustorouter_data_in_2[3] = S_routertobus_data_out_1[3];
assign N_bustorouter_valid_in_2[3] = S_routertobus_valid_out_1[3];
assign S_bustorouter_ready_in_1[3] = N_routertobus_ready_out_2[3];

// For 4x1 2 to 3

// South to North -- 2 to 3 for [0 to 4]
assign N_bustorouter_data_in_3[0] = S_routertobus_data_out_2[0];
assign N_bustorouter_valid_in_3[0] = S_routertobus_valid_out_2[0];
assign S_bustorouter_ready_in_2[0] = N_routertobus_ready_out_3[0];

// South to North -- 2 to 3 for [1 to 5]
assign N_bustorouter_data_in_3[1] = S_routertobus_data_out_2[1];
assign N_bustorouter_valid_in_3[1] = S_routertobus_valid_out_2[1];
assign S_bustorouter_ready_in_2[1] = N_routertobus_ready_out_3[1];

// South to North -- 2 to 3 for [2 to 6]
assign N_bustorouter_data_in_3[2] = S_routertobus_data_out_2[2];
assign N_bustorouter_valid_in_3[2] = S_routertobus_valid_out_2[2];
assign S_bustorouter_ready_in_2[2] = N_routertobus_ready_out_3[2];

// South to North -- 2 to 3 for [3 to 7]
assign N_bustorouter_data_in_3[3] = S_routertobus_data_out_2[3];
assign N_bustorouter_valid_in_3[3] = S_routertobus_valid_out_2[3];
assign S_bustorouter_ready_in_2[3] = N_routertobus_ready_out_3[3];

// For 4x1 3 to 4

// South to North -- 3 to 4 for [0 to 4]
assign N_bustorouter_data_in_4[0] = S_routertobus_data_out_3[0];
assign N_bustorouter_valid_in_4[0] = S_routertobus_valid_out_3[0];
assign S_bustorouter_ready_in_3[0] = N_routertobus_ready_out_4[0];

// South to North -- 3 to 4 for [1 to 5]
assign N_bustorouter_data_in_4[1] = S_routertobus_data_out_3[1];
assign N_bustorouter_valid_in_4[1] = S_routertobus_valid_out_3[1];
assign S_bustorouter_ready_in_3[1] = N_routertobus_ready_out_4[1];

// South to North -- 3 to 4 for [2 to 6]
assign N_bustorouter_data_in_4[2] = S_routertobus_data_out_3[2];
assign N_bustorouter_valid_in_4[2] = S_routertobus_valid_out_3[2];
assign S_bustorouter_ready_in_3[2] = N_routertobus_ready_out_4[2];

// South to North -- 3 to 4 for [3 to 7]
assign N_bustorouter_data_in_4[3] = S_routertobus_data_out_3[3];
assign N_bustorouter_valid_in_4[3] = S_routertobus_valid_out_3[3];
assign S_bustorouter_ready_in_3[3] = N_routertobus_ready_out_4[3];

// For 4x1 4 to 1

// South to North -- 4 to 1 for [0 to 4]
assign N_bustorouter_data_in_1[0] = S_routertobus_data_out_4[0];
assign N_bustorouter_valid_in_1[0] = S_routertobus_valid_out_4[0];
assign S_bustorouter_ready_in_4[0] = N_routertobus_ready_out_1[0];

// South to North -- 4 to 1 for [1 to 5]
assign N_bustorouter_data_in_1[1] = S_routertobus_data_out_4[1];
assign N_bustorouter_valid_in_1[1] = S_routertobus_valid_out_4[1];
assign S_bustorouter_ready_in_4[1] = N_routertobus_ready_out_1[1];

// South to North -- 4 to 1 for [2 to 6]
assign N_bustorouter_data_in_1[2] = S_routertobus_data_out_4[2];
assign N_bustorouter_valid_in_1[2] = S_routertobus_valid_out_4[2];
assign S_bustorouter_ready_in_4[2] = N_routertobus_ready_out_1[2];

// South to North -- 4 to 1 for [3 to 7]
assign N_bustorouter_data_in_1[3] = S_routertobus_data_out_4[3];
assign N_bustorouter_valid_in_1[3] = S_routertobus_valid_out_4[3];
assign S_bustorouter_ready_in_4[3] = N_routertobus_ready_out_1[3];

//----------------------------------------------------------------------------------
// North to South Connection of each router
//----------------------------------------------------------------------------------

// For 4x1 2 to 1

// North to South -- 1 to 2 for [0 to 4]
assign S_bustorouter_data_in_1[0] = N_routertobus_data_out_2[0];
assign S_bustorouter_valid_in_1[0] = N_routertobus_valid_out_2[0];
assign N_bustorouter_ready_in_2[0] = S_routertobus_ready_out_1[0];

// North to South -- 1 to 2 for [1 to 5]
assign S_bustorouter_data_in_1[1] = N_routertobus_data_out_2[1];
assign S_bustorouter_valid_in_1[1] = N_routertobus_valid_out_2[1];
assign N_bustorouter_ready_in_2[1] = S_routertobus_ready_out_1[1];

// North to South -- 1 to 2 for [2 to 6]
assign S_bustorouter_data_in_1[2] = N_routertobus_data_out_2[2];
assign S_bustorouter_valid_in_1[2] = N_routertobus_valid_out_2[2];
assign N_bustorouter_ready_in_2[2] = S_routertobus_ready_out_1[2];

// North to South -- 1 to 2 for [3 to 7]
assign S_bustorouter_data_in_1[3] = N_routertobus_data_out_2[3];
assign S_bustorouter_valid_in_1[3] = N_routertobus_valid_out_2[3];
assign N_bustorouter_ready_in_2[3] = S_routertobus_ready_out_1[3];

// For 4x1 3 to 2

// North to South -- 2 to 3 for [0 to 4]
assign S_bustorouter_data_in_2[0] = N_routertobus_data_out_3[0];
assign S_bustorouter_valid_in_2[0] = N_routertobus_valid_out_3[0];
assign N_bustorouter_ready_in_3[0] = S_routertobus_ready_out_2[0];

// North to South -- 2 to 3 for [1 to 5]
assign S_bustorouter_data_in_2[1] = N_routertobus_data_out_3[1];
assign S_bustorouter_valid_in_2[1] = N_routertobus_valid_out_3[1];
assign N_bustorouter_ready_in_3[1] = S_routertobus_ready_out_2[1];

// North to South -- 2 to 3 for [2 to 6]
assign S_bustorouter_data_in_2[2] = N_routertobus_data_out_3[2];
assign S_bustorouter_valid_in_2[2] = N_routertobus_valid_out_3[2];
assign N_bustorouter_ready_in_3[2] = S_routertobus_ready_out_2[2];

// North to South -- 2 to 3 for [3 to 7]
assign S_bustorouter_data_in_2[3] = N_routertobus_data_out_3[3];
assign S_bustorouter_valid_in_2[3] = N_routertobus_valid_out_3[3];
assign N_bustorouter_ready_in_3[3] = S_routertobus_ready_out_2[3];

// For 4x1 4 to 3

// North to South -- 3 to 4 for [0 to 4]
assign S_bustorouter_data_in_3[0] = N_routertobus_data_out_4[0];
assign S_bustorouter_valid_in_3[0] = N_routertobus_valid_out_4[0];
assign N_bustorouter_ready_in_4[0] = S_routertobus_ready_out_3[0];

// North to South -- 3 to 4 for [1 to 5]
assign S_bustorouter_data_in_3[1] = N_routertobus_data_out_4[1];
assign S_bustorouter_valid_in_3[1] = N_routertobus_valid_out_4[1];
assign N_bustorouter_ready_in_4[1] = S_routertobus_ready_out_3[1];

// North to South -- 3 to 4 for [2 to 6]
assign S_bustorouter_data_in_3[2] = N_routertobus_data_out_4[2];
assign S_bustorouter_valid_in_3[2] = N_routertobus_valid_out_4[2];
assign N_bustorouter_ready_in_4[2] = S_routertobus_ready_out_3[2];

// North to South -- 3 to 4 for [3 to 7]
assign S_bustorouter_data_in_3[3] = N_routertobus_data_out_4[3];
assign S_bustorouter_valid_in_3[3] = N_routertobus_valid_out_4[3];
assign N_bustorouter_ready_in_4[3] = S_routertobus_ready_out_3[3];

// For 4x1 1 to 4

// North to South -- 4 to 1 for [0 to 4]
assign S_bustorouter_data_in_4[0] = N_routertobus_data_out_1[0];
assign S_bustorouter_valid_in_4[0] = N_routertobus_valid_out_1[0];
assign N_bustorouter_ready_in_1[0] = S_routertobus_ready_out_4[0];

// North to South -- 4 to 1 for [1 to 5]
assign S_bustorouter_data_in_4[1] = N_routertobus_data_out_1[1];
assign S_bustorouter_valid_in_4[1] = N_routertobus_valid_out_1[1];
assign N_bustorouter_ready_in_1[1] = S_routertobus_ready_out_4[1];

// North to South -- 4 to 1 for [2 to 6]
assign S_bustorouter_data_in_4[2] = N_routertobus_data_out_1[2];
assign S_bustorouter_valid_in_4[2] = N_routertobus_valid_out_1[2];
assign N_bustorouter_ready_in_1[2] = S_routertobus_ready_out_4[2];

// North to South -- 4 to 1 for [3 to 7]
assign S_bustorouter_data_in_4[3] = N_routertobus_data_out_1[3];
assign S_bustorouter_valid_in_4[3] = N_routertobus_valid_out_1[3];
assign N_bustorouter_ready_in_1[3] = S_routertobus_ready_out_4[3];



ROUTER4x1 r4x1 (.clk(clk), .reset_b(reset_b), 
	.local_input(local_input_1), 
	.local_output(local_output_1), 
	
	.X(X_1),
	.Y(Y_1),
 
	.N_bustorouter_data_in(N_bustorouter_data_in_1),
	.N_routertobus_data_out(N_routertobus_data_out_1),
	
	.S_bustorouter_data_in(S_bustorouter_data_in_1),
	.S_routertobus_data_out(S_routertobus_data_out_1),
	
	.l_bustorouter_valid_in(l_bustorouter_valid_in_1) , 
	.l_routertobus_ready_out(l_routertobus_ready_out_1), 
	.l_routertobus_valid_out(l_routertobus_valid_out_1), 
	.l_bustorouter_ready_in(l_bustorouter_ready_in_1) ,
	
	.N_bustorouter_valid_in(N_bustorouter_valid_in_1) , 
	.N_routertobus_ready_out(N_routertobus_ready_out_1), 
	.N_routertobus_valid_out(N_routertobus_valid_out_1), 
	.N_bustorouter_ready_in(N_bustorouter_ready_in_1) ,
	
	.S_bustorouter_valid_in(S_bustorouter_valid_in_1) , 
	.S_routertobus_ready_out(S_routertobus_ready_out_1), 
	.S_routertobus_valid_out(S_routertobus_valid_out_1), 
	.S_bustorouter_ready_in(S_bustorouter_ready_in_1) 
	);
	
	ROUTER4x1 r4x2 (.clk(clk), .reset_b(reset_b), 
	.local_input(local_input_2), 
	.local_output(local_output_2), 
	
	.X(X_2),
	.Y(Y_2),
 
	.N_bustorouter_data_in(N_bustorouter_data_in_2),
	.N_routertobus_data_out(N_routertobus_data_out_2),
	
	.S_bustorouter_data_in(S_bustorouter_data_in_2),
	.S_routertobus_data_out(S_routertobus_data_out_2),
	
	.l_bustorouter_valid_in(l_bustorouter_valid_in_2) , 
	.l_routertobus_ready_out(l_routertobus_ready_out_2), 
	.l_routertobus_valid_out(l_routertobus_valid_out_2), 
	.l_bustorouter_ready_in(l_bustorouter_ready_in_2) ,
	
	.N_bustorouter_valid_in(N_bustorouter_valid_in_2) , 
	.N_routertobus_ready_out(N_routertobus_ready_out_2), 
	.N_routertobus_valid_out(N_routertobus_valid_out_2), 
	.N_bustorouter_ready_in(N_bustorouter_ready_in_2) ,
	
	.S_bustorouter_valid_in(S_bustorouter_valid_in_2) , 
	.S_routertobus_ready_out(S_routertobus_ready_out_2), 
	.S_routertobus_valid_out(S_routertobus_valid_out_2), 
	.S_bustorouter_ready_in(S_bustorouter_ready_in_2) 
	);
	
	ROUTER4x1 r4x3 (.clk(clk), .reset_b(reset_b), 
	.local_input(local_input_3), 
	.local_output(local_output_3), 
	
	.X(X_3),
	.Y(Y_3),
 
	.N_bustorouter_data_in(N_bustorouter_data_in_3),
	.N_routertobus_data_out(N_routertobus_data_out_3),
	
	.S_bustorouter_data_in(S_bustorouter_data_in_3),
	.S_routertobus_data_out(S_routertobus_data_out_3),
	
	.l_bustorouter_valid_in(l_bustorouter_valid_in_3) , 
	.l_routertobus_ready_out(l_routertobus_ready_out_3), 
	.l_routertobus_valid_out(l_routertobus_valid_out_3), 
	.l_bustorouter_ready_in(l_bustorouter_ready_in_3) ,
	
	.N_bustorouter_valid_in(N_bustorouter_valid_in_3) , 
	.N_routertobus_ready_out(N_routertobus_ready_out_3), 
	.N_routertobus_valid_out(N_routertobus_valid_out_3), 
	.N_bustorouter_ready_in(N_bustorouter_ready_in_3) ,
	
	.S_bustorouter_valid_in(S_bustorouter_valid_in_3) , 
	.S_routertobus_ready_out(S_routertobus_ready_out_3), 
	.S_routertobus_valid_out(S_routertobus_valid_out_3), 
	.S_bustorouter_ready_in(S_bustorouter_ready_in_3) 
	);
	
	ROUTER4x1 r4x4 (.clk(clk), .reset_b(reset_b), 
	.local_input(local_input_4), 
	.local_output(local_output_4), 
	
	.X(X_4),
	.Y(Y_4),
 
	.N_bustorouter_data_in(N_bustorouter_data_in_4),
	.N_routertobus_data_out(N_routertobus_data_out_4),
	
	.S_bustorouter_data_in(S_bustorouter_data_in_4),
	.S_routertobus_data_out(S_routertobus_data_out_4),
	
	.l_bustorouter_valid_in(l_bustorouter_valid_in_4) , 
	.l_routertobus_ready_out(l_routertobus_ready_out_4), 
	.l_routertobus_valid_out(l_routertobus_valid_out_4), 
	.l_bustorouter_ready_in(l_bustorouter_ready_in_4) ,
	
	.N_bustorouter_valid_in(N_bustorouter_valid_in_4) , 
	.N_routertobus_ready_out(N_routertobus_ready_out_4), 
	.N_routertobus_valid_out(N_routertobus_valid_out_4), 
	.N_bustorouter_ready_in(N_bustorouter_ready_in_4) ,
	
	.S_bustorouter_valid_in(S_bustorouter_valid_in_4) , 
	.S_routertobus_ready_out(S_routertobus_ready_out_4), 
	.S_routertobus_valid_out(S_routertobus_valid_out_4), 
	.S_bustorouter_ready_in(S_bustorouter_ready_in_4) 
	);


endmodule
