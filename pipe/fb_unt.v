////////////////THis module is for forwarding unit block. all the conditions for forwaring are in if case

module fb_unt (
	forwardA, 
	forwardB,
	ex_mem_regWrite,
	mem_wb_regWrite,   
	ex_mem_rd, 
	mem_wb_rd,
	id_ex_rt,
	id_ex_rs  
	
);
input ex_mem_regWrite;
input mem_wb_regWrite;

input [2:0] ex_mem_rd;
input [2:0] mem_wb_rd;

input [2:0] id_ex_rt;
input [2:0] id_ex_rs;

output [1:0] forwardA;
output [1:0] forwardB;

reg [1:0] forwardA;
reg [1:0] forwardB;
/////////////////checking conditions for forwarding
always @(*) begin : proc_
	if(ex_mem_regWrite==1 && ex_mem_rd==id_ex_rs) begin    
		 forwardA=2'b10;
	end else if (ex_mem_regWrite==1 && ex_mem_rd==id_ex_rt) begin
		 forwardB=2'b10;

	end else if (mem_wb_regWrite==1 && mem_wb_rd==id_ex_rs && (ex_mem_rd!=id_ex_rs)) begin  
		 forwardA=2'b01;
	end else if (mem_wb_regWrite==1 && mem_wb_rd==id_ex_rt && (ex_mem_rd!=id_ex_rt)) begin  
		 forwardB=2'b01;

	end else begin

		 forwardA=2'b00;
		 forwardB=2'b00;
	end

end


endmodule