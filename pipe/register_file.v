/////////////////////register file block 
/////////////////////dedicated reg R7 for storing pc
module register_file (clk, pc_store,addr1, addr2, addr3,data1,data2,write_data, wr); 

parameter DATA_WIDTH = 16 ;
parameter ADDR_WIDTH = 3 ;
parameter RAM_DEPTH = 1 << ADDR_WIDTH;
//in
input clk   ;
input [ADDR_WIDTH-1:0] addr1 ;
input [ADDR_WIDTH-1:0] addr2 ;
input [ADDR_WIDTH-1:0] addr3 ;
input [DATA_WIDTH-1:0] write_data ;
input [DATA_WIDTH-1:0] pc_store ;                 
input wr    ;
//op
output [DATA_WIDTH-1:0]  data1       ;
output [DATA_WIDTH-1:0]  data2       ;

 
reg [DATA_WIDTH-1:0]   data_out1 ;
reg [DATA_WIDTH-1:0]   data_out2 ;
reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];
//

/////////////////////////contents of memory
initial begin
		mem[0]=16'h0003; //R0
		mem[1]=16'h0005; //R1	
		mem[2]=16'h0005; //R2
		mem[3]=16'h0006; //R3
		mem[4]=16'h0002; //R4
		mem[5]=16'h00FF; //R5
		mem[6]=16'h00FF; //R6
		
	end


assign data1 = data_out1 ; 
assign data2 = data_out2 ; 

// mem write
always @ (posedge clk)
begin : MEM_WRITE_and_store_PC_to_R7   /////////////////////dedicated reg R7 for storing pc
	mem[7]=pc_store; 
   if ( wr ) begin
       mem[addr3] = write_data;
   end
end

// mem read 1

always @ (addr1 or wr)
begin : MEM_READ1
      data_out1 = mem[addr1];
end

//mem read 2
always @ (addr2 or wr)
begin : MEM_READ2
      data_out2 = mem[addr2];
end

endmodule 