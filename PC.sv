
module PC(
  input [1:0] Counter,
  //input Branch_abs,
  input Branch_rel_en, // previous instruction is branch instruction
  input ALU_set_one,   // branch condition for previous instruction is true
  //input Branch_type,   // 0 for bnez, 1 for bez
  input [7:0] Target,  // relative address
  input Init,
  //input Start,         // start next program
  input CLK,
  output logic Halt,   // signal for finish
  output logic [11:0] PC
  );

  logic [9:0] LUT[32]; // lookup table for relative address
  
  always_ff @(posedge CLK) begin
    if (Init) begin
      PC <= 0;
	  Halt <= 1'b0;
	end
    else if (PC == 808)
      PC <= PC;
    //else if (Branch_abs)
    //  PC <= Target;
	else if (Counter != 0)
	  PC <= PC;
    else if (Branch_rel_en && ALU_set_one)begin
	  if (LUT[Target][9] == 0)
      	PC <= PC + LUT[Target][8:0];
	  else
	    PC <= PC - LUT[Target][8:0];
	end
    else
      PC <= PC + 1;

    // Halt only signal one cycle
    if (PC == 169 || PC == 619 || PC == 808) begin
	  if (Counter == 3)
	    Halt <= 1'b1;
	  else
	    Halt <= 1'b0;
	end
	else
	  Halt <= 1'b0; 
  end

  initial begin
    // program 1
    LUT[0] = { 1'b1, 9'd165 };
	// program 3
	LUT[1]  = { 1'b0, 9'd3 };
	LUT[2]  = { 1'b0, 9'd3 };
	LUT[3]  = { 1'b0, 9'd3 };
	LUT[4]  = { 1'b0, 9'd3 };
	LUT[5]  = { 1'b0, 9'd7 };
	LUT[6]  = { 1'b1, 9'd62 };
	LUT[7]  = { 1'b0, 9'd2 };
	LUT[8]  = { 1'b0, 9'd2 };
	LUT[9]  = { 1'b0, 9'd2 };
	LUT[10] = { 1'b0, 9'd2 };
	LUT[11] = { 1'b1, 9'd61 };
	// program 2
	LUT[12] = { 1'b1, 9'd165 };
	LUT[13] = { 1'b0, 9'd70 };
	LUT[14] = { 1'b0, 9'd47 };
	LUT[15] = { 1'b0, 9'd33 };
	LUT[16] = { 1'b0, 9'd134 };
	LUT[17] = { 1'b0, 9'd119 };
	LUT[18] = { 1'b0, 9'd27 };
	LUT[19] = { 1'b0, 9'd22 };
	LUT[20] = { 1'b1, 9'd250 };
  end
  
endmodule 