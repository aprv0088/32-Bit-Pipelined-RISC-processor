/////////////////////////main instruction memory 
////////////////////////the instructions are 1 by 1 executed 
module inst_memory (addr_in, mem_out); 

parameter DATA_WIDTH = 16 ;
parameter ADDR_WIDTH = 8 ;
parameter RAM_DEPTH = 1 << ADDR_WIDTH;
input [ADDR_WIDTH-1:0] addr_in   ;
output [DATA_WIDTH-1:0]  mem_out ;
reg [DATA_WIDTH-1:0]   data_out ;
reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];

initial begin
    mem[0]= {4'b0000,3'b001,3'b000,3'b011,1'b0,2'b00};///////ADD
    mem[1]= {4'b1100,3'b010,3'b001,6'b000001};/////////////BEQ
   
    mem[2]= {4'b0000,3'b010,3'b000,3'b011,1'b0,2'b00}; //////////////////////////ADZ
    mem[3]= {4'b0000,3'b001,3'b000,3'b011,1'b0,2'b10}; ///////////////////ADC
    mem[4]= {4'b0000,3'b010,3'b000,3'b011,1'b0,2'b00};////////////////ADD
	 mem[5]= {4'b0000,3'b011,3'b001,3'b011,1'b0,2'b10}; ///////////////////ADC
	  mem[6]= {4'b0000,3'b001,3'b011,3'b001,1'b0,2'b00};///////ADD
	  mem[7]= {4'b0000,3'b010,3'b001,3'b011,1'b0,2'b10}; ///////////////////ADC
	  mem[8]= {4'b0000,3'b011,3'b010,3'b100,1'b0,2'b00};///////ADD
	  mem[9]= {4'b0000,3'b011,3'b010,3'b010,1'b0,2'b00};///////ADD
   // mem[5]= {4'b0000,3'b000,3'b101,3'b100,1'b0,2'b00};
   // mem[6]= {4'b0000,3'b010,3'b110,3'b101,1'b0,2'b00}; //branch
   // mem[7]= {4'b0000,3'b000,3'b011,3'b110,1'b0,2'b00};
    /*mem[3]=32'h00000016;
    mem[4]=32'h00000074;
    mem[5]=32'h00000090;
    mem[6]=32'h00000077;
    mem[7]=32'h00000021;
    mem[8]=32'h00000011;
    mem[9]=32'h00000029;*/

  end

assign mem_out = data_out; 

//reading

always @ (addr_in)
begin : MEM_READ
    
         data_out = mem[addr_in];
    
end

endmodule 