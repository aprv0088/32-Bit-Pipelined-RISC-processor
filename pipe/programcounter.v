///////////////////main program counter
///////////////////if continuously reset the pc value will be zero
module programcounter (
	clk, 
	rst,   
	pc_in, 
	pc_out  
	
);
input [15:0] pc_in;
input clk,rst;
output [15:0] pc_out;

reg [15:0] pc;


assign pc_out=pc;

	initial begin
		 pc= 16'h0000;
	end

always @(posedge clk or rst ) begin : proc_
	if (rst)
		pc=16'h0000;
		
	else 
		pc=pc_in;
	
end


endmodule