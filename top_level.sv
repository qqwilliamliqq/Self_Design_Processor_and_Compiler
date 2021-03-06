module top_level(
  input start,
  input CLK,
  output halt
  );

  wire [11:0] PC;
  wire [8:0] Instruction;
  wire [7:0] ReadA, ReadB;
  wire [7:0] InA, InB, ALU_out;
  wire [7:0] regWriteValue,
             //memWriteValue,
             mem_out;
  wire [7:0] reg_data_in;
  wire [7:0] ALU_inputB;
  wire [2:0] ALU_op;
  wire       mem_write_en,
             reg_write_en,
			 mem_to_reg,
			 branch_en,
			 ALU_src;
  logic [1:0] counter;   // for sync
  //logic [7:0] ALU_out_reg;
             
  PC PC1(
    .Counter(counter),
    .Branch_rel_en(branch_en),
    .ALU_set_one(ALU_out[0]),
    .Target(ReadB),
	.Init(start),
	.CLK(CLK),
	.Halt(halt),
	.PC(PC)
	);

  inst_rom inst_rom1(
    .InstAddress(PC),
	.InstOut(Instruction)
	);

  control control1(
    .Opcode(Instruction[8:6]),
	.RegWrite(reg_write_en),
	.MemWrite(mem_write_en),
	.MemToReg(mem_to_reg),
	.Branch_en(branch_en),
	.ALUSrc(ALU_src),
	.ALUOp(ALU_op)
	);

  //always_ff @ (posedge CLK) ALU_out_reg <= ALU_out;

  assign reg_data_in = mem_to_reg? mem_out : ALU_out;

  reg_file reg_file1(
    .CLK(CLK),
	.write_en(reg_write_en),
	.init(start),
	.counter(counter),
	.raddrA(Instruction[5:3]),
	.raddrB(Instruction[2:0]),
	.waddr(Instruction[5:3]),
	.data_in(reg_data_in),
	.data_outA(ReadA),
	.data_outB(ReadB)
	);

  assign ALU_inputB = ALU_src ? ReadB : {5'b0,Instruction[2:0]};

  ALU ALU1(
    .INPUTA(ReadA),
	.INPUTB(ALU_inputB),
	.OP(ALU_op),
	.OUT(ALU_out)
	);

  data_mem dm1(
    .CLK(CLK),
	.init(start),
	.Counter(counter),
	.DataAddr(ReadB),
	.ReadMem(1'b1),
	.WriteMem(mem_write_en),
	.DataIn(ReadA),
	.DataOut(mem_out)
	);

  always_ff @(posedge CLK) begin
	 if (start)
	   counter <= 3;
	 else if (counter != 0)
	   counter <= counter - 1;
	 else 
	   counter <= 3;
  end

endmodule

  


  
     