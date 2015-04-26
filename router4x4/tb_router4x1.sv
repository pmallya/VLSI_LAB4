`timescale 1ns/1ns

module tb_router4x1;

 bit clk;
 bit reset_b;
 
 logic [15:0] local_input [3:0];
 logic [15:0] local_output [3:0];
 
 logic [1:0] X [3:0];
 logic [1:0] Y [3:0];

 logic [3:0] bustorouter_valid ; // input valid signal
 logic [3:0] routertobus_ready ; // output ready signal
 
 logic [3:0] bustorouter_ready ;  // input ready signal
 logic [3:0] routertobus_valid ; // output valid signal

 logic [15:0] N_bustorouter_data_in [3:0] ; //packet data (input to locals of router)
 logic [15:0] S_bustorouter_data_in [3:0] ; //packet data (input to locals of router)

 logic [15:0] N_routertobus_data_out [3:0] ; // packet data (output from locals of router)
 logic [15:0] S_routertobus_data_out [3:0] ; // packet data (output from locals of router)

 logic [3:0] N_bustorouter_valid_in ; // input valid signal
 logic [3:0] N_routertobus_ready_out ; // output ready signal

 logic [3:0] N_routertobus_valid_out ;  // output valid signal
 logic [3:0] N_bustorouter_ready_in ;  // input ready signal

 logic [3:0] S_bustorouter_valid_in ; // input valid signal
 logic [3:0] S_routertobus_ready_out ; // output ready signal

 logic [3:0] S_routertobus_valid_out ;  // output valid signal
 logic [3:0] S_bustorouter_ready_in ;  // input ready signal

 parameter WIDTH = 16, DEPTH = 8,ADDR = 4;
 parameter N = 0, E = 1, S = 2, W = 3, L = 4;
//---------------------------------Port Declarations----------------------------------------------------------------- 
     logic pop[4:0],empty_out[4:0];
     logic [15:0] out[4:0];
     logic [15:0] memory[0:150];	 
	 integer i,j;
	   
	ROUTER4x1 r4x1 (.clk(clk), .reset_b(reset_b), 
	.local_input(local_input), 
	.local_output(local_output), 
 
 	.X(X),
	.Y(Y),
	
	.N_bustorouter_data_in(N_bustorouter_data_in),
	.N_routertobus_data_out(N_routertobus_data_out),
	
	.S_bustorouter_data_in(S_bustorouter_data_in),
	.S_routertobus_data_out(S_routertobus_data_out),
	
	.l_bustorouter_valid_in(bustorouter_valid) , 
	.l_routertobus_ready_out(routertobus_ready), 
	.l_routertobus_valid_out(routertobus_valid), 
	.l_bustorouter_ready_in(bustorouter_ready) ,
	
	.N_bustorouter_valid_in(N_bustorouter_valid_in) , 
	.N_routertobus_ready_out(N_routertobus_ready_out), 
	.N_routertobus_valid_out(N_routertobus_valid_out), 
	.N_bustorouter_ready_in(N_bustorouter_ready_in) ,
	
	.S_bustorouter_valid_in(S_bustorouter_valid_in) , 
	.S_routertobus_ready_out(S_routertobus_ready_out), 
	.S_routertobus_valid_out(S_routertobus_valid_out), 
	.S_bustorouter_ready_in(S_bustorouter_ready_in) 
	);



//-----------------These FIFO's make your router a 1x2 structure , virtually from every side
     async_fifo_non_synth fifo_north_out(routertobus_valid[N], pop[N],clk,reset_b,local_output[N],out[N],bustorouter_ready[N],empty_out[N]); 
     async_fifo_non_synth fifo_south_out(routertobus_valid[S], pop[S],clk,reset_b,local_output[S],out[S],bustorouter_ready[S],empty_out[S]);
     async_fifo_non_synth fifo_east_out(routertobus_valid[E], pop[E],clk,reset_b,local_output[E],out[E],bustorouter_ready[E],empty_out[E]);
     async_fifo_non_synth fifo_west_out(routertobus_valid[W], pop[W],clk,reset_b,local_output[W],out[W],bustorouter_ready[W],empty_out[W]);
	 
// R_to_Bus --  valid => push for fifo
// full -- bus_to_router_ready => pop for router 

     //-----------------------------------clock-----------------------------
  initial begin
  	forever #5 clk=~clk;
  end 
  
  initial begin
        reset_b=1;
       
        i = 0;
        j = 0;
		
        bustorouter_valid[0]=0;
	    bustorouter_valid[1]=0;
	    bustorouter_valid[2]=0;
       	bustorouter_valid[3]=0;
		
		N_bustorouter_valid_in[0]=0;
		N_bustorouter_valid_in[1]=0;
		N_bustorouter_valid_in[2]=0;
		N_bustorouter_valid_in[3]=0;
		
		S_bustorouter_valid_in[0]=0;
		S_bustorouter_valid_in[1]=0;
		S_bustorouter_valid_in[2]=0;
		S_bustorouter_valid_in[3]=0;
		
		X[0] = 2'd0; Y[0] = 2'd0;
		X[1] = 2'd1; Y[1] = 2'd0;
		X[2] = 2'd2; Y[2] = 2'd0;
		X[3] = 2'd3; Y[3] = 2'd0;
        
		@(negedge clk);
        reset_b=0;
			
    // [JB] -- What are these tests doing? 

        @(negedge clk); 
	      reset_b=1;   
	   // end 
	//---------------Packets start here ------------------------------------- 	
	 @(negedge clk, negedge reset_b) begin
     					
			bustorouter_valid[0] = 1'b1;
	    	bustorouter_valid[1] = 1'b1;
		    bustorouter_valid[2] = 1'b1;
	       	bustorouter_valid[3] = 1'b1;
						
			local_input[0] = 16'h2411;
		    local_input[1] = 16'h2811;
			local_input[2] = 16'h2C11;
			local_input[3] = 16'h2011;
			
			N_bustorouter_data_in[0] = 16'h0;
			N_bustorouter_data_in[1] = 16'h0;
			N_bustorouter_data_in[2] = 16'h0;
			N_bustorouter_data_in[3] = 16'h0;
			
			S_bustorouter_data_in[0] = 16'h0;
			S_bustorouter_data_in[1] = 16'h0;
			S_bustorouter_data_in[2] = 16'h0;
			S_bustorouter_data_in[3] = 16'h0;
			
			#5
			bustorouter_valid[0] = 1'b0;
			bustorouter_valid[1] = 1'b0;
		    bustorouter_valid[2] = 1'b0;
	       	bustorouter_valid[3] = 1'b0;
		end	
		
		@(negedge clk) begin
			
			bustorouter_valid[0] = 1'b1;
			bustorouter_valid[1] = 1'b1;
		    bustorouter_valid[2] = 1'b1;
	       	bustorouter_valid[3] = 1'b1;
			
			local_input[0] = 16'h2C22;
			local_input[1] = 16'h2022;
			local_input[2] = 16'h2422;
			local_input[3] = 16'h2822; 
			
			#10
			bustorouter_valid[0] = 1'b0;
			bustorouter_valid[1] = 1'b0;
		    bustorouter_valid[2] = 1'b0;
	       	bustorouter_valid[3] = 1'b0; 
		end
		
		@(negedge clk) begin
			
			bustorouter_valid[0] = 1'b1;
			bustorouter_valid[1] = 1'b1;
		    bustorouter_valid[2] = 1'b1;
	       	bustorouter_valid[3] = 1'b1;
			
			local_input[0] = 16'h2833;
			local_input[1] = 16'h2C33;
			local_input[2] = 16'h2033;
			local_input[3] = 16'h2433; 
			
			#10
			bustorouter_valid[0] = 1'b0;
			bustorouter_valid[1] = 1'b0;
		    bustorouter_valid[2] = 1'b0;
	       	bustorouter_valid[3] = 1'b0; 
		end
		
		@(negedge clk) begin
			
			bustorouter_valid[0] = 1'b1;
			bustorouter_valid[1] = 1'b1;
		    bustorouter_valid[2] = 1'b1;
	       	bustorouter_valid[3] = 1'b1;
			
			local_input[0] = 16'h2440;
			local_input[1] = 16'h2041;
			local_input[2] = 16'h2042;
			local_input[3] = 16'h2043; 
			
			#10
			bustorouter_valid[0] = 1'b0;
			bustorouter_valid[1] = 1'b0;
		    bustorouter_valid[2] = 1'b0;
	       	bustorouter_valid[3] = 1'b0; 
		end
		
		@(negedge clk) begin
			
			bustorouter_valid[0] = 1'b1;
			bustorouter_valid[1] = 1'b1;
		    bustorouter_valid[2] = 1'b1;
	       	bustorouter_valid[3] = 1'b1;
			
			local_input[0] = 16'h2855;
			local_input[1] = 16'h2C55;
			local_input[2] = 16'h2055;
			local_input[3] = 16'h2855; 
			
			#10
			bustorouter_valid[0] = 1'b0;
			bustorouter_valid[1] = 1'b0;
		    bustorouter_valid[2] = 1'b0;
	       	bustorouter_valid[3] = 1'b0; 
		end
		
		@(negedge clk) begin
			
			bustorouter_valid[0] = 1'b1;
			bustorouter_valid[1] = 1'b1;
		    bustorouter_valid[2] = 1'b1;
	       	bustorouter_valid[3] = 1'b1;
			
			local_input[0] = 16'h2460;
			local_input[1] = 16'h2361;
			local_input[2] = 16'h2462;
			local_input[3] = 16'h2063; 
			
			#10
			bustorouter_valid[0] = 1'b0;
			bustorouter_valid[1] = 1'b0;
		    bustorouter_valid[2] = 1'b0;
	       	bustorouter_valid[3] = 1'b0; 
		end
end
endmodule
