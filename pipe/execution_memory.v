//////This module is for register pipeline execution and memory
module execution_memory (
	clk, 
	
	idex_data_in, 
	idex_data_out,
	reg_addr_in,
	reg_addr_out,
	mem_ctrl_in,
	mem_ctrl_out,
	wb_ctrl_in,
	wb_ctrl_out
);

parameter DATA_WIDTH = 48 ;

input clk;

input [DATA_WIDTH-1:0] idex_data_in;
output [DATA_WIDTH-1:0] idex_data_out;
reg [DATA_WIDTH-1:0] idex;

input [2:0] reg_addr_in;
output [2:0] reg_addr_out;
reg [2:0] reg_addr;

input [2:0] mem_ctrl_in;
output [2:0] mem_ctrl_out;
reg [2:0] mem_ctrl;

input [1:0] wb_ctrl_in; 
output [1:0] wb_ctrl_out;
reg [1:0] wb_ctrl;



assign idex_data_out=idex;
assign reg_addr_out=reg_addr;

assign mem_ctrl_out=mem_ctrl;
assign wb_ctrl_out = wb_ctrl;

	

always @(posedge clk ) begin : proc_
	
		idex=idex_data_in;
		reg_addr=reg_addr_in;

		mem_ctrl=mem_ctrl_in;
		wb_ctrl=wb_ctrl_in;

	
end


endmodule