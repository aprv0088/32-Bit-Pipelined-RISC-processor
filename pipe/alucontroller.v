///////////////This is the main alu controller 
//////////////depending upon function field and aluoperation the alusel is selected.
module alucontroller(func,aluOp_in,alu_sel_out);

input [3:0] func;
input [1:0] aluOp_in;
output[2:0] alu_sel_out;
reg [2:0] alu_sel_out_r;

assign alu_sel_out=alu_sel_out_r;

 always @ (func or aluOp_in)
	begin : alucontrol
	 if (aluOp_in==2'b01) begin

		 	if (func==6'b100000) begin
		 		alu_sel_out_r=3'b000; //add
		 	end
		 	if (func==6'b100001) begin
		 		alu_sel_out_r=3'b001; //sub
		 	end
		 	if (func==6'b100010) begin
		 		alu_sel_out_r=3'b010; //increment by 1
		 	end


		 end else if (aluOp_in==2'b00) begin
		 	alu_sel_out_r=3'b000;  //add for load or store

		 end else if (aluOp_in==2'b10) begin
		 	alu_sel_out_r=3'b001; //sub for beq
		 end


		end

endmodule