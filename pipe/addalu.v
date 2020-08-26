////////////////This module is for adding two given numbers
////////////////this is instantiated inside main alu block

module addalu(add_in1,add_in2,add_out);
	input [15:0] add_in1;
	input [15:0] add_in2;
	output [15:0] add_out;
    reg [15:0] add_out;

always @ (add_in1,add_in2)

begin : ADD
 
    add_out = add_in1 + add_in2;       //addition of two numbers
 
end

endmodule