module arbiter #(WL = 16, ADDR = 4) (
input logic [1:0] X, //X coordinate
input logic [1:0] Y, // Y coordinate
input logic [1:0] dest_N_x, dest_N_y, dest_S_x, dest_S_y, dest_E_x, dest_E_y, dest_W_x, dest_W_y, dest_L_x, dest_L_y,
input logic empty_N, empty_E, empty_S, empty_W, empty_L,
output logic [3:0] flag_N, flag_E, flag_S, flag_W, flag_L,
output logic [1:0] sel_N, sel_E, sel_S, sel_W, sel_L
);

logic flag_E_N, flag_S_N, flag_W_N, flag_L_N, flag_N_E, flag_S_E, flag_W_E, flag_L_E;
logic flag_E_S, flag_N_S, flag_W_S, flag_L_S, flag_N_W, flag_S_W, flag_E_W, flag_L_W, flag_N_L, flag_S_L, flag_E_L, flag_W_L;

//PE
PE PE_N (.A(flag_N), .Y(sel_N)); 
PE PE_E (.A(flag_E), .Y(sel_E));
PE PE_S (.A(flag_S), .Y(sel_S)); 
PE PE_W (.A(flag_W), .Y(sel_W));
PE PE_L (.A(flag_L), .Y(sel_L));
  
  assign  flag_N = {flag_L_N, flag_W_N, flag_S_N, flag_E_N};
  assign  flag_E = {flag_L_E, flag_W_E, flag_S_E, flag_N_E};
  assign  flag_S = {flag_L_S, flag_W_S, flag_E_S, flag_N_S};
  assign  flag_W = {flag_L_W, flag_S_W, flag_E_W, flag_N_W};
  assign  flag_L = {flag_W_L, flag_S_L, flag_E_L, flag_N_L};
//end

// Arbiter , RL
// Handling packets to North only
	always_comb begin
	//priority case(1'b1) 
		if ( (dest_E_y != Y) && (dest_E_x == X ) && (dest_E_y < Y ) && ~empty_E && ~(Y == 2'd3 && dest_E_y == 2'd0 &&  ~empty_E) || (Y == 2'd0 && dest_E_y == 2'd03 &&  ~empty_E ) ) flag_E_N = 1;	 else  flag_E_N = 0;
		if ( (dest_S_y != Y) && (dest_S_x == X ) && (dest_S_y < Y ) && ~empty_S && ~(Y == 2'd3 && dest_S_y == 2'd0 &&  ~empty_S) || (Y == 2'd0 && dest_S_y == 2'd03 &&  ~empty_S ) ) flag_S_N = 1;   else  flag_S_N = 0;
		if ( (dest_W_y != Y) && (dest_W_x == X ) && (dest_W_y < Y ) && ~empty_W && ~(Y == 2'd3 && dest_W_y == 2'd0 &&  ~empty_W) || (Y == 2'd0 && dest_W_y == 2'd03 &&  ~empty_W ) ) flag_W_N = 1;   else  flag_W_N = 0;
		if ( (dest_L_y != Y) && (dest_L_x == X ) && (dest_L_y < Y ) && ~empty_L && ~(Y == 2'd3 && dest_L_y == 2'd0 &&  ~empty_L) || (Y == 2'd0 && dest_L_y == 2'd03 &&  ~empty_L ) ) flag_L_N = 1;   else  flag_L_N = 0;
	//endcase
	end

 // Handling packets to East only
	always_comb begin
		//priority case (1'b1)
		if ( (((dest_N_y != Y) && (dest_N_x != X)) || ((dest_N_y == Y) && (dest_N_x != X)) ) && (dest_N_x > X) && ~empty_N && ~(X == 2'd0 && dest_N_x == 2'd03 &&  ~empty_N ) || (X == 2'd3 && dest_N_x == 2'd0 &&  ~empty_N)) flag_N_E = 1;	else flag_N_E = 0;																				
		if ( (((dest_S_y != Y) && (dest_S_x != X)) || ((dest_S_y == Y) && (dest_S_x != X)) ) && (dest_S_x > X) && ~empty_S && ~(X == 2'd0 && dest_S_x == 2'd03 &&  ~empty_S ) || (X == 2'd3 && dest_S_x == 2'd0 &&  ~empty_S)) flag_S_E = 1;	else flag_S_E = 0;
		if ( (((dest_W_y == Y) && (dest_W_x != X)) || ((dest_W_y != Y) && (dest_W_x != X)) ) && (dest_W_x > X) && ~empty_W && ~(X == 2'd0 && dest_W_x == 2'd03 &&  ~empty_W ) || (X == 2'd3 && dest_W_x == 2'd0 &&  ~empty_W)) flag_W_E = 1;	else flag_W_E = 0;	 																		
		if ( (((dest_L_y == Y) && (dest_L_x != X)) || ((dest_L_y != Y) && (dest_L_x != X)) ) && (dest_L_x > X) && ~empty_L && ~(X == 2'd0 && dest_N_x == 2'd03 &&  ~empty_N ) || (X == 2'd3 && dest_L_x == 2'd0 &&  ~empty_L)) flag_L_E = 1;	else flag_L_E = 0;

end

	// Handling packets to South only
	always_comb begin
		//priority case (1'b1)
		if ( (dest_N_y != Y) && (dest_N_x == X ) && (dest_N_y > Y) && ~empty_N && ~(Y == 2'd0 && dest_N_y == 2'd03 &&  ~empty_N ) || (Y == 2'd3 && dest_N_y == 2'd0 &&  ~empty_N)) flag_N_S = 1;	else flag_N_S = 0;
		if ( (dest_E_y != Y) && (dest_E_x == X ) && (dest_E_y > Y) && ~empty_E && ~(Y == 2'd0 && dest_E_y == 2'd03 &&  ~empty_E ) || (Y == 2'd3 && dest_E_y == 2'd0 &&  ~empty_E)) flag_E_S = 1;	else flag_E_S = 0;
		if ( (dest_W_y != Y) && (dest_W_x == X ) && (dest_W_y > Y) && ~empty_W && ~(Y == 2'd0 && dest_W_y == 2'd03 &&  ~empty_W ) || (Y == 2'd3 && dest_W_y == 2'd0 &&  ~empty_W)) flag_W_S = 1;	else flag_W_S = 0;
		if ( (dest_L_y != Y) && (dest_L_x == X ) && (dest_L_y > Y) && ~empty_L && ~(Y == 2'd0 && dest_L_y == 2'd03 &&  ~empty_L ) || (Y == 2'd3 && dest_L_y == 2'd0 &&  ~empty_L)) flag_L_S = 1;	else flag_L_S = 0;
		//endcase
	end
	   
	// Handling packets to West only
	always_comb begin
		//priority case (1'b1)
		if ( (((dest_N_y == Y && dest_N_x != X)) || ((dest_N_y != Y && dest_N_x != X)) ) && (dest_N_x < X) && ~empty_N && ~(X == 2'd3 && dest_N_x == 2'd0 &&  ~empty_N) || (X == 2'd0 && dest_N_x == 2'd03 &&  ~empty_N )) flag_N_W = 1;	else flag_N_W = 0;
		if ( (((dest_E_y == Y && dest_E_x != X)) || ((dest_E_y != Y && dest_E_x != X)) ) && (dest_E_x < X) && ~empty_E && ~(X == 2'd3 && dest_E_x == 2'd0 &&  ~empty_E) || (X == 2'd0 && dest_E_x == 2'd03 &&  ~empty_E )) flag_E_W = 1;	else flag_E_W = 0;
		if ( (((dest_S_y == Y && dest_S_x != X)) || ((dest_S_y != Y && dest_S_x != X)) ) && (dest_S_x < X) && ~empty_S && ~(X == 2'd3 && dest_S_x == 2'd0 &&  ~empty_S) || (X == 2'd0 && dest_S_x == 2'd03 &&  ~empty_S )) flag_S_W = 1;	else flag_S_W = 0;
		if ( (((dest_L_y == Y && dest_L_x != X)) || ((dest_L_y != Y && dest_L_x != X)) ) && (dest_L_x < X) && ~empty_L && ~(X == 2'd3 && dest_L_x == 2'd0 &&  ~empty_L) || (X == 2'd0 && dest_L_x == 2'd03 &&  ~empty_L )) flag_L_W = 1;	else flag_L_W = 0;
		//endcase
	end
	
	// Handling packets to Local only
	always_comb begin
		//priority case (1'b1)
		if (dest_N_y == Y && dest_N_x == X && ~empty_N) flag_N_L = 1;	else flag_N_L = 0;
		if (dest_E_y == Y && dest_E_x == X && ~empty_E) flag_E_L = 1;	else flag_E_L = 0;
		if (dest_S_y == Y && dest_S_x == X && ~empty_S) flag_S_L = 1;	else flag_S_L = 0;
		if (dest_W_y == Y && dest_W_x == X && ~empty_W) flag_W_L = 1;	else flag_W_L = 0;
		//endcase
	end
endmodule
