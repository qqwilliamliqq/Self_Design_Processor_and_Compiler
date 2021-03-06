//import definitions::*;
module ALU(
  input [7:0] INPUTA,
              INPUTB,
  input [2:0] OP,
  output logic [7:0] OUT
  );

  //op_mne op_mnemonic;

  always_comb begin
	case (OP)
	  3'b000 : OUT = INPUTA + INPUTB; // add
	  3'b001 : OUT = INPUTA ^ INPUTB; // xor
	  3'b010 : begin // logic left shift
	    if (INPUTB == 8'b0)
	      OUT = INPUTA << 8;
		else
		  OUT = INPUTA << INPUTB;
	  end
	  3'b011 : begin // logic right shift
	    if (INPUTB == 8'b0) 
		  OUT = INPUTA >> 8;
		else
	      OUT = INPUTA >> INPUTB;
	  end
	  3'b100 : OUT = INPUTA != 8'b0 ? 8'b1 : 8'b0; // set not equal zero
	  3'b101 : OUT = INPUTA << INPUTB; // register logic left shift
	   default: OUT = 8'b0;
	endcase

    //op_mnemonic = op_mne'(OP);
  end

endmodule
  
   