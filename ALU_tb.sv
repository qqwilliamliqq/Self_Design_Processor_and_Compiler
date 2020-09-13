import definitions::*;
module ALU_tb;

  logic CLK;
  logic [7:0] INPUTA,
              INPUTB;
  logic [2:0] OP;
  wire [7:0] OUT;
  
  ALU dut(.*);
  
  always begin
    #1ns CLK = 1'b0;
    #1ns CLK = 1'b1;
  end
  
  initial begin
    INPUTA = 8'b10101010;
    INPUTB = 8'b00000011;
    OP = kADD;
    #10ns;
    OP = kXOR;
    #10ns;
    OP = kSHL;
    #10ns;
    OP = kSHR;
	#10ns
    OP = kSNZ;
    #10ns
    OP = kSEZ;
  end
  
endmodule 
