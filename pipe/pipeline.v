module pipeline (clk,rst);

input clk,rst;
//Stage-1 wires (Fetch)
wire [15:0] instruction;
wire [15:0] instructionplus1;

//Stage-2 wires (decode)
wire [15:0] pcvalue;
wire [15:0] instruction_decode;
wire [15:0] instruction2plus1;
wire [3:0] execution_wb; 
wire [2:0] memory_wb; 
wire [1:0] write_back;  
wire [15:0] data_rf_1, data_rf_2;

//Stage-3 Wires (Execution)

wire [5:0] decode_exe_out;
wire [8:0] extend_exe;
wire [15:0] instruction3plus1;
wire [15:0] data_2, data2_2;
wire [3:0] execution_2; 
wire [2:0] memory_wb_2;
wire [1:0] wirteback_2;
wire [15:0] aluadd_beq;
wire [15:0] aluout_exe;
wire [15:0] alu2inmux16;
wire [15:0] alu2input;
wire [2:0] regdata_tonext;

//wire [15:0] signExt9out_w;
//wire [15:0] shift2out_w;
wire zerowire,alucarryout,ztozeromux,ctozeromux;
wire ando;

wire [2:0] r_out;

wire [1:0] forwardA_sel_w;
wire [1:0] forwardB_sel_w;

wire [15:0] forwardA_out_w;
wire [15:0] forwardB_out_w;


//Stage-4 wires(Mem)
wire [2:0] memory_mem; 
wire [1:0] memory_wb_exee; 
wire [15:0] memory_aluaddbeq;
wire [15:0] memory_aluout;
wire [15:0] memory_data2 ;
wire [2:0] memory_regfiledst;
wire [15:0] pcsource ;
wire [15:0] memory_dataout;

//Stage-5 wires (Write Back)
wire [1:0] writeback_ctrl;
wire [15:0] writeback_regwritedata;
wire [15:0] writeback_mux_in0 ;
wire [2:0] writeback_regfileaddress;
wire [15:0] writeback_regfile_data ;


//Stage1: Fetch//
 fetch fetch_inst ( .clk(clk), .rst(rst), .instruct_out(instruction), .add1_out(instructionplus1), .add1_in_pc(pcsource), .pc_current(pcvalue));

 fetch_decode ifid(
	.clk(clk),    
	.if_id_in({instructionplus1,instruction}), 
	.if_id_out({instruction2plus1,instruction_decode})  
	
);

//Stage2: Decode//
 maincontrolblock control_inst(.ope(instruction_decode[15:12]), .cond(instruction_decode[1:0]), .carry(ctozeromux), .zero(ztozeromux), .ex(execution_wb), .mem(memory_wb), .wb(write_back));
 register_file reg_file_inst(.clk(clk),.pc_store(pcvalue), .addr1(instruction_decode[11:9]), .addr2(instruction_decode[8:6]), .addr3(writeback_regfileaddress), .data1(data_rf_1), .data2(data_rf_2), .write_data(writeback_regfile_data), .wr(writeback_ctrl[1]));


 decode_execution idex (
	.clk(clk), 
	   
	.idex_data_in({instruction2plus1,data_rf_1,data_rf_2,instruction_decode[8:0]}), 
	.idex_data_out({instruction3plus1,data_2, data2_2,extend_exe}),

	.reg_addr_in(instruction_decode[8:3]),
	.reg_addr_out(decode_exe_out),

	.rs_in(instruction_decode[11:9]),
	.rs_out(r_out), 

	.ex_ctrl_in(execution_wb),
	.ex_ctrl_out(execution_2),

	.mem_ctrl_in(memory_wb),
	.mem_ctrl_out(memory_wb_2),

	.wb_ctrl_in(write_back),
	.wb_ctrl_out(wirteback_2)
); 

//Stage3: Execution//
mux3 mux_3bit_i1(.mux_sel(execution_2[2]), .mux_in1(decode_exe_out[5:3]), .mux_in2(decode_exe_out[2:0]), .mux_out(regdata_tonext)); 
extend_6 sign_extend6bit_i (.bit6_in(extend_exe[5:0]), .bit16_out(alu2inmux16)); 

mux16 mux16i (.mux_sel(execution_2[3]), .mux_in1(data2_2), .mux_in2(alu2inmux16), .mux_out(alu2input));
alu alu1 (.alu_in1(forwardA_out_w), .alu_in2(forwardB_out_w), .alu_sel(execution_2[1:0]), .alu_out(aluout_exe), .z(zerowire), .ovf(alucarryout));

addalu aluAdd(.add_in1(instruction3plus1), .add_in2(alu2inmux16), .add_out(aluadd_beq));

zero_out cz_i (.z_in(zerowire), .c_in(alucarryout), .z_out(ztozeromux), .c_out(ctozeromux));

assign ando= memory_wb_2[0] & ztozeromux;

execution_memory exMem (
	.clk(clk), 
	   
	.idex_data_in({aluadd_beq,aluout_exe,data2_2}), 
	.idex_data_out({memory_aluaddbeq,memory_aluout,memory_data2}),

	.reg_addr_in(regdata_tonext),
	.reg_addr_out(memory_regfiledst),

	.mem_ctrl_in({memory_wb_2[2:1],ando}),
	.mem_ctrl_out(memory_mem),

	.wb_ctrl_in(wirteback_2),
	.wb_ctrl_out(memory_wb_exee) 
);
   //ALU source selection muxes
    mux164 forwardA ( .mux_sel(forwardA_sel_w), .mux_in1(data_2), .mux_in2(writeback_regfile_data), .mux_in3(memory_aluout), .mux_in4(), .mux_out(forwardA_out_w) );
    mux164 forwardB ( .mux_sel(forwardB_sel_w), .mux_in1(alu2input), .mux_in2(writeback_regfile_data), .mux_in3(memory_aluout), .mux_in4(), .mux_out(forwardB_out_w) );

    fb_unt fu (.forwardA(forwardA_sel_w), .forwardB(forwardB_sel_w), .ex_mem_regWrite(memory_wb_exee[1]), .mem_wb_regWrite(writeback_ctrl[1]), .ex_mem_rd(memory_regfiledst), .mem_wb_rd(writeback_regfileaddress), .id_ex_rt(decode_exe_out[5:3]), .id_ex_rs(r_out) );

//Stage4: Memory// 
mux16 mux16_PCsrc (.mux_sel(memory_wb_2[0]), .mux_in1(instructionplus1), .mux_in2(aluadd_beq), .mux_out(pcsource));  

datamemory dataMem (.clk(clk) , .address(memory_aluout) , .read_data(memory_dataout) , .write_data(memory_data2) , .wr(memory_mem[2]) , .rd(memory_mem[1]) ); 

memorywb mem_wb_i(
	.clk(clk), 
	   
	.idex_data_in({memory_dataout,memory_aluout}), 
	.idex_data_out({writeback_regwritedata,writeback_mux_in0}),

	.reg_addr_in(memory_regfiledst),
	.reg_addr_out(writeback_regfileaddress),

	.wb_ctrl_in(memory_wb_exee),
	.wb_ctrl_out(writeback_ctrl)
);

//Stage5: Writeback//

mux16 mux16_WB (.mux_sel(writeback_ctrl[0]), .mux_in1(writeback_mux_in0), .mux_in2(writeback_regwritedata), .mux_out(writeback_regfile_data));





endmodule