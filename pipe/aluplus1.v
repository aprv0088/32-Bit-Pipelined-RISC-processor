//////////////////////This module is instantiated in fetch block for incrementing PC value
//////////////////////PC value is incremented by 1
module aluplus1(add1_in,add1_out);
	input [15:0] add1_in;
	output [15:0] add1_out;
    reg [15:0] add1_out;

always @ (add1_in)
begin : ADD1
 
    add1_out = add1_in + 1'b1;       
end

endmodule