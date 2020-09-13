module data_mem #(parameter N=256, W=8) (
  input CLK,
  input init,
  input [1:0] Counter,
  input [$clog2(N)-1:0] DataAddr,
  input ReadMem,
  input WriteMem,
  input [W-1:0] DataIn,
  output logic [W-1:0] DataOut
  );

  logic [W-1:0] core[N];

  always_ff @(posedge CLK) begin
    //if (init)
	  //for (integer i = 0; i < N; i++) begin
	  //	core[i] = 8'b0;
	  //end
	//else begin
	  if (ReadMem)
	    DataOut <= core[DataAddr];
	  if (WriteMem && Counter == 2)
	    core[DataAddr] <= DataIn;
	//end
  end

endmodule
