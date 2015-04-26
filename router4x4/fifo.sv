module FIFO 
	#(parameter int wL = 16,
	  parameter int d = 8 ) 
	
   (input logic [wL-1:0] data_push,
	output logic [wL-1:0] data_pop,
	
	input logic push, // increment write pointer 
	input logic pop, // increment read pointer
	
	output logic full,
	output logic almost_full_next, //sh will cause full next cycle
	output logic empty,
//utput logic almost_empty, // a pop will cause empty next cycle
	
	input logic rst,
	input logic clk
	);
	
	 // $
	 // pooja - need to check which one is the right one to use .. with or without logic
	parameter  addL = $clog2(d); // $
	
	logic [wL-1:0]  mem[d-1:0];
	logic [addL-1:0] wrtPtr, wrtPtr_next;
	logic [addL-1:0] rdPtr, rdPtr_next;	 
	logic [addL:0] cnt;
	
	assign data_pop = mem[rdPtr];
	
	always_comb begin
	    if(~rst) begin
		   full = 0;
		   empty = 1;
		   almost_full_next = 0;
		   //most_empty = 0;
		end else begin
		    if ((cnt == 4'd8) && (wrtPtr == rdPtr)) full = 1;
			else           							full = 0;
		    if ((cnt == 4'd0) && (wrtPtr == rdPtr)) empty = 1;
			else            						empty= 0;
			if (cnt == 4'd6) almost_full_next = 1;
			else             almost_full_next = 0;
			// (cnt == 4'd1) almost_empty = 1;
			//se          almost_empty = 0;
		end
	end
	
	always_ff @(posedge clk) begin
		if (~rst) begin
			wrtPtr <= 0;
			// for loop to reset the memory
			for (int i=0;i<d;i=i+1) begin
				mem[i] <= 0;
			end
		end
		else begin	  
			// write into FIFO when read is 0
			if (push && ~full) begin
				mem[wrtPtr] <= data_push;
     			wrtPtr <= wrtPtr_next;
			end else if (push && pop && ~full) begin
				mem[wrtPtr] <= data_push;
     			wrtPtr <= wrtPtr_next;
			end else if (~push && ~pop) begin
     			wrtPtr <= wrtPtr_next;
				end  
		end
		end
				
		always_ff @(posedge clk) begin
				if (~rst) begin
					rdPtr <= 0;
				end
			// READ from FIFO and pop is 1
		else begin 	
				if (pop && ~empty) begin
				 	rdPtr <= rdPtr_next;
				end else if (push && pop) begin
					rdPtr <= rdPtr_next;
				end else if (~push && ~pop) begin
					rdPtr <= rdPtr_next;
				end  
			end
		end
		
	always_ff @( posedge clk ) begin
  		if( ~rst ) 
    		cnt <= 0;
  		else begin
    		priority case ({push,pop})
      			2'b00 : cnt <= cnt;
      			2'b01 :  if ((cnt==4'd0))  cnt <= cnt;
						 else cnt <= cnt-1; 
      			2'b10 :  if ((cnt==4'd8)) cnt <= cnt;
				         else cnt <= cnt+1; 
      			2'b11 :  begin 
				         if ((cnt == 4'd8)) cnt <= cnt-1;
				         else if (cnt == 4'd0) cnt <= cnt + 1;
						 else cnt <= cnt;
						 end
      			 default: cnt <= cnt;
    		endcase 
  		end
	end

	always_comb begin 
		if (~rst) begin
			wrtPtr_next = 0;
			rdPtr_next = 0;	
		end
		else begin 
			wrtPtr_next = (push && ~full)? wrtPtr + 1 : wrtPtr;
	  		rdPtr_next = (pop && ~empty)? rdPtr + 1 : rdPtr;
			if (~pop && ~push) begin
     			wrtPtr_next = wrtPtr;
				rdPtr_next = rdPtr;
			end
		end		 	
	end
	
	
endmodule
