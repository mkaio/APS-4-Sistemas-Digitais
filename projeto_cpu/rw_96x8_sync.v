module rw_96x8_sync
	(output reg [7:0] data_out,
	input wire [7:0] address,
	input wire       WE,
	input wire [7:0] data_in,
	input wire       clk);
	
		reg[7:0] RW[128:223];
		reg EN;
		
		always @ (address) 
		begin
		if ( (address >= 128) && (address <= 223) ) 
			EN = 1'b1;
		else
			EN = 1'b0;
		end
		
		always @ (posedge clk)
		begin
			if (WE && EN)
				RW[address] = data_in;
			else if (!WE && EN)
				data_out = RW[address];
		end
	 		
endmodule


