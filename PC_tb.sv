module PC_tb;

  logic Branch_rel_en;
  logic ALU_set_one;
  logic [7:0] Target;
  logic Init;
  logic CLK;
  wire Halt;
  wire [15:0] PC;

  PC dut(.*);

  always begin
    CLK = 1'b0; #1ns; 
    CLK = 1'b1; #1ns; 
  end

  initial begin
    Init = 1'b1;
	#2ns
	Init = 1'b0;
	Branch_rel_en = 1'b0;
	ALU_set_one = 1'b0;
	Target = 8'b0;
	#10ns
	Branch_rel_en = 1'b1;
	ALU_set_one = 1'b1;
	Target = 8'd10;
  end

endmodule