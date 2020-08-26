///////////////////Fetch block.
///////////////////instructions come out of this block
module fetch( clk,rst,
	instruct_out,add1_out,add1_in_pc,pc_current);


	input clk,rst;
	output [15:0] instruct_out;
	output [15:0] add1_out;
	output [15:0] pc_current;
	input [15:0] add1_in_pc;


	wire   [15:0] instructionplus1;
	wire   [15:0] pc_out_w;

	assign add1_out=instructionplus1;
	assign pc_current = pc_out_w;
	programcounter     pc_inst1 (.clk(clk), .rst(rst), .pc_in(add1_in_pc), .pc_out(pc_out_w));
	aluplus1 alu_add_inst1 (.add1_in(pc_out_w), .add1_out(instructionplus1) );
	inst_memory instruction_mem_inst1 (.addr_in(pc_out_w), .mem_out(instruct_out)  );

endmodule