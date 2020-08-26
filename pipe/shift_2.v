/////////////////////////////multiplying by 2
module shift_2(bit16_in, bit16_out); 
 
input [15:0] bit16_in ;
output [15:0]  bit16_out ;
assign bit16_out = bit16_in << 2; 
endmodule 
