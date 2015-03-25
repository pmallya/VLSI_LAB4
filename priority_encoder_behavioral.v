module prority_encoder (
	input [7:0] A,
    output [7:0] B);
	
	reg [3:0] pos;
	reg [7:0] B;
	
/*	reg [7:0] C;
	wire temp;
	reg [3:0]counter;
	assign temp = A[7];

	always @*  begin
	 while((pos >= 0) && ~temp) begin
		C = A << 1;
		temp = C[7];
		pos = pos - 1;
	 end 
	 end
end	   */

always @* begin
	if (A[7] == 1) pos = 8'd7;
	else if (A[6] == 1) pos = 8'd6;
	else if (A[5] == 1) pos = 8'd5;
	else if (A[4] == 1) pos = 8'd4;
	else if (A[3] == 1) pos = 8'd3;
	else if (A[2] == 1) pos = 8'd2;
	else if (A[1] == 1) pos = 8'd1;
	else if (A[0] == 1) pos = 8'd0;
end
	
always @* begin	
	case(pos)
		 0: B = 8'd1;
		 1: B = 8'd2;
		 2: B = 8'd4;
		 3: B = 8'd8;
		 4: B = 8'd16;
		 5: B = 8'd32;
		 6: B = 8'd64;
		 7: B = 8'd128;
    	default: B = 8'd0;
	endcase
end

endmodule
