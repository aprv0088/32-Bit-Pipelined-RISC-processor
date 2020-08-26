
module extend_6 (
bit6_in   , 
bit16_out   
                   
); 
input [5:0] bit6_in ;

output [15:0]  bit16_out ;

reg [15:0]   data_out;

assign bit16_out = data_out; 

always @ (bit6_in)
begin : signext
           if (bit6_in[5])
              data_out = {10'b1111111111,bit6_in};
           else
              data_out = {10'b0000000000,bit6_in};
 end

endmodule 
