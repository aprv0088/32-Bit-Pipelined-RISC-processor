//////////////////This module is for data memory 

module datamemory (
clk, address,read_data, write_data, wr, rd          
); 

parameter DATA_WIDTH = 16 ;
parameter ADDR_WIDTH = 8 ;
parameter RAM_DEPTH = 1 << ADDR_WIDTH;

//Input
input clk;
input [ADDR_WIDTH-1:0] address ;
input [DATA_WIDTH-1:0] write_data ;                 
input wr;       
input rd; 

//output 
output [DATA_WIDTH-1:0]  read_data       ;

reg [DATA_WIDTH-1:0]   data_out ;
reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];

initial begin
		mem[0]=16'h00ff;
		mem[1]=16'h0053;
		mem[2]=16'h0031;
		mem[3]=16'h0016;
		mem[4]=16'h0074;
		mem[5]=16'h0090;
		mem[6]=16'h0077;
		mem[7]=16'h0021;
		mem[8]=16'h0011;
		mem[9]=16'h0029;
	end

assign read_data = (rd && !wr) ? data_out : 16'bz; 

// Memory Write

always @ (posedge clk)
begin : MEM_WRITE
   if ( wr ) begin
       mem[address] = write_data;
   end
end

// Memory Read 

always @ (address or wr or rd)
begin : MEM_READ
    if (!wr && rd) begin
         data_out = mem[address];
    end
end

endmodule 