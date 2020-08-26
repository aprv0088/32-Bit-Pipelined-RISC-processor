//////////////////This is for register de_ex


module decode_execution (
	clk, 
	   
	idex_data_in, 
	idex_data_out,

	reg_addr_in,
	reg_addr_out,

	rs_in,
	rs_out, 

	ex_ctrl_in,
	ex_ctrl_out,

	mem_ctrl_in,
	mem_ctrl_out,

	wb_ctrl_in,
	wb_ctrl_out
);

parameter DATA_WIDTH = 57 ;

input clk;

input [DATA_WIDTH-1:0] idex_data_in;
output [DATA_WIDTH-1:0] idex_data_out;
reg [DATA_WIDTH-1:0] idex;

input [5:0] reg_addr_in;
output [5:0] reg_addr_out;
reg [5:0] reg_addr;

input [5:0] rs_in;
output [5:0] rs_out;
reg [5:0] rs;

input [3:0] ex_ctrl_in; 
output [3:0] ex_ctrl_out;
reg [3:0] ex_ctrl;

input [2:0] mem_ctrl_in; 
output [2:0] mem_ctrl_out;
reg [2:0] mem_ctrl;

input [1:0] wb_ctrl_in;
output [1:0] wb_ctrl_out;
reg [1:0] wb_ctrl;



assign idex_data_out=idex;
assign reg_addr_out=reg_addr;

assign rs_out=rs; 

assign ex_ctrl_out=ex_ctrl;
assign mem_ctrl_out=mem_ctrl;
assign wb_ctrl_out = wb_ctrl;

	

always @(posedge clk ) begin : proc_
	
		idex=idex_data_in;
		reg_addr=reg_addr_in;
		rs=rs_in;

		ex_ctrl=ex_ctrl_in;
		mem_ctrl=mem_ctrl_in;
		wb_ctrl=wb_ctrl_in;

	
end


endmodule