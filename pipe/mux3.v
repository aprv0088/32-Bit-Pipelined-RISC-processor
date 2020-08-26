/////////////////////this is for mux which is used to delay the input to reg file
module mux3 (mux_sel,mux_in1,mux_in2,mux_out);

	input [2:0] mux_in1;
	input [2:0] mux_in2;
	input mux_sel;
	output [2:0] mux_out;
	reg [2:0] mux_out;

	always @(mux_sel or mux_in1 or mux_in2) begin : proc_
		if(mux_sel) begin
			 mux_out= mux_in2;
		end else begin
			 mux_out= mux_in1;
		end
	end

endmodule