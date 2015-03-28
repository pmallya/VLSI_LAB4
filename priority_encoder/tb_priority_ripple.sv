module tb_priority_ripple;
	logic [7:0] A;
	logic [7:0] Y1;
			   	
	pr_encoder_ripple X1( .A(A),.Y(Y1));							  	
		
  assert property (always@(A) $onehot(Y1))  else $error("Error: Your output Y=%b is not onehot", Y1);
  assert property (always@(A) ~$isunknown(Y1)) else $error("Error: Your output Y=%b has X or Z", Y1);
                        
	initial begin  
	                 
      		A = 8'b0;
		#1 $monitor("A = %b	Y = %b",A, Y1);
      
		repeat(21) begin 
			#1 A = $random ;
			#1 $monitor("A = %b	Y = %b",A, Y1);
		end		
		
		#1 A = 8'bx;
		#1 $monitor("A = %b	Y = %b",A, Y1);
		
		#1 A = 8'bz;
		#1 $monitor("A = %b	Y = %b",A, Y1);
		
		#1 A = 8'b0;
		#1 $monitor("A = %b	Y = %b",A, Y1);
         
                       
	end

endmodule
