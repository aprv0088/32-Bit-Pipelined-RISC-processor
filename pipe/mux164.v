/////////////////////////mux for alu input b
////////////////////////to select immediated data or address to mem
module mux164 (mux_sel,mux_in1,mux_in2,mux_in3,mux_in4,mux_out);

	input [15:0] mux_in1;
	input [15:0] mux_in2;
	input [15:0] mux_in3;
	input [15:0] mux_in4;
	input [1:0] mux_sel;

	output [15:0] mux_out;
	reg [15:0] mux_out;

	always @(mux_sel or mux_in1 or mux_in2) begin : MUX 
		case (mux_sel)
			2'b00: mux_out=mux_in1;
			2'b01: mux_out=mux_in2;
			2'b10: mux_out=mux_in3;
			2'b11: mux_out=mux_in1;
		endcase
		
	end

endmodule