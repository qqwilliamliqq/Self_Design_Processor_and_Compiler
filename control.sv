module control (
  input [2:0] Opcode,
  output logic RegWrite,
  output logic MemWrite,
  output logic MemToReg,
  output logic Branch_en,
  output logic ALUSrc,
  output logic [2:0] ALUOp
  );

  always_comb begin
    case (Opcode)
	  3'b000: begin // load
	    RegWrite = 1;
		MemWrite = 0;
		MemToReg = 1;
		Branch_en = 0;
		ALUSrc = 0;
		ALUOp = 3'b111;
	  end
	  3'b001: begin // store
	    RegWrite = 0;
		MemWrite = 1;
		MemToReg = 0;
		Branch_en = 0;
		ALUSrc = 0;
		ALUOp = 3'b111;
	  end
	  3'b010: begin // xor
	    RegWrite = 1;
		MemWrite = 0;
		MemToReg = 0;
		Branch_en = 0;
		ALUSrc = 1;
		ALUOp = 3'b001;
	  end
	  3'b011: begin // add
	    RegWrite = 1;
		MemWrite = 0;
		MemToReg = 0;
		Branch_en = 0;
		ALUSrc = 0;
		ALUOp = 3'b000;
	  end
	  3'b100: begin // left shift
	    RegWrite = 1;
		MemWrite = 0;
		MemToReg = 0;
		Branch_en = 0;
		ALUSrc = 0;
		ALUOp = 3'b010;
	  end
	  3'b101: begin // right shift
	    RegWrite = 1;
		MemWrite = 0;
		MemToReg = 0;
		Branch_en = 0;
		ALUSrc = 0;
		ALUOp = 3'b011;
	  end
	  3'b110: begin // branch not equal zero
	    RegWrite = 0;
		MemWrite = 0;
		MemToReg = 0;
		ALUSrc = 0;
		Branch_en = 1;
		ALUOp = 3'b100;
	  end
	  3'b111: begin // register left shift
	    RegWrite = 1;
		MemWrite = 0;
		MemToReg = 0;
		ALUSrc = 1;
		Branch_en = 0;
		ALUOp = 3'b101;
      end
	  default: begin
	    RegWrite = 0;
		MemWrite = 0;
		MemToReg = 0;
		Branch_en = 0;
		ALUSrc = 0;
		ALUOp = 3'b111;
	  end
	endcase
  end

endmodule
