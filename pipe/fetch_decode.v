///////////////////////////This is pipelined register fetch and decode

module fetch_decode (
	clk, 
	if_id_in, 
	if_id_out  
	
);
input [31:0] if_id_in;
input clk;
output [31:0] if_id_out;

reg [31:0] if_id;


assign if_id_out = if_id;


always @(posedge clk ) begin : proc_
	
		if_id = if_id_in;
	
end


endmodule