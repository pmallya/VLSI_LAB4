module tb_priority_ripple;
	reg [7:0] A;
	wire [7:0] Y1;
			   	
	pr_encoder_ripple X1( .A(A),.Y(Y1));							  	
			   	
	initial begin  
		repeat(21) begin 
		A = $random ;
		#1 $monitor("A = %b	Y = %b",A, Y1);
		end
	end

endmodule
