module flexswitch
	#(
	parameter int wL = 16,
	parameter int lhsCount = 4,
	parameter int rhsCount = 4,
	parameter int srcAddr  = $clog2(lhsCount)
	)(
	input logic [wL-1:0] data_left[lhsCount-1:0],
	input logic [srcAddr-1:0] data_right_src_addr[rhsCount-1:0],
	
	input logic rst,
	input logic clk,	
	
	output logic [wL-1:0] data_right[rhsCount-1:0]
	);	

logic [wL-1:0] data_left_internal[lhsCount-1:0];
logic [srcAddr-1:0] data_right_src_addr_internal[rhsCount-1:0];
logic [wL-1:0] data_right_internal[rhsCount-1:0];
genvar i;

dff_multi #(lhsCount,wL) X_dff_left (data_left, clk, rst, 1'b1, data_left_internal);

dff_multi #(rhsCount,srcAddr) X_dff_sel (data_right_src_addr, clk, rst, 1'b1, data_right_src_addr_internal);

generate
for( i = 0 ; i < rhsCount ; i = i+1) begin: loop_rhs	

mux4 #(wL) X_mux (data_right_internal[i], data_left_internal, data_right_src_addr_internal[i]);

end
endgenerate

dff_multi #(rhsCount,wL) X_dff_right (data_right_internal, clk, rst, 1'b1, data_right);

endmodule //flexSwitch

module dff_multi
    #(parameter  size = 4, 
       parameter  wordLen = 16)
(
      input  [wordLen-1:0] din_multi[size-1:0], 
      input  clk, 
      input  rst, 
     // input  [wordLen-1:0] rst_val[size-1:0],
      input  en, 
      output  [wordLen-1:0] q[size-1:0]
);
      genvar i ;
 
	  //Brunhaver code. Testing needed. Rst_valand en purpose unknown
      generate
         for( i = 0 ; i < size ; i= i+1 ) begin: loop_c 
             dff_single #( wordLen ) dnnn( din_multi[i] , clk, rst, en, q[i] );
         end 
       endgenerate 

endmodule //dff2

module dff_single #(parameter int wordLen = 1 )
(
	input logic [wordLen-1:0] din,
    input logic clk,
    input logic rst,
   // input logic [wordLen-1:0] rst_val,
    input logic en,
    output logic [wordLen-1:0] q
    );
 	 
    logic [wordLen-1:0] d ;
    bit [wordLen-1:0] q_val; //FlipFlop State
                 
    assign d[wordLen-1:0] = din[wordLen-1:0]; //Delay data in to prevent inf. loops
    assign q = q_val ;
 
    always @ (posedge clk) begin //Flops CLK
//    	assert ( ~$isunknown(d) || ~rst ) else $error("Error:d is X or Z") ; //Do Not Flop an X
 
    	priority case ( 1'b1 )
    		(~rst): q_val[wordLen-1:0] <= 0 ; //Reset is active low
        	( en): q_val[wordLen-1:0] <= d[wordLen-1:0] ; //Enable is active high
        	(~en): q_val[wordLen-1:0] <= q[wordLen-1:0] ; //Enable is active high
    	endcase //end priority case
    end //end always_ff
 
endmodule //dff

module mux4
 #( /*parameter int unsigned noOfInputs = 4,*/
 parameter int wordLen = 16 
 )( 
 output logic [wordLen-1:0] out,
 input logic [wordLen-1:0] in[3:0], 
 input logic [1:0] sel
);
		
    always_comb	begin
    priority case(sel) 
		2'd0:  out = in[0];
		2'd1:  out = in[1];
		2'd2:  out = in[2];
		2'd3:  out = in[3];
		default: out = 8'd0;
		endcase
    end
endmodule

/* module mux4 #(parameter int wordLen = 16) 
	(sel, A, Y);
input logic [1:0] sel; 
input logic [wordLen-1:0] A[3:0];
output logic Y;


always @* begin

if (sel[0] == 0)
   if (sel[1] == 0) Y = A[0];
   else Y = A[1];
else
   if (sel[1] == 0) Y = A[2];
   else Y = A[3];
end
endmodule	   */
