`timescale 1ns/1ns
module  tb_fifo ;
    
	logic [7:0] data_push;
	logic [7:0] data_pop;
	
	logic push; // increment write pointer 
	logic pop; // increment read pointer
	
	logic [7:0] memtmp [7:0];
	logic [2:0] rd_ptr, rd_ptr_next;
	logic [2:0] wrt_ptr,wrt_ptr_next;
	logic [3:0] count;
	logic full;
	logic empty;
	
	logic almost_full; // a push will cause full next cycle
	
	logic almost_empty; // a pop will cause empty next cycle
	
	logic rst;
	logic clk;
	
	FIFO fifo1 (.data_push (data_push), .data_pop (data_pop), . push(push), .pop(pop), .rst(rst), .clk(clk), .full(full), .empty(empty), .almost_full(almost_full), .almost_empty(almost_empty) );
	
	initial forever #5 clk = ~clk;	 
		
		initial begin
			clk = 0;
			rst = 0;
			
			memtmp = fifo1.mem;  
			
			#5 	rd_ptr = fifo1.rdPtr;	wrt_ptr = fifo1.wrtPtr;	
			rd_ptr_next = fifo1.rdPtr_next;	wrt_ptr_next = fifo1.wrtPtr_next;
			memtmp = fifo1.mem;	count = fifo1.cnt;
			
			// Write - 2
			#4 rst = 1;
			
			push = 1;	pop = 0;	data_push = 8'd5;
			
			rd_ptr = fifo1.rdPtr;	wrt_ptr = fifo1.wrtPtr;	
			rd_ptr_next = fifo1.rdPtr_next;	wrt_ptr_next = fifo1.wrtPtr_next;
			memtmp = fifo1.mem;	count = fifo1.cnt;
			
			#5 rd_ptr = fifo1.rdPtr;	wrt_ptr = fifo1.wrtPtr;	
			rd_ptr_next = fifo1.rdPtr_next;	wrt_ptr_next = fifo1.wrtPtr_next;
			memtmp = fifo1.mem;	count = fifo1.cnt;
			
			#4 push = 1;	pop = 0;	data_push = 8'd8; 

			rd_ptr = fifo1.rdPtr;	wrt_ptr = fifo1.wrtPtr;	
			rd_ptr_next = fifo1.rdPtr_next;	wrt_ptr_next = fifo1.wrtPtr_next;
			memtmp = fifo1.mem;	count = fifo1.cnt;
			
			#5 rd_ptr = fifo1.rdPtr;	wrt_ptr = fifo1.wrtPtr;	
			rd_ptr_next = fifo1.rdPtr_next;	wrt_ptr_next = fifo1.wrtPtr_next;
			memtmp = fifo1.mem;	count = fifo1.cnt;
			
			#4 data_push = 8'd4;	push = 1;	pop = 0; 

			rd_ptr = fifo1.rdPtr;	wrt_ptr = fifo1.wrtPtr;	
			rd_ptr_next = fifo1.rdPtr_next;	wrt_ptr_next = fifo1.wrtPtr_next;
			memtmp = fifo1.mem;	count = fifo1.cnt;
			
			#5 	rd_ptr = fifo1.rdPtr;	wrt_ptr = fifo1.wrtPtr;	
			rd_ptr_next = fifo1.rdPtr_next;	wrt_ptr_next = fifo1.wrtPtr_next;
			memtmp = fifo1.mem;	count = fifo1.cnt;
			
			/*
			// Read - 2
			#4 push = 0;	pop = 1;
			
			rd_ptr = fifo1.rdPtr;	wrt_ptr = fifo1.wrtPtr;	
			rd_ptr_next = fifo1.rdPtr_next;	wrt_ptr_next = fifo1.wrtPtr_next;
			memtmp = fifo1.mem;	count = fifo1.cnt;
			// Write and read - 1 -, 1
			
			#5 rd_ptr = fifo1.rdPtr;	wrt_ptr = fifo1.wrtPtr;	
			rd_ptr_next = fifo1.rdPtr_next;	wrt_ptr_next = fifo1.wrtPtr_next;
			memtmp = fifo1.mem;	count = fifo1.cnt;
			  
			*/
			#4	push = 1;	pop = 0;	data_push = 8'd3;
			
			rd_ptr = fifo1.rdPtr;	wrt_ptr = fifo1.wrtPtr;	
			rd_ptr_next = fifo1.rdPtr_next;	wrt_ptr_next = fifo1.wrtPtr_next;
			memtmp = fifo1.mem;	count = fifo1.cnt;
			
			#4 			
			push = 1;	pop = 0;	data_push = 8'd3;
				
			rd_ptr = fifo1.rdPtr;	wrt_ptr = fifo1.wrtPtr;	
			rd_ptr_next = fifo1.rdPtr_next;	wrt_ptr_next = fifo1.wrtPtr_next;
			memtmp = fifo1.mem;	count = fifo1.cnt;
			
			#10 			
			push = 1;	pop = 0;	data_push = 8'd2;
			
			rd_ptr = fifo1.rdPtr;	wrt_ptr = fifo1.wrtPtr;	
			rd_ptr_next = fifo1.rdPtr_next;	wrt_ptr_next = fifo1.wrtPtr_next;
			memtmp = fifo1.mem;	count = fifo1.cnt;
			
			#10 			
			push = 1; pop = 0;	data_push = 8'd1;
			
			rd_ptr = fifo1.rdPtr;	wrt_ptr = fifo1.wrtPtr;	
			rd_ptr_next = fifo1.rdPtr_next;	wrt_ptr_next = fifo1.wrtPtr_next;
			memtmp = fifo1.mem;	count = fifo1.cnt;
			
			#10 			
			push = 1;	pop = 0;	data_push = 8'd9;
			
			rd_ptr = fifo1.rdPtr;	wrt_ptr = fifo1.wrtPtr;	
			rd_ptr_next = fifo1.rdPtr_next;	wrt_ptr_next = fifo1.wrtPtr_next;
			memtmp = fifo1.mem;	count = fifo1.cnt;
			
			#10 			
			push = 1;	pop = 0;	data_push = 8'd14;
			
			rd_ptr = fifo1.rdPtr;	wrt_ptr = fifo1.wrtPtr;	
			rd_ptr_next = fifo1.rdPtr_next;	wrt_ptr_next = fifo1.wrtPtr_next;
			memtmp = fifo1.mem;	count = fifo1.cnt;
			
			#10 			
			push = 1;	pop = 0;	data_push = 8'd1;
			
			rd_ptr = fifo1.rdPtr;	wrt_ptr = fifo1.wrtPtr;	
			rd_ptr_next = fifo1.rdPtr_next;	wrt_ptr_next = fifo1.wrtPtr_next;
			memtmp = fifo1.mem;	count = fifo1.cnt;
			
			#10 			
			push = 0;	pop = 1;	
			
			rd_ptr = fifo1.rdPtr;	wrt_ptr = fifo1.wrtPtr;	
			rd_ptr_next = fifo1.rdPtr_next;	wrt_ptr_next = fifo1.wrtPtr_next;
			memtmp = fifo1.mem;	count = fifo1.cnt;
			
			 #20 			
			push = 1;	pop = 1;	data_push = 8'd14;
			
			rd_ptr = fifo1.rdPtr;	wrt_ptr = fifo1.wrtPtr;	
			rd_ptr_next = fifo1.rdPtr_next;	wrt_ptr_next = fifo1.wrtPtr_next;
			memtmp = fifo1.mem;	count = fifo1.cnt;
			
			#5 count = fifo1.cnt;
			#10 			
			push = 0;	pop = 1;
			
			rd_ptr = fifo1.rdPtr;	wrt_ptr = fifo1.wrtPtr;	
			rd_ptr_next = fifo1.rdPtr_next;	wrt_ptr_next = fifo1.wrtPtr_next;
			memtmp = fifo1.mem;	count = fifo1.cnt;
			
			#5 count = fifo1.cnt;
			#5 count = fifo1.cnt;
			#5 count = fifo1.cnt;
			#5 count = fifo1.cnt;
			#5 count = fifo1.cnt;
			#5 count = fifo1.cnt;
			#5 count = fifo1.cnt;
			#5 count = fifo1.cnt;
			#5 count = fifo1.cnt;
			#10 count = fifo1.cnt;
			#10 count = fifo1.cnt;
			#10 count = fifo1.cnt;
			#10 count = fifo1.cnt;
		end
		
endmodule
