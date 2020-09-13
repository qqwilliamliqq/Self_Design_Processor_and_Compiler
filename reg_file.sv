module reg_file	#(parameter N=8, W=8) (
  input CLK,
  input write_en,
  input init,
  input [1:0] counter,								 
  input [$clog2(N)-1:0] raddrA,
  input [$clog2(N)-1:0] raddrB,
  input [$clog2(N)-1:0] waddr,
  input        [W-1:0] data_in,
  output logic [W-1:0] data_outA,
  output logic [W-1:0] data_outB
  );

  logic [W-1:0] regs[N];

  always_ff @(posedge CLK) begin
	 if (init) begin
	   for (integer i = 0; i < N; i++) begin
		 regs[i] = 8'b0;
	   end
	   data_outA <= 8'b0;
	   data_outB <= 8'b0;
	 end
	 else begin
	   if (write_en && counter == 1)
	     regs[waddr] <= data_in;

       if (counter == 3) begin
         data_outA <= regs[raddrA];
	     data_outB <= regs[raddrB];
	   end
	   else begin
	     data_outA <= data_outA;
	     data_outB <= data_outB;
       end
     end
  end

endmodule