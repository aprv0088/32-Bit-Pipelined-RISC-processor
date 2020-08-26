module controlunit(ope,cond,ex,mem,wb,func_sel);

	input [3:0] ope;
    input [1:0] cond;
    output [3:0] ex;  
    output [2:0] mem; 
    output [1:0] wb;  
    output [1:0] func_sel; 
    reg [3:0] ex_r;
    reg [2:0] mem_r;
    reg [1:0] wb_r;
	reg [1:0] func_sel_r;
	
	
    assign ex = ex_r;
    assign mem = mem_r;
    assign wb = wb_r;

    assign func_sel = func_sel_r;
	
always @ (ope,cond)
 begin : MEM
 case(ope) 
    4'b0000 : begin ///ADD
    		          if (cond == 2'b00 ) begin
                          wb_r[1] = 1'b1; 
                          func_sel_r = 2'b00;
                      end else if (cond == 2'b01) begin
                           func_sel_r = 2'b01; 
                      end else if (cond == 2'b10) begin
                           func_sel_r = 2'b10; 
                      end else if (cond == 2'b11) begin
                           wb_r[1] = 1'b1; 
                           func_sel_r = 2'b00;
                      end

                      wb_r[0] = 1'b0; 
                      ex_r = 4'b0100; 
                      mem_r = 3'b000; 
    			end
   
   4'b1111 : begin //SUB
                      
                          
            
                      wb_r[1] = 1'b1; 
                      func_sel_r = 2'b00;

                      wb_r[0] = 1'b0; 
                      ex_r = 4'b0101; 
                      mem_r = 3'b000; 


                end

    4'b0001 : begin //ADI
                                   
                      func_sel_r = 2'b00;

                      wb_r = 2'b10; 
                      ex_r = 4'b1000; 
                      mem_r = 3'b000; 


                end
     4'b0100 : begin //LW 
                                   
                      func_sel_r = 2'b00;
                      ex_r = 4'b1000; 
                      mem_r = 3'b010; 
                      wb_r = 2'b11; 


                end
    4'b0101 : begin //SW 
                                   
                      func_sel_r = 2'b00;
                      ex_r = 4'b1000; 
                      mem_r = 3'b100; 
                      wb_r = 2'b00; 


                end
     4'b1100 : begin //BEQ 
                                   
                      func_sel_r = 2'b00;
                      ex_r = 4'b0101; 
                      mem_r = 3'b001; 
                      wb_r = 2'b00; 


                end
    
 endcase 
end

endmodule