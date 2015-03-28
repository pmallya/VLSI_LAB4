module pr_encoder_ripple
	# (parameter wordLen = 8)
	(input [wordLen-1:0] A,
	output [wordLen -1:0] Y);							  
	
	wire X1_1, X2_1, X3_1, X4_1, X5_1, X6_1;
	
assign X6_7 = ~A[7] & ~A[6];
assign X5_7 = X6_7 & ~A[5];
assign X4_7 = X5_7 & ~A[4];
assign X3_7 = X4_7 & ~A[3];
assign X2_7 = X3_7 & ~A[2];
assign X1_7 = X2_7 & ~A[1];

assign Y[7] = A[7];
assign Y[6] = ~A[7] & A[6];
assign Y[5] = X6_7 & A[5];
assign Y[4] = X5_7 & A[4];
assign Y[3] = X4_7 & A[3];
assign Y[2] = X3_7 & A[2];
assign Y[1] = X2_7 & A[1];
assign Y[0] = X1_7 & A[0];

endmodule
