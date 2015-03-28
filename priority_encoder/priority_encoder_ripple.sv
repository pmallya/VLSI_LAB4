module pr_encoder_sklansky
# (parameter int wordLen = 8)
(
input logic [wordLen-1:0] A,
output logic [wordLen -1:0] Y
);
	
	logic X7_6, X7_5, X7_4, X7_3, X7_2, X7_1, X5_4, X3_2, X3_1;
	
	assign X7_6 = ~A[7] & ~A[6];
	assign X5_4 = ~A[5] & ~A[4];
	assign X3_2 = ~A[3] & ~A[2];

	assign X7_5 = X7_6 & ~A[5];
	assign X7_4 = X7_6 & X5_4;
	assign X3_1 = X3_2 & ~A[1];

	assign X7_3 = X7_4 & ~A[3];
	assign X7_2 = X7_4 & X3_2;
	assign X7_1 = X7_4 & X3_1;

	assign Y[7] = A[7];
	assign Y[6] = ~A[7] & A[6];
	assign Y[5] = X7_6 & A[5];
	assign Y[4] = X7_5 & A[4];
	assign Y[3] = X7_4 & A[3];
	assign Y[2] = X7_3 & A[2];
	assign Y[1] = X7_2 & A[1];
	assign Y[0] = X7_1 & A[0];

endmodule
