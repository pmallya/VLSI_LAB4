// Priority encoder
module priority_encoder (A, Y);
input [7:0] A; // 8-bit input vector
output [7:0] Y; // 8-bit encoded output
reg [7:0] Y; // target of assignment

always @(A)
 case(1'b1)
 A[7]: Y = 8'd128;
 A[6]: Y = 8'd64;
 A[5]: Y = 8'd32;
 A[4]: Y = 8'd16;
 A[3]: Y = 8'd8;
 A[2]: Y = 8'd4;
 A[1]: Y = 8'd2;
 A[0]: Y = 8'd1;
 default: Y = 8'd0; // Don?t care when input is all 0?s
 endcase
endmodule
