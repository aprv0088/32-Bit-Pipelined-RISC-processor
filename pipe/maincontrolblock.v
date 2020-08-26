////////////////module of main controller block, it has input from inst,carry,condition and zero
module maincontrolblock(ope,cond,carry,zero,ex,mem,wb);

	input [3:0] ope;
    input [1:0] cond;
    input carry;
    input zero;

    output [3:0] ex;  
    output [2:0] mem; 
    output [1:0] wb;     
    wire [1:0] wbctrl_w;
    wire [1:0] func_sel_w;
  



    
    assign wb[0]=wbctrl_w[0];

    controlunit ctrl_inst(.ope(ope), .cond(cond), .ex(ex), .mem(mem), .wb(wbctrl_w), .func_sel(func_sel_w) );
    zerooom mux(.a(wbctrl_w[1]), .b(zero), .c(carry), .d(wbctrl_w[1]), .sel(func_sel_w), .out(wb[1]) );

endmodule