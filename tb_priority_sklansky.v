module tb_sklansky;
	reg [7:0] A;
	wire [7:0] Y;
			   	
	pr_encoder_ripple X1( .A(A),.Y(Y));							  	
			   	
	initial begin  
		repeat(21) begin 
		A = $random ;
		#1 $monitor("A = %b	Y = %b",A, Y);
		end
	end

endmodule
