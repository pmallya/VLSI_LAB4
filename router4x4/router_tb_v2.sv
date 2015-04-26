 `timescale 1ns/1ns
 
  
module tb;

     parameter WIDTH = 16, DEPTH = 8,ADDR = 4;
     parameter N = 0, E = 1, S = 2, W = 3, L = 4;
//---------------------------------Port Declarations----------------------------------------------------------------- 
     bit clk;
     bit reset_b;
     logic [WIDTH-1:0] bustorouter_data[4:0];
     logic [4:0] bustorouter_valid;
     logic [1:0] X;
	   logic [1:0] Y;
	   logic [4:0] bustorouter_ready;
     logic [WIDTH-1:0] routertobus_data [4:0];
     logic [4:0] routertobus_valid;
     logic [4:0] routertobus_ready;
     logic pop[4:0],empty_out[4:0];
     logic [15:0] out[4:0];
     logic [15:0] memory[0:150];	 
	   integer i,j;
	   
// Your changes should be only in the instantiation below!! 
//use one of these here - pre-synthesis, post-synthesis, post-encounter module instantiation

//my module instantiation
 /* router1 r1x1 (clk, reset_b, bustorouter_data[0] , bustorouter_data[1] , bustorouter_data[2] ,
     bustorouter_data[3] , bustorouter_data[4] , bustorouter_valid[0] , bustorouter_valid[1] , bustorouter_valid[2] ,
     bustorouter_valid[3] , bustorouter_valid[4] , X, Y, bustorouter_ready[0] , bustorouter_ready[1] , bustorouter_ready[2],
	 bustorouter_ready[3] , bustorouter_ready[4] , routertobus_data[0] , routertobus_data[1] ,
     routertobus_data[2] , routertobus_data[3] , routertobus_data[4] , routertobus_valid[0] ,
     routertobus_valid[1] , routertobus_valid[2] , routertobus_valid[3] , routertobus_valid[4] , routertobus_ready[0] ,
     routertobus_ready[1] , routertobus_ready[2] , routertobus_ready[3] , routertobus_ready[4] );
   */  

ROUTER #(16,4)  r1x1 (.clk(clk), .reset_b(reset_b), .X(X), .Y(Y), .bustorouter_data(bustorouter_data), .bustorouter_valid(bustorouter_valid) ,.routertobus_ready(routertobus_ready), .routertobus_data(routertobus_data), .routertobus_valid(routertobus_valid), .bustorouter_ready(bustorouter_ready) );

//router_main r1x1 (clk,reset_b,bustorouter_data[4:0],bustorouter_valid[4:0],X[1:0],Y[1:0],bustorouter_ready[4:0],routertobus_data[4:0],routertobus_valid[4:0],routertobus_ready[4:0]) ;
 
//-----------------These FIFO's make your router a 1x2 structure , virtually from every side
     async_fifo_non_synth fifo_north_out(routertobus_valid[N], pop[N],clk,reset_b,routertobus_data[N],out[N],bustorouter_ready[N],empty_out[N]); 
     async_fifo_non_synth fifo_south_out(routertobus_valid[S], pop[S],clk,reset_b,routertobus_data[S],out[S],bustorouter_ready[S],empty_out[S]);
     async_fifo_non_synth fifo_east_out(routertobus_valid[E], pop[E],clk,reset_b,routertobus_data[E],out[E],bustorouter_ready[E],empty_out[E]);
     async_fifo_non_synth fifo_west_out(routertobus_valid[W], pop[W],clk,reset_b,routertobus_data[W],out[W],bustorouter_ready[W],empty_out[W]);
     async_fifo_non_synth fifo_local_out(routertobus_valid[L], pop[L],clk,reset_b,routertobus_data[L],out[L],bustorouter_ready[L],empty_out[L]);
	 
// R_to_Bus --  valid => push for fifo
// full -- bus_to_router_ready => pop for router 

     //-----------------------------------clock----------------------------------------------------------------------------- 
  initial begin
  forever #5 clk=~clk;
  end   
     
 initial begin
        //$readmemh("C:/Aldec/Riviera-PRO-2014.10-x64/vlsi_lab4/vlsi_lab4/packets.txt",memory);  //please insert your own path where you save packets.txt
  		$readmemh("C:/Users/pmallya/Desktop/234_758/packets.txt",memory);  
  end
  
       
 initial 
  begin
        reset_b=1;
        X=1;        // making your present router location (1,1)
        Y=1;
        i = 0;
        j = 0;
        bustorouter_valid[N]=0;
	      bustorouter_valid[S]=0;
	      bustorouter_valid[E]=0;
       	bustorouter_valid[W]=0;
	      bustorouter_valid[L]=0;
        @(negedge clk);
        reset_b=0;
			
    // [JB] -- What are these tests doing? 

        @(negedge clk); 
	      reset_b=1;   
	         
//---------------Packets start here ------------------------------------- 	
  
 //always @(negedge clk, negedge reset_b) begin
     			/* #10 bustorouter_valid[N] = 1'b1;
				  bustorouter_valid[E] = 1'b1;
				  bustorouter_valid[S] = 1'b1;
				  bustorouter_valid[W] = 1'b1;
				  bustorouter_valid[L] = 1'b1;
              bustorouter_data[N] = 16'h2913;
			  bustorouter_data[E] = 16'hA4FF;
			  bustorouter_data[S] = 16'h39EE;
			  bustorouter_data[W] = 16'hB500;//A911B500;
			  bustorouter_data[L] = 16'h5235; 
			 
     			#10
               bustorouter_data[N] = 16'h2210;
			  bustorouter_data[E] = 16'hA6F0;
			  bustorouter_data[S] = 16'h35E0;
			  bustorouter_data[W] = 16'hB901;
			  bustorouter_data[L] = 16'h5433; 
			  
			       			#10
               bustorouter_data[N] = 16'h1610;
			  bustorouter_data[E] = 16'h14F0;
			  bustorouter_data[S] = 16'h19E0;
			  bustorouter_data[W] = 16'h1501;
			  bustorouter_data[L] = 16'h1233; 
			      #5 bustorouter_valid[N] = 1'b0;
				  bustorouter_valid[E] = 1'b0;
				  bustorouter_valid[S] = 1'b0;
				  bustorouter_valid[W] = 1'b0;
				  bustorouter_valid[L] = 1'b0; */
			 // end 
			 
			   end

always @(negedge clk, negedge reset_b)
        begin
          if(reset_b)
            begin
        for(i=0;i<5;i=i+1)
          begin
            if(memory[j] != 16'h0000)
             begin
              bustorouter_valid[i] = 1'b1;
              bustorouter_data[i] = memory[j];
              end
            else
               bustorouter_valid[i] = 1'b0;
               j=j+1;
         end
		 
       end
       end
	          
endmodule
