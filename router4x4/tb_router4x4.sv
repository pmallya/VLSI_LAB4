`timescale 1ns/1ns

module tb_router4x4;

 bit clk;
 bit reset_b;
 
 logic [15:0] src_input [15:0];
 logic [15:0] dest_output [15:0];
 
 logic [1:0] X [15:0];
 logic [1:0] Y [15:0];

 logic [15:0] bustorouter_valid ; // input valid signal
 logic [15:0] routertobus_ready ; // output ready signal

 logic [15:0] routertobus_valid;  // output valid signal
 logic [15:0] bustorouter_ready;  // input ready signal



 parameter WIDTH = 16, DEPTH = 8,ADDR = 4;
 parameter N = 0, E = 1, S = 2, W = 3, L = 4;
//---------------------------------Port Declarations----------------------------------------------------------------- 
     logic pop[15:0],empty_out[15:0];
     logic [15:0] out[15:0];
     logic [15:0] memory[0:150];	 
	 integer i,j;
	   
	ROUTER4x4 final_4x4 (.clk(clk), .reset_b(reset_b), 
						.X(X), 
						.Y(Y),
						.src_input(src_input),
						.dest_output(dest_output),
						.src_bustorouter_valid_in(bustorouter_valid),
						.src_routertobus_ready_out(routertobus_ready),
						.dest_routertobus_valid_out(routertobus_valid),
						.dest_bustorouter_ready_in(bustorouter_ready)   );


//-----------------These FIFO's make your router a 1x2 structure , virtually from every side
     async_fifo_non_synth fifo_L0(routertobus_valid[0], pop[0],clk,reset_b,dest_output[0],out[0],bustorouter_ready[0],empty_out[0]); 
     async_fifo_non_synth fifo_L1(routertobus_valid[1], pop[1],clk,reset_b,dest_output[1],out[1],bustorouter_ready[1],empty_out[1]);
     async_fifo_non_synth fifo_L3(routertobus_valid[2], pop[2],clk,reset_b,dest_output[2],out[2],bustorouter_ready[2],empty_out[2]);
     async_fifo_non_synth fifo_L4(routertobus_valid[3], pop[3],clk,reset_b,dest_output[3],out[3],bustorouter_ready[3],empty_out[3]);
	 async_fifo_non_synth fifo_L5(routertobus_valid[4], pop[4],clk,reset_b,dest_output[4],out[4],bustorouter_ready[4],empty_out[4]); 
     async_fifo_non_synth fifo_L6(routertobus_valid[5], pop[5],clk,reset_b,dest_output[5],out[5],bustorouter_ready[5],empty_out[5]);
     async_fifo_non_synth fifo_L7(routertobus_valid[6], pop[6],clk,reset_b,dest_output[6],out[6],bustorouter_ready[6],empty_out[6]);
     async_fifo_non_synth fifo_L8(routertobus_valid[7], pop[7],clk,reset_b,dest_output[7],out[7],bustorouter_ready[7],empty_out[7]);
	 async_fifo_non_synth fifo_L9(routertobus_valid[8], pop[8],clk,reset_b,dest_output[8],out[8],bustorouter_ready[8],empty_out[8]); 
     async_fifo_non_synth fifo_L10(routertobus_valid[9], pop[9],clk,reset_b,dest_output[9],out[9],bustorouter_ready[9],empty_out[9]);
     async_fifo_non_synth fifo_L11(routertobus_valid[10], pop[10],clk,reset_b,dest_output[10],out[10],bustorouter_ready[10],empty_out[10]);
     async_fifo_non_synth fifo_L12(routertobus_valid[11], pop[11],clk,reset_b,dest_output[11],out[11],bustorouter_ready[11],empty_out[11]);
	 async_fifo_non_synth fifo_L13(routertobus_valid[12], pop[12],clk,reset_b,dest_output[12],out[12],bustorouter_ready[12],empty_out[12]); 
     async_fifo_non_synth fifo_L14(routertobus_valid[13], pop[13],clk,reset_b,dest_output[13],out[13],bustorouter_ready[13],empty_out[13]);
     async_fifo_non_synth fifo_L15(routertobus_valid[14], pop[14],clk,reset_b,dest_output[14],out[14],bustorouter_ready[14],empty_out[14]);
     async_fifo_non_synth fifo_L16(routertobus_valid[15], pop[15],clk,reset_b,dest_output[15],out[15],bustorouter_ready[15],empty_out[15]);
	 
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
		bustorouter_valid[4]=0;
	    bustorouter_valid[5]=0;
	    bustorouter_valid[6]=0;
       	bustorouter_valid[7]=0;
		bustorouter_valid[8]=0;
	    bustorouter_valid[9]=0;
	    bustorouter_valid[10]=0;
       	bustorouter_valid[11]=0;
		bustorouter_valid[12]=0;
	    bustorouter_valid[13]=0;
	    bustorouter_valid[14]=0;
       	bustorouter_valid[15]=0;

		
		X[0] = 2'd0; Y[0] = 2'd0;
		X[1] = 2'd1; Y[1] = 2'd0;
		X[2] = 2'd2; Y[2] = 2'd0;
		X[3] = 2'd3; Y[3] = 2'd0;
        
		X[4] = 2'd0; Y[4] = 2'd1;
		X[5] = 2'd1; Y[5] = 2'd1;
		X[6] = 2'd2; Y[6] = 2'd1;
		X[7] = 2'd3; Y[7] = 2'd1;
		
		X[8] = 2'd0; Y[8] = 2'd2;
		X[9] = 2'd1; Y[9] = 2'd2;
		X[10] = 2'd2; Y[10] = 2'd2;
		X[11] = 2'd3; Y[11] = 2'd2;
		
		X[12] = 2'd0; Y[12] = 2'd3;
		X[13] = 2'd1; Y[13] = 2'd3;
		X[14] = 2'd2; Y[14] = 2'd3;
		X[15] = 2'd3; Y[15] = 2'd3;
		
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
			bustorouter_valid[4] = 1'b1;
		    bustorouter_valid[5] = 1'b1;
		    bustorouter_valid[6] = 1'b1;
	       	bustorouter_valid[7] = 1'b1;
			bustorouter_valid[8] = 1'b1;
		    bustorouter_valid[9] = 1'b1;
		    bustorouter_valid[10] = 1'b1;
	       	bustorouter_valid[11] = 1'b1;
			bustorouter_valid[12] = 1'b1;
		    bustorouter_valid[13] = 1'b1;
		    bustorouter_valid[14] = 1'b1;
	       	bustorouter_valid[15] = 1'b1;
						
			src_input[0] = 16'h0110;
		    src_input[1] = 16'h1811;
			src_input[2] = 16'h1C12;
			src_input[3] = 16'h3213;
			src_input[4] = 16'h4710;
		    src_input[5] = 16'h2811;
			src_input[6] = 16'h2C12;
			src_input[7] = 16'h2013;
			src_input[8] = 16'h3410;
		    src_input[9] = 16'h3811;
			src_input[10] = 16'h3C12;
			src_input[11] = 16'h3013;
			src_input[12] = 16'h4410;
		    src_input[13] = 16'h4811;
			src_input[14] = 16'h4C12;
			src_input[15] = 16'h4013;
			
			#5
			bustorouter_valid[0] = 1'b0;
			bustorouter_valid[1] = 1'b0;
		    bustorouter_valid[2] = 1'b0;
	       	bustorouter_valid[3] = 1'b0;
			bustorouter_valid[4] = 1'b0;
		    bustorouter_valid[5] = 1'b0;
		    bustorouter_valid[6] = 1'b0;
	       	bustorouter_valid[7] = 1'b0;
			bustorouter_valid[8] = 1'b0;
		    bustorouter_valid[9] = 1'b0;
		    bustorouter_valid[10] = 1'b0;
	       	bustorouter_valid[11] = 1'b0;
			bustorouter_valid[12] = 1'b0;
		    bustorouter_valid[13] = 1'b0;
		    bustorouter_valid[14] = 1'b0;
	       	bustorouter_valid[15] = 1'b0;
		end	
		
		@(negedge clk) begin
			
			bustorouter_valid[0] = 1'b1;
	    	bustorouter_valid[1] = 1'b1;
		    bustorouter_valid[2] = 1'b1;
	       	bustorouter_valid[3] = 1'b1;
			bustorouter_valid[4] = 1'b1;
		    bustorouter_valid[5] = 1'b1;
		    bustorouter_valid[6] = 1'b1;
	       	bustorouter_valid[7] = 1'b1;
			bustorouter_valid[8] = 1'b1;
		    bustorouter_valid[9] = 1'b1;
		    bustorouter_valid[10] = 1'b1;
	       	bustorouter_valid[11] = 1'b1;
			bustorouter_valid[12] = 1'b1;
		    bustorouter_valid[13] = 1'b1;
		    bustorouter_valid[14] = 1'b1;
	       	bustorouter_valid[15] = 1'b1;
			
			src_input[0] = 16'h1C20;
			src_input[1] = 16'h1021;
			src_input[2] = 16'h1422;
			src_input[3] = 16'h1823;
			src_input[4] = 16'h2C20;
		    src_input[5] = 16'h2021;
			src_input[6] = 16'h2422;
			src_input[7] = 16'h2823;
			src_input[8] = 16'h2C20;
		    src_input[9] = 16'h3011;
			src_input[10] = 16'h3412;
			src_input[11] = 16'h3813;
			src_input[12] = 16'h4C10;
		    src_input[13] = 16'h4011;
			src_input[14] = 16'h4412;
			src_input[15] = 16'h4813;
			
			#5
			bustorouter_valid[0] = 1'b0;
			bustorouter_valid[1] = 1'b0;
		    bustorouter_valid[2] = 1'b0;
	       	bustorouter_valid[3] = 1'b0;
			bustorouter_valid[4] = 1'b0;
		    bustorouter_valid[5] = 1'b0;
		    bustorouter_valid[6] = 1'b0;
	       	bustorouter_valid[7] = 1'b0;
			bustorouter_valid[8] = 1'b0;
		    bustorouter_valid[9] = 1'b0;
		    bustorouter_valid[10] = 1'b0;
	       	bustorouter_valid[11] = 1'b0;
			bustorouter_valid[12] = 1'b0;
		    bustorouter_valid[13] = 1'b0;
		    bustorouter_valid[14] = 1'b0;
	       	bustorouter_valid[15] = 1'b0;
		end
		
		@(negedge clk) begin
			
			bustorouter_valid[0] = 1'b1;
	    	bustorouter_valid[1] = 1'b1;
		    bustorouter_valid[2] = 1'b1;
	       	bustorouter_valid[3] = 1'b1;
			bustorouter_valid[4] = 1'b1;
		    bustorouter_valid[5] = 1'b1;
		    bustorouter_valid[6] = 1'b1;
	       	bustorouter_valid[7] = 1'b1;
			bustorouter_valid[8] = 1'b1;
		    bustorouter_valid[9] = 1'b1;
		    bustorouter_valid[10] = 1'b1;
	       	bustorouter_valid[11] = 1'b1;
			bustorouter_valid[12] = 1'b1;
		    bustorouter_valid[13] = 1'b1;
		    bustorouter_valid[14] = 1'b1;
	       	bustorouter_valid[15] = 1'b1;
			
			src_input[0] = 16'h1830;
			src_input[1] = 16'h1C31;
			src_input[2] = 16'h1032;
			src_input[3] = 16'h1433;
			src_input[4] = 16'h2820;
		    src_input[5] = 16'h2C21;
			src_input[6] = 16'h2022;
			src_input[7] = 16'h2423;
			src_input[8] = 16'h2820;
		    src_input[9] = 16'h3C11;
			src_input[10] = 16'h3012;
			src_input[11] = 16'h3413;
			src_input[12] = 16'h4810;
		    src_input[13] = 16'h4C11;
			src_input[14] = 16'h4012;
			src_input[15] = 16'h4413;
			
			
			#5
			bustorouter_valid[0] = 1'b0;
			bustorouter_valid[1] = 1'b0;
		    bustorouter_valid[2] = 1'b0;
	       	bustorouter_valid[3] = 1'b0;
			bustorouter_valid[4] = 1'b0;
		    bustorouter_valid[5] = 1'b0;
		    bustorouter_valid[6] = 1'b0;
	       	bustorouter_valid[7] = 1'b0;
			bustorouter_valid[8] = 1'b0;
		    bustorouter_valid[9] = 1'b0;
		    bustorouter_valid[10] = 1'b0;
	       	bustorouter_valid[11] = 1'b0;
			bustorouter_valid[12] = 1'b0;
		    bustorouter_valid[13] = 1'b0;
		    bustorouter_valid[14] = 1'b0;
	       	bustorouter_valid[15] = 1'b0; 
		end
		
		@(negedge clk) begin
			
			bustorouter_valid[0] = 1'b1;
	    	bustorouter_valid[1] = 1'b1;
		    bustorouter_valid[2] = 1'b1;
	       	bustorouter_valid[3] = 1'b1;
			bustorouter_valid[4] = 1'b1;
		    bustorouter_valid[5] = 1'b1;
		    bustorouter_valid[6] = 1'b1;
	       	bustorouter_valid[7] = 1'b1;
			bustorouter_valid[8] = 1'b1;
		    bustorouter_valid[9] = 1'b1;
		    bustorouter_valid[10] = 1'b1;
	       	bustorouter_valid[11] = 1'b1;
			bustorouter_valid[12] = 1'b1;
		    bustorouter_valid[13] = 1'b1;
		    bustorouter_valid[14] = 1'b1;
	       	bustorouter_valid[15] = 1'b1;
			
			src_input[0] = 16'h1440;
			src_input[1] = 16'h1041;
			src_input[2] = 16'h1042;
			src_input[3] = 16'h1043;
			src_input[4] = 16'h2420;
		    src_input[5] = 16'h2021;
			src_input[6] = 16'h2022;
			src_input[7] = 16'h2023;
			src_input[8] = 16'h2420;
		    src_input[9] = 16'h3011;
			src_input[10] = 16'h3012;
			src_input[11] = 16'h3013;
			src_input[12] = 16'h4410;
		    src_input[13] = 16'h4011;
			src_input[14] = 16'h4012;
			src_input[15] = 16'h4013;
			
			#5
			bustorouter_valid[0] = 1'b0;
			bustorouter_valid[1] = 1'b0;
		    bustorouter_valid[2] = 1'b0;
	       	bustorouter_valid[3] = 1'b0;
			bustorouter_valid[4] = 1'b0;
		    bustorouter_valid[5] = 1'b0;
		    bustorouter_valid[6] = 1'b0;
	       	bustorouter_valid[7] = 1'b0;
			bustorouter_valid[8] = 1'b0;
		    bustorouter_valid[9] = 1'b0;
		    bustorouter_valid[10] = 1'b0;
	       	bustorouter_valid[11] = 1'b0;
			bustorouter_valid[12] = 1'b0;
		    bustorouter_valid[13] = 1'b0;
		    bustorouter_valid[14] = 1'b0;
	       	bustorouter_valid[15] = 1'b0; 
		end
		
		@(negedge clk) begin
			
			bustorouter_valid[0] = 1'b1;
	    	bustorouter_valid[1] = 1'b1;
		    bustorouter_valid[2] = 1'b1;
	       	bustorouter_valid[3] = 1'b1;
			bustorouter_valid[4] = 1'b1;
		    bustorouter_valid[5] = 1'b1;
		    bustorouter_valid[6] = 1'b1;
	       	bustorouter_valid[7] = 1'b1;
			bustorouter_valid[8] = 1'b1;
		    bustorouter_valid[9] = 1'b1;
		    bustorouter_valid[10] = 1'b1;
	       	bustorouter_valid[11] = 1'b1;
			bustorouter_valid[12] = 1'b1;
		    bustorouter_valid[13] = 1'b1;
		    bustorouter_valid[14] = 1'b1;
	       	bustorouter_valid[15] = 1'b1;
			
			src_input[0] = 16'h1850;
			src_input[1] = 16'h1C51;
			src_input[2] = 16'h1052;
			src_input[3] = 16'h1853;
			src_input[4] = 16'h2820;
		    src_input[5] = 16'h2C21;
			src_input[6] = 16'h2022;
			src_input[7] = 16'h2823;
			src_input[8] = 16'h2820;
		    src_input[9] = 16'h3C11;
			src_input[10] = 16'h3012;
			src_input[11] = 16'h3813;
			src_input[12] = 16'h4810;
		    src_input[13] = 16'h4C11;
			src_input[14] = 16'h4012;
			src_input[15] = 16'h4813;
			
			#5
			bustorouter_valid[0] = 1'b0;
			bustorouter_valid[1] = 1'b0;
		    bustorouter_valid[2] = 1'b0;
	       	bustorouter_valid[3] = 1'b0;
			bustorouter_valid[4] = 1'b0;
		    bustorouter_valid[5] = 1'b0;
		    bustorouter_valid[6] = 1'b0;
	       	bustorouter_valid[7] = 1'b0;
			bustorouter_valid[8] = 1'b0;
		    bustorouter_valid[9] = 1'b0;
		    bustorouter_valid[10] = 1'b0;
	       	bustorouter_valid[11] = 1'b0;
			bustorouter_valid[12] = 1'b0;
		    bustorouter_valid[13] = 1'b0;
		    bustorouter_valid[14] = 1'b0;
	       	bustorouter_valid[15] = 1'b0;
		end
		
		@(negedge clk) begin
			
			bustorouter_valid[0] = 1'b1;
	    	bustorouter_valid[1] = 1'b1;
		    bustorouter_valid[2] = 1'b1;
	       	bustorouter_valid[3] = 1'b1;
			bustorouter_valid[4] = 1'b1;
		    bustorouter_valid[5] = 1'b1;
		    bustorouter_valid[6] = 1'b1;
	       	bustorouter_valid[7] = 1'b1;
			bustorouter_valid[8] = 1'b1;
		    bustorouter_valid[9] = 1'b1;
		    bustorouter_valid[10] = 1'b1;
	       	bustorouter_valid[11] = 1'b1;
			bustorouter_valid[12] = 1'b1;
		    bustorouter_valid[13] = 1'b1;
		    bustorouter_valid[14] = 1'b1;
	       	bustorouter_valid[15] = 1'b1;
			
			src_input[0] = 16'h1460;
			src_input[1] = 16'h1361;
			src_input[2] = 16'h1462;
			src_input[3] = 16'h1063;
			src_input[4] = 16'h2420;
		    src_input[5] = 16'h2321;
			src_input[6] = 16'h2422;
			src_input[7] = 16'h2023;
			src_input[8] = 16'h2420;
		    src_input[9] = 16'h3311;
			src_input[10] = 16'h3412;
			src_input[11] = 16'h3013;
			src_input[12] = 16'h4410;
		    src_input[13] = 16'h4311;
			src_input[14] = 16'h4412;
			src_input[15] = 16'h4013;
			
			#5
			bustorouter_valid[0] = 1'b0;
			bustorouter_valid[1] = 1'b0;
		    bustorouter_valid[2] = 1'b0;
	       	bustorouter_valid[3] = 1'b0;
			bustorouter_valid[4] = 1'b0;
		    bustorouter_valid[5] = 1'b0;
		    bustorouter_valid[6] = 1'b0;
	       	bustorouter_valid[7] = 1'b0;
			bustorouter_valid[8] = 1'b0;
		    bustorouter_valid[9] = 1'b0;
		    bustorouter_valid[10] = 1'b0;
	       	bustorouter_valid[11] = 1'b0;
			bustorouter_valid[12] = 1'b0;
		    bustorouter_valid[13] = 1'b0;
		    bustorouter_valid[14] = 1'b0;
	       	bustorouter_valid[15] = 1'b0;
		end
end
endmodule
