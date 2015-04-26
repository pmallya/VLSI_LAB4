module ROUTER4x1 #(WL = 16, ADDR = 4)(
input logic clk,
input logic reset_b,

input logic [1:0] X [3:0],
input logic [1:0] Y [3:0],

input logic [WL -1 : 0] local_input [3:0],
output logic [WL -1 : 0] local_output [3:0],

input logic [WL -1 : 0] N_bustorouter_data_in [3:0], //packet data (input to locals of router)
output logic [WL -1 : 0] N_routertobus_data_out [3:0], // packet data (output from locals of router)

input logic [WL -1 : 0] S_bustorouter_data_in [3:0], //packet data (input to locals of router)
output logic [WL -1 : 0] S_routertobus_data_out [3:0], // packet data (output from locals of router)

input logic [3:0] l_bustorouter_valid_in , // input valid signal
output logic [3:0] l_routertobus_ready_out , // output ready signal

output logic [3:0] l_routertobus_valid_out,  // output valid signal
input logic [3:0] l_bustorouter_ready_in ,  // input ready signal

input logic [3:0] N_bustorouter_valid_in , // input valid signal
output logic [3:0] N_routertobus_ready_out , // output ready signal

output logic [3:0] N_routertobus_valid_out,  // output valid signal
input logic [3:0] N_bustorouter_ready_in ,  // input ready signal

input logic [3:0] S_bustorouter_valid_in , // input valid signal
output logic [3:0] S_routertobus_ready_out , // output ready signal

output logic [3:0] S_routertobus_valid_out,  // output valid signal
input logic [3:0] S_bustorouter_ready_in ,  // input ready signal

);

// All bustorouter_valid inputs each 5 bit 
 logic [4:0] bustorouter_valid_0 ; // input valid signal
 logic [4:0] bustorouter_valid_1 ; // input valid signal
 logic [4:0] bustorouter_valid_2 ; // input valid signal
 logic [4:0] bustorouter_valid_3 ; // input valid signal
  
// All routertobus_ready outputs each 5 bit
 logic [4:0] routertobus_ready_0 ;
 logic [4:0] routertobus_ready_1 ; 
 logic [4:0] routertobus_ready_2 ; 
 logic [4:0] routertobus_ready_3 ; 
 
// All routertobus_valid outputs each 5 bit
 logic [4:0] routertobus_valid_0 ;
 logic [4:0] routertobus_valid_1 ;
 logic [4:0] routertobus_valid_2 ;
 logic [4:0] routertobus_valid_3 ;
 
//All bustorouter_ready inputs each 5 bit
 logic [4:0] bustorouter_ready_0 ; // input ready signal
 logic [4:0] bustorouter_ready_1 ;
 logic [4:0] bustorouter_ready_2 ;
 logic [4:0] bustorouter_ready_3 ;

 
// East to West of 0 output signals
 logic [WL -1 : 0] routertobus_data_0 [4:0]; // packet data (output from router)
 logic [WL -1 : 0] bustorouter_data_0 [4:0]; //packet data (input to router)
 
 logic [WL -1 : 0] routertobus_data_1 [4:0]; // packet data (output from router)
 logic [WL -1 : 0] bustorouter_data_1 [4:0]; //packet data (input to router)
 
 logic [WL -1 : 0] routertobus_data_2 [4:0]; // packet data (output from router)
 logic [WL -1 : 0] bustorouter_data_2 [4:0]; //packet data (input to router) 
 
 logic [WL -1 : 0] routertobus_data_3 [4:0]; // packet data (output from router)
 logic [WL -1 : 0] bustorouter_data_3 [4:0]; //packet data (input to router)

//----------------------------------------------------------------------------------
//Local Inputs to Local of each router
//----------------------------------------------------------------------------------

// bustorouter to Local_in -- 0 to 0
assign bustorouter_data_0[4] = local_input[0];
assign bustorouter_valid_0[4] = l_bustorouter_valid_in[0];
assign l_routertobus_ready_out[0] = routertobus_ready_0[4];

// bustorouter to Local_in -- 1 to 1
assign bustorouter_data_1[4] = local_input[1];
assign bustorouter_valid_1[4] = l_bustorouter_valid_in[1];
assign l_routertobus_ready_out[1] = routertobus_ready_1[4];

// bustorouter to Local_in -- 2 to 2
assign bustorouter_data_2[4] = local_input[2];
assign bustorouter_valid_2[4] = l_bustorouter_valid_in[2];
assign l_routertobus_ready_out[2] = routertobus_ready_2[4];

// bustorouter to Local_in -- 3 to 3
assign bustorouter_data_3[4] = local_input[3];
assign bustorouter_valid_3[4] = l_bustorouter_valid_in[3];
assign l_routertobus_ready_out[3] = routertobus_ready_2[4];

//----------------------------------------------------------------------------------
//Local Outputs to Local of each router
//----------------------------------------------------------------------------------

// Local to Local_out -- 0 to 0
assign local_output[0] = routertobus_data_0[4];
assign l_routertobus_valid_out[0] = routertobus_valid_0[4];
assign bustorouter_ready_0[4] = l_bustorouter_ready_in[0];

// Local to Local_out -- 1 to 1
assign local_output[1] = routertobus_data_1[4];
assign l_routertobus_valid_out[1] = routertobus_valid_1[4];
assign bustorouter_ready_1[4] = l_bustorouter_ready_in[1];

// Local to Local_out -- 2 to 2
assign local_output[2] = routertobus_data_2[4];
assign l_routertobus_valid_out[2] = routertobus_valid_2[4];
assign bustorouter_ready_2[4] = l_bustorouter_ready_in[2];

// Local to Local_out -- 3 to 3
assign local_output[3] = routertobus_data_3[4];
assign l_routertobus_valid_out[3] = routertobus_valid_3[4];
assign bustorouter_ready_3[4] = l_bustorouter_ready_in[3];


//----------------------------------------------------------------------------------
//East to West Connection of each router
//----------------------------------------------------------------------------------

// East to West -- 0 to 1
assign bustorouter_data_1[3] = routertobus_data_0[1];
assign bustorouter_valid_1[3] = routertobus_valid_0[1];
assign bustorouter_ready_0[1] = routertobus_ready_1[3];

// East to West -- 1 to 2
assign bustorouter_data_2[3] = routertobus_data_1[1];
assign bustorouter_valid_2[3] = routertobus_valid_1[1];
assign bustorouter_ready_1[1] = routertobus_ready_2[3];

// East to West -- 2 to 3
assign bustorouter_data_3[3] = routertobus_data_2[1];
assign bustorouter_valid_3[3] = routertobus_valid_2[1];
assign bustorouter_ready_2[1] = routertobus_ready_3[3];

// East to West -- 3 to 0
assign bustorouter_data_0[3] = routertobus_data_3[1];
assign bustorouter_valid_0[3] = routertobus_valid_3[1];
assign bustorouter_ready_3[1] = routertobus_ready_0[3];

//----------------------------------------------------------------------------------
//West to East Connection of each router
//----------------------------------------------------------------------------------

// West to East -- 1 to 0
assign bustorouter_data_0[1] = routertobus_data_1[3];
assign bustorouter_valid_0[1] = routertobus_valid_1[3];
assign bustorouter_ready_1[3] = routertobus_ready_0[1];

// West to East -- 2 to 1
assign bustorouter_data_1[1] = routertobus_data_2[3];
assign bustorouter_valid_1[1] = routertobus_valid_2[3];
assign bustorouter_ready_2[3] = routertobus_ready_1[1];

// West to East -- 3 to 2
assign bustorouter_data_2[1] = routertobus_data_3[3];
assign bustorouter_valid_2[1] = routertobus_valid_3[3];
assign bustorouter_ready_3[3] = routertobus_ready_2[1];

// West to East -- 0 to 3
assign bustorouter_data_3[1] = routertobus_data_0[3];
assign bustorouter_valid_3[1] = routertobus_valid_0[3];
assign bustorouter_ready_0[3] = routertobus_ready_3[1];

//----------------------------------------------------------------------------------
// North to North Input Connection of each router
//----------------------------------------------------------------------------------
// N_bustorouter to North in -- 0 to 0
assign bustorouter_data_0[0] = N_bustorouter_data_in[0];
assign bustorouter_valid_0[0] = N_bustorouter_valid_in[0];
assign N_routertobus_ready_out[0] = routertobus_ready_0[0];

// N_bustorouter to North in -- 1 to 1
assign bustorouter_data_1[0] = N_bustorouter_data_in[1];
assign bustorouter_valid_1[0] = N_bustorouter_valid_in[1];
assign N_routertobus_ready_out[1] = routertobus_ready_1[0];

// N_bustorouter to North in -- 2 to 2
assign bustorouter_data_2[0] = N_bustorouter_data_in[2];
assign bustorouter_valid_2[0] = N_bustorouter_valid_in[2];
assign N_routertobus_ready_out[2] = routertobus_ready_2[0];

// N_bustorouter to North in -- 3 to 3
assign bustorouter_data_3[0] = N_bustorouter_data_in[3];
assign bustorouter_valid_3[0] = N_bustorouter_valid_in[3];
assign N_routertobus_ready_out[3] = routertobus_ready_3[0];

//----------------------------------------------------------------------------------
// North to North Output Connection of each router
//----------------------------------------------------------------------------------
// North to N_routertobus_data -- 0 to 0
assign N_routertobus_data_out[0] = routertobus_data_0[0];
assign N_routertobus_valid_out[0] = routertobus_valid_0[0];
assign bustorouter_ready_0[0] = N_bustorouter_ready_in[0];

// Local to Local_out -- 1 to 1
assign N_routertobus_data_out[1] = routertobus_data_1[0];
assign N_routertobus_valid_out[1] = routertobus_valid_1[0];
assign bustorouter_ready_1[0] = N_bustorouter_ready_in[1];

// Local to Local_out -- 2 to 2
assign N_routertobus_data_out[2] = routertobus_data_2[0];
assign N_routertobus_valid_out[2] = routertobus_valid_2[0];
assign bustorouter_ready_2[0] = N_bustorouter_ready_in[2];

// Local to Local_out -- 3 to 3
assign N_routertobus_data_out[3] = routertobus_data_3[0];
assign N_routertobus_valid_out[3] = routertobus_valid_3[0];
assign bustorouter_ready_3[0] = N_bustorouter_ready_in[3];


//----------------------------------------------------------------------------------
// South to South Input Connection of each router
//----------------------------------------------------------------------------------

// S_bustorouter to South in -- 0 to 0
assign bustorouter_data_0[2] = S_bustorouter_data_in[0];
assign bustorouter_valid_0[2] = S_bustorouter_valid_in[0];
assign S_routertobus_ready_out[0] = routertobus_ready_0[2];

// S_bustorouter to South in -- 1 to 1
assign bustorouter_data_1[2] = S_bustorouter_data_in[1];
assign bustorouter_valid_1[2] = S_bustorouter_valid_in[1];
assign S_routertobus_ready_out[1] = routertobus_ready_1[2];

// S_bustorouter to South in -- 2 to 2
assign bustorouter_data_2[2] = S_bustorouter_data_in[2];
assign bustorouter_valid_2[2] = S_bustorouter_valid_in[2];
assign S_routertobus_ready_out[2] = routertobus_ready_2[2];

// S_bustorouter to South in -- 3 to 3
assign bustorouter_data_3[2] = S_bustorouter_data_in[3];
assign bustorouter_valid_3[2] = S_bustorouter_valid_in[3];
assign S_routertobus_ready_out[3] = routertobus_ready_3[2];

//----------------------------------------------------------------------------------
// South to South Output Connectionof each router
//----------------------------------------------------------------------------------
 
 // South to S_routertobus_data -- 0 to 0
assign S_routertobus_data_out[0] = routertobus_data_0[2];
assign S_routertobus_valid_out[0] = routertobus_valid_0[2];
assign bustorouter_ready_0[2] = S_bustorouter_ready_in[0];

// South to S_routertobus_data -- 1 to 1
assign S_routertobus_data_out[1] = routertobus_data_1[2];
assign S_routertobus_valid_out[1] = routertobus_valid_1[2];
assign bustorouter_ready_1[2] = S_bustorouter_ready_in[1];

// South to S_routertobus_data -- 2 to 2
assign S_routertobus_data_out[2] = routertobus_data_2[2];
assign S_routertobus_valid_out[2] = routertobus_valid_2[2];
assign bustorouter_ready_2[2] = S_bustorouter_ready_in[2];

// South to S_routertobus_data -- 3 to 3
assign S_routertobus_data_out[3] = routertobus_data_3[2];
assign S_routertobus_valid_out[3] = routertobus_valid_3[2];
assign bustorouter_ready_3[2] = S_bustorouter_ready_in[3];

//----------------------------------------------------------------------------------
// Router to Router Connections
//----------------------------------------------------------------------------------

 ROUTER r0x0 (.clk(clk), .reset_b(reset_b), .X(X[0]), .Y(Y[0]), 
						 .bustorouter_data ( bustorouter_data_0  ),
						 .bustorouter_valid( bustorouter_valid_0 ), 
						 .routertobus_ready( routertobus_ready_0 ),
						 .routertobus_data ( routertobus_data_0  ),
						 .routertobus_valid( routertobus_valid_0 ),
						 .bustorouter_ready( bustorouter_ready_0 ) );


 ROUTER r1x0 (.clk(clk), .reset_b(reset_b), .X(X[1]), .Y(Y[1]), 
						 .bustorouter_data ( bustorouter_data_1  ),
						 .bustorouter_valid( bustorouter_valid_1 ), 
						 .routertobus_ready( routertobus_ready_1 ),
						 .routertobus_data ( routertobus_data_1  ),
						 .routertobus_valid( routertobus_valid_1 ),
						 .bustorouter_ready( bustorouter_ready_1 ) );
	
						 
 ROUTER r2x0 (.clk(clk), .reset_b(reset_b), .X(X[2]), .Y(Y[2]), 
						 .bustorouter_data ( bustorouter_data_2  ),
						 .bustorouter_valid( bustorouter_valid_2 ), 
						 .routertobus_ready( routertobus_ready_2 ),
						 .routertobus_data ( routertobus_data_2  ),
						 .routertobus_valid( routertobus_valid_2 ),
						 .bustorouter_ready( bustorouter_ready_2 ) );
						 
						 
 ROUTER r3x0 (.clk(clk), .reset_b(reset_b), .X(X[3]), .Y(Y[3]), 
						 .bustorouter_data ( bustorouter_data_3  ),
						 .bustorouter_valid( bustorouter_valid_3 ), 
						 .routertobus_ready( routertobus_ready_3 ),
						 .routertobus_data ( routertobus_data_3  ),
						 .routertobus_valid( routertobus_valid_3 ),
						 .bustorouter_ready( bustorouter_ready_3 ) );

endmodule
