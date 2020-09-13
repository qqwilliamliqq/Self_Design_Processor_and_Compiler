module inst_rom_tb;

  logic CLK;
  logic [11:0] InstAddress;
  wire  [8:0] InstOut;

  inst_rom dut(.*);

  always begin
    #1ns CLK = 1'b0;
    #1ns CLK = 1'b1;
  end

  initial begin
	InstAddress = 12'b0;
	#4ns
	InstAddress++;
	#4ns
	InstAddress++;
	#4ns
	InstAddress++;
  end

endmodule