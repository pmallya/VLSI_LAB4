module ROUTER #(WL = 16, ADDR = 4)(
input logic clk,
input logic reset_b,
input logic [1:0] X, //X coordinate
input logic [1:0] Y, // Y coordinate
input logic [WL -1 : 0] bustorouter_data [4:0], //packet data (input to router)
input logic [4:0] bustorouter_valid , // input valid signal
output logic [4:0] routertobus_ready , // output ready signal
output logic [WL -1 : 0] routertobus_data [4:0], // packet data (output from router)
output logic [4:0] routertobus_valid, // output valid signal
input logic [4:0] bustorouter_ready  // input ready signal
);

logic full_N, full_E,full_S,full_W,full_L;
logic almost_full_next_N, almost_full_next_E, almost_full_next_S, almost_full_next_W, almost_full_next_L;
logic empty_N, empty_E, empty_S, empty_W, empty_L;
logic push_N, push_E, push_S, push_W,push_L; 
logic pop_N, pop_E, pop_S, pop_W, pop_L;  

logic [WL-1:0] data_pop_fifo_out [ADDR:0];
logic [WL-1:0] data_pop_fifo_out_temp [ADDR:0];
logic  [4:0] en ;
logic [1:0] dest_N_x, dest_N_y, dest_S_x, dest_S_y, dest_E_x, dest_E_y, dest_W_x, dest_W_y, dest_L_x, dest_L_y;
logic [1:0] data_right_src_addr [4:0];
logic  [4:0] routertobus_valid_internal ; 
logic  [4:0] routertobus_valid_internal1 ;
logic [3:0] flag_N, flag_E, flag_S, flag_W, flag_L;
logic [1:0] sel_N, sel_E, sel_S, sel_W, sel_L;

// At the input side of the router 
always_comb begin

	if (bustorouter_valid[0]) begin
   		push_N = 1;
	end else begin
   		push_N = 0;
	end
	
   if (~almost_full_next_N) begin
   		routertobus_ready[0] = 0;
	end else begin
   		routertobus_ready[0] = 1;
	end

	if (bustorouter_valid[1]) begin
   		push_E = 1;
	end else begin
   		push_E = 0;
	end
	
	if (~almost_full_next_E) begin
   		routertobus_ready[1] = 0;
	end else begin
   		routertobus_ready[1] = 1;
	end

	if (bustorouter_valid[2]) begin
   		push_S = 1;
	end else begin
   		push_S = 0;
	end
	
	if (~almost_full_next_S) begin
   		routertobus_ready[2] = 0;
	end else begin
   		routertobus_ready[2] = 1;
	end

	if (bustorouter_valid[3]) begin
   		push_W = 1;
	end else begin
   		push_W = 0;
	end

	if (~almost_full_next_W) begin
   		routertobus_ready[3] = 0;
	end else begin
   		routertobus_ready[3] = 1;
	end
	
	if (bustorouter_valid[4]) begin
   		push_L = 1;
	end else begin
   		push_L = 0;
	end
	
	if (~almost_full_next_L) begin
   		routertobus_ready[4] = 0;
	end else begin
   		routertobus_ready[4] = 1;
	end
	
end

// FIFO 
FIFO fifo_N (.data_push (bustorouter_data[0]), .data_pop (data_pop_fifo_out[0]), . push(push_N), .pop(pop_N), .rst(reset_b), .clk(clk), .full(full_N), .empty(empty_N), .almost_full_next(almost_full_next_N) );
FIFO fifo_E (.data_push (bustorouter_data[1]), .data_pop (data_pop_fifo_out[1]), . push(push_E), .pop(pop_E), .rst(reset_b), .clk(clk), .full(full_E), .empty(empty_E), .almost_full_next(almost_full_next_E) );
FIFO fifo_S (.data_push (bustorouter_data[2]), .data_pop (data_pop_fifo_out[2]), . push(push_S), .pop(pop_S), .rst(reset_b), .clk(clk), .full(full_S), .empty(empty_S), .almost_full_next(almost_full_next_S) );
FIFO fifo_W (.data_push (bustorouter_data[3]), .data_pop (data_pop_fifo_out[3]), . push(push_W), .pop(pop_W), .rst(reset_b), .clk(clk), .full(full_W), .empty(empty_W), .almost_full_next(almost_full_next_W) );
FIFO fifo_L (.data_push (bustorouter_data[4]), .data_pop (data_pop_fifo_out[4]), . push(push_L), .pop(pop_L), .rst(reset_b), .clk(clk), .full(full_L), .empty(empty_L), .almost_full_next(almost_full_next_L) );

// Arbiter
arbiter X_arbiter (.X(X), .Y(Y), .empty_N(empty_N), .empty_E(empty_E), .empty_S(empty_S), .empty_W(empty_W), .empty_L(empty_L), .dest_N_x(dest_N_x), .dest_N_y(dest_N_y), .dest_S_x(dest_S_x), .dest_S_y(dest_S_y), .dest_E_x(dest_E_x), .dest_E_y(dest_E_y), .dest_W_x(dest_W_x), .dest_W_y(dest_W_y), .dest_L_x(dest_L_x), .dest_L_y(dest_L_y), .sel_N(sel_N), .sel_E(sel_E), .sel_S(sel_S), .sel_W(sel_W), .sel_L(sel_L), .flag_N(flag_N), .flag_E(flag_E), .flag_S(flag_S), .flag_W(flag_W), .flag_L(flag_L));

// Flex switch - Mux with FF
flexswitch #(16, 5, 5, 2) X_fs (.data_left(data_pop_fifo_out_temp),.data_right_src_addr(data_right_src_addr), .rst(reset_b), .clk(clk), .en(en), .data_right(routertobus_data) );	

always_ff @(posedge clk) begin
      if (~reset_b) begin
	     routertobus_valid <= 5'd0;
	  end else begin
	     routertobus_valid <= routertobus_valid_internal1;
	  end
end

always_ff @(posedge clk) begin
      if (~reset_b) begin
	     routertobus_valid_internal1 <= 5'd0;
	  end else begin
		 routertobus_valid_internal1 <= routertobus_valid_internal;
	  end
end

/*
always_ff @(posedge clk) begin
      if (~reset_b) begin
	     bustorouter_ready <= 5'd0;
	  end else begin
	     bustorouter_ready <= bustorouter_ready_1;
	  end
end

always_ff @(posedge clk) begin
      if (~reset_b) begin
	     bustorouter_ready_1 <= 5'd0;
	  end else begin
		 bustorouter_ready_1 <= bustorouter_ready;
	  end
end
*/
// To extract the desination address
always_comb begin
if (~reset_b) begin
    pop_N = 0;
	pop_E = 0; 
	pop_S = 0;
	pop_W = 0;
	pop_L = 0;
end else begin

if(~empty_N) begin
   dest_N_x =  data_pop_fifo_out[0][11:10];
   dest_N_y =  data_pop_fifo_out[0][9:8];
   data_pop_fifo_out_temp[0] = data_pop_fifo_out[0]; 
end 
else begin 
	pop_N = 0;
	data_pop_fifo_out_temp[0] = 0;
	//dest_N_x = 0;
	//dest_N_y = 0;
end

if(~empty_E) begin
    dest_E_x =  data_pop_fifo_out[1][11:10];
    dest_E_y =  data_pop_fifo_out[1][9:8];
	data_pop_fifo_out_temp[1] = data_pop_fifo_out[1]; 
end 
else begin 
	pop_E = 0;
	data_pop_fifo_out_temp[1] = 0;
	//dest_E_x = 0;
	//dest_E_y = 0;
end

if(~empty_S) begin
    dest_S_x =  data_pop_fifo_out[2][11:10];
    dest_S_y =  data_pop_fifo_out[2][9:8];
	data_pop_fifo_out_temp[2] = data_pop_fifo_out[2]; 
end 
else begin
	pop_S = 0;
	data_pop_fifo_out_temp[2] = 0;
	//dest_S_x = 0;
	//dest_S_y = 0;
end

if(~empty_W) begin
   dest_W_x =  data_pop_fifo_out[3][11:10];
   dest_W_y =  data_pop_fifo_out[3][9:8];
   data_pop_fifo_out_temp[3] = data_pop_fifo_out[3]; 
end 
else begin
	data_pop_fifo_out_temp[3] = 0;
	pop_W = 0;
	//dest_W_x = 0;
	//dest_W_y = 0;
end

if(~empty_L) begin
   dest_L_x =  data_pop_fifo_out[4][11:10];
   dest_L_y =  data_pop_fifo_out[4][9:8];
   data_pop_fifo_out_temp[4] = data_pop_fifo_out[4]; 
end 
else begin 
	data_pop_fifo_out_temp[4] = 0;
	pop_L = 0;
	//dest_L_x =0;
	//dest_L_y = 0;
end

// North only
if (flag_N) begin 
    routertobus_valid_internal[0] =1;
	en[0] = 1;
	data_right_src_addr[0] = 0;
	if(~bustorouter_ready[0]) begin
       	// en[0] = 1;
		// routertobus_valid_internal[0] =1;
	     data_right_src_addr[0] = sel_N;
	    if((flag_E[0] == 1 && sel_E == 2'd0) || (flag_S[0] == 1 && sel_S == 2'd0) || (flag_W[0] == 1 && sel_W == 2'd0) || (flag_L[0] == 1 && sel_L == 2'd0)) pop_N = 1;
			else pop_N = 0;
	    if((flag_N[0] == 1 && sel_N == 2'd0) || (flag_S[1] == 1 && sel_S == 2'd1) || (flag_W[1] == 1 && sel_W == 2'd1) || (flag_L[1] == 1 && sel_L == 2'd1)) pop_E = 1;
			else pop_E = 0;
	    if((flag_N[1] == 1 && sel_N == 2'd1) || (flag_E[1] == 1 && sel_E == 2'd1) || (flag_W[2] == 1 && sel_W == 2'd2) || (flag_L[2] == 1 && sel_L == 2'd2)) pop_S = 1;
			else pop_S = 0;
	    if((flag_N[2] == 1 && sel_N == 2'd2) || (flag_E[2] == 1 && sel_E == 2'd2) || (flag_S[2] == 1 && sel_S == 2'd2) || (flag_L[3] == 1 && sel_L == 2'd3)) pop_W = 1;
			else pop_W = 0;
	    if((flag_N[3] == 1 && sel_N == 2'd3) || (flag_E[3] == 1 && sel_E == 2'd3) || (flag_S[3] == 1 && sel_S == 2'd3) || (flag_W[3] == 1 && sel_W == 2'd3)) pop_L = 1;
			else pop_L = 0;
	end else begin
        en[0] = 0;
	    data_right_src_addr[0] = 0;
		routertobus_valid_internal[0] = 0; 
		if (sel_N == 2'd0) pop_E = 0; 
	    if (sel_N == 2'd1) pop_S = 0;
	    if (sel_N == 2'd2) pop_W = 0;
	    if (sel_N == 2'd3) pop_L = 0;
	end
end else begin
	en[0] = 0;
	routertobus_valid_internal[0] = 0;
	data_right_src_addr[0] = 0;
end

// East only
if (flag_E ) begin
     routertobus_valid_internal[1] =1; 
	 en[1] = 1;
	 data_right_src_addr[1] = 0;
	 if (~bustorouter_ready[1]) begin
       data_right_src_addr[1] = sel_E;
	    routertobus_valid_internal[1] =1;
	     en[1] = 1;
	   	if((flag_E[0] == 1 && sel_E == 2'd0) || (flag_S[0] == 1 && sel_S == 2'd0) || (flag_W[0] == 1 && sel_W == 2'd0) || (flag_L[0] == 1 && sel_L == 2'd0)) pop_N = 1;
			else pop_N = 0;
	    if((flag_N[0] == 1 && sel_N == 2'd0) || (flag_S[1] == 1 && sel_S == 2'd1) || (flag_W[1] == 1 && sel_W == 2'd1) || (flag_L[1] == 1 && sel_L == 2'd1)) pop_E = 1;
			else pop_E = 0;
	    if((flag_N[1] == 1 && sel_N == 2'd1) || (flag_E[1] == 1 && sel_E == 2'd1) || (flag_W[2] == 1 && sel_W == 2'd2) || (flag_L[2] == 1 && sel_L == 2'd2)) pop_S = 1;
			else pop_S = 0;
	    if((flag_N[2] == 1 && sel_N == 2'd2) || (flag_E[2] == 1 && sel_E == 2'd2) || (flag_S[2] == 1 && sel_S == 2'd2) || (flag_L[3] == 1 && sel_L == 2'd3)) pop_W = 1;
			else pop_W = 0;
	    if((flag_N[3] == 1 && sel_N == 2'd3) || (flag_E[3] == 1 && sel_E == 2'd3) || (flag_S[3] == 1 && sel_S == 2'd3) || (flag_W[3] == 1 && sel_W == 2'd3)) pop_L = 1;
			else pop_L = 0;	    
	end else begin
	   en[1] = 0;
	   data_right_src_addr[1] = 0;
	   routertobus_valid_internal[1] = 0; 
	   if (sel_E == 2'd0) pop_N = 0;
	   if (sel_E == 2'd1) pop_S = 0;
	   if (sel_E == 2'd2) pop_W = 0;
	   if (sel_E == 2'd3) pop_L = 0;
    end

end else begin
	en[1] = 0;
	routertobus_valid_internal[1] = 0;
	data_right_src_addr[1] = 0;
end 

// South only
if (flag_S) begin
   	  routertobus_valid_internal[2] =1;
	  en[2] = 1;
	  data_right_src_addr[2] = 0;
      if (~bustorouter_ready[2]) begin
        en[2] = 1;
		routertobus_valid_internal[2] =1;
        data_right_src_addr[2] = sel_S;
	    	    if((flag_E[0] == 1 && sel_E == 2'd0) || (flag_S[0] == 1 && sel_S == 2'd0) || (flag_W[0] == 1 && sel_W == 2'd0) || (flag_L[0] == 1 && sel_L == 2'd0)) pop_N = 1;
			else pop_N = 0;
	    if((flag_N[0] == 1 && sel_N == 2'd0) || (flag_S[1] == 1 && sel_S == 2'd1) || (flag_W[1] == 1 && sel_W == 2'd1) || (flag_L[1] == 1 && sel_L == 2'd1)) pop_E = 1;
			else pop_E = 0;
	    if((flag_N[1] == 1 && sel_N == 2'd1) || (flag_E[1] == 1 && sel_E == 2'd1) || (flag_W[2] == 1 && sel_W == 2'd2) || (flag_L[2] == 1 && sel_L == 2'd2)) pop_S = 1;
			else pop_S = 0;
	    if((flag_N[2] == 1 && sel_N == 2'd2) || (flag_E[2] == 1 && sel_E == 2'd2) || (flag_S[2] == 1 && sel_S == 2'd2) || (flag_L[3] == 1 && sel_L == 2'd3)) pop_W = 1;
			else pop_W = 0;
	    if((flag_N[3] == 1 && sel_N == 2'd3) || (flag_E[3] == 1 && sel_E == 2'd3) || (flag_S[3] == 1 && sel_S == 2'd3) || (flag_W[3] == 1 && sel_W == 2'd3)) pop_L = 1;
			else pop_L = 0;
	  end else begin
	    en[2] = 0;
	    data_right_src_addr[2] = 0;
		routertobus_valid_internal[2] =0;
	    if (sel_S == 2'd0) pop_N = 0;
	    if (sel_S == 2'd1) pop_E = 0;
	    if (sel_S == 2'd2) pop_W = 0;
	    if (sel_S == 2'd3) pop_L = 0;
	  end 
end else begin
	en[2] = 0;
	routertobus_valid_internal[2] = 0;
	data_right_src_addr[2] = 0;
end 

// West only
if (flag_W) begin
	 routertobus_valid_internal[3] =1;
	 en[3] = 1;
	 data_right_src_addr[3] = 0;
     if (~bustorouter_ready[3]) begin
        en[3] = 1;
		routertobus_valid_internal[3] =1;
        data_right_src_addr[3] = sel_W;
	    	    if((flag_E[0] == 1 && sel_E == 2'd0) || (flag_S[0] == 1 && sel_S == 2'd0) || (flag_W[0] == 1 && sel_W == 2'd0) || (flag_L[0] == 1 && sel_L == 2'd0)) pop_N = 1;
			else pop_N = 0;
	    if((flag_N[0] == 1 && sel_N == 2'd0) || (flag_S[1] == 1 && sel_S == 2'd1) || (flag_W[1] == 1 && sel_W == 2'd1) || (flag_L[1] == 1 && sel_L == 2'd1)) pop_E = 1;
			else pop_E = 0;
	    if((flag_N[1] == 1 && sel_N == 2'd1) || (flag_E[1] == 1 && sel_E == 2'd1) || (flag_W[2] == 1 && sel_W == 2'd2) || (flag_L[2] == 1 && sel_L == 2'd2)) pop_S = 1;
			else pop_S = 0;
	    if((flag_N[2] == 1 && sel_N == 2'd2) || (flag_E[2] == 1 && sel_E == 2'd2) || (flag_S[2] == 1 && sel_S == 2'd2) || (flag_L[3] == 1 && sel_L == 2'd3)) pop_W = 1;
			else pop_W = 0;
	    if((flag_N[3] == 1 && sel_N == 2'd3) || (flag_E[3] == 1 && sel_E == 2'd3) || (flag_S[3] == 1 && sel_S == 2'd3) || (flag_W[3] == 1 && sel_W == 2'd3)) pop_L = 1;
			else pop_L = 0;
	  end else  begin
	    en[3] = 0;
	    data_right_src_addr[3] = 0;
		routertobus_valid_internal[3] = 0;
	    if (sel_W == 2'd0) pop_N = 0;
		if (sel_W == 2'd1) pop_E = 0;
		if (sel_W == 2'd2) pop_S = 0;
		if (sel_W == 2'd3) pop_L = 0; 
	  end
end else begin
	en[3] = 0;
	routertobus_valid_internal[3] = 0;
	data_right_src_addr[3] = 0;
end

// Local only
if (flag_L) begin
 	  routertobus_valid_internal[4] =1;
	  en[4] = 1;
	  data_right_src_addr[4] = 0;
	  if (~bustorouter_ready[4]) begin
      // en[4] = 1;
	  // routertobus_valid_internal[4] =1;
       data_right_src_addr[4] = sel_L;
	   	    if((flag_E[0] == 1 && sel_E == 2'd0) || (flag_S[0] == 1 && sel_S == 2'd0) || (flag_W[0] == 1 && sel_W == 2'd0) || (flag_L[0] == 1 && sel_L == 2'd0)) pop_N = 1;
			else pop_N = 0;
	    if((flag_N[0] == 1 && sel_N == 2'd0) || (flag_S[1] == 1 && sel_S == 2'd1) || (flag_W[1] == 1 && sel_W == 2'd1) || (flag_L[1] == 1 && sel_L == 2'd1)) pop_E = 1;
			else pop_E = 0;
	    if((flag_N[1] == 1 && sel_N == 2'd1) || (flag_E[1] == 1 && sel_E == 2'd1) || (flag_W[2] == 1 && sel_W == 2'd2) || (flag_L[2] == 1 && sel_L == 2'd2)) pop_S = 1;
			else pop_S = 0;
	    if((flag_N[2] == 1 && sel_N == 2'd2) || (flag_E[2] == 1 && sel_E == 2'd2) || (flag_S[2] == 1 && sel_S == 2'd2) || (flag_L[3] == 1 && sel_L == 2'd3)) pop_W = 1;
			else pop_W = 0;
	    if((flag_N[3] == 1 && sel_N == 2'd3) || (flag_E[3] == 1 && sel_E == 2'd3) || (flag_S[3] == 1 && sel_S == 2'd3) || (flag_W[3] == 1 && sel_W == 2'd3)) pop_L = 1;
			else pop_L = 0;
	  end else  begin
	    en[4] = 0;
		data_right_src_addr[4] = 0;
		routertobus_valid_internal[4] = 0;
	    if (sel_L == 2'd0) pop_N = 0;
	    if (sel_L == 2'd1) pop_E = 0;
	    if (sel_L == 2'd2) pop_S = 0;
	    if (sel_L == 2'd3) pop_W = 0; 
	  end
end else begin
	en[4] = 0;
	routertobus_valid_internal[4] = 0;
	data_right_src_addr[4] = 0;
end
end
	
end

endmodule
