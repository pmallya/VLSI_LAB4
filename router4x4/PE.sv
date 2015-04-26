module PE (
	input logic [3:0] A, // 8-bit input vector
	output logic [1:0] Y // 8-bit encoded output
); 

  // Input to PE only if conflict i.e when packet is to be sent to same destination port
  // N > E > S > W > L
  // MSB : LSB
  // MSB is North

always_comb
	priority case(1'b1)
		A[0]: Y = 2'd0;  // East
		A[1]: Y = 2'd1;  // South
		A[2]: Y = 2'd2;  // West
		A[3]: Y = 2'd3;  // Local Processor
		default: Y = 2'd0; //  If no conflict or if no packet to be sent why send 00 select line only??
	endcase
endmodule
