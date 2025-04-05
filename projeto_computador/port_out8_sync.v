module port_out8_sync
	(output reg [7:0] port_out_00,
	 output reg [7:0] port_out_01,
	 output reg [7:0] port_out_02,
	 output reg [7:0] port_out_03,
	 output reg [7:0] port_out_04,
	 output reg [7:0] port_out_05,
	 output reg [7:0] port_out_06,
	 output reg [7:0] port_out_07,
	 output reg [7:0] port_out_08,
	 output reg [7:0] port_out_09,
	 output reg [7:0] port_out_10,
	 output reg [7:0] port_out_11,
	 output reg [7:0] port_out_12,
	 output reg [7:0] port_out_13,
	 output reg [7:0] port_out_14,
	 output reg [7:0] port_out_15,
	 input wire [7:0] address,
	 input wire [7:0] data_in,
	 input wire write, clk, reset);
	 
	 // port_out_00 (address E0)
	 always @ (posedge clock or negedge reset)
		begin
			if (!reset)
				port_out_00 <= 8’h00; 
			else if (address == 8’hE0) && (write)) 
				port_out_00 <= data_in;
		end
				
	 // port_out_01 (address E2)
	 always @ (posedge clock or negedge reset)
		begin
			if (!reset)
				port_out_01 <= 8’h00; 
			else if (address == 8’hE1) && (write)) 
				port_out_01 <= data_in;
		end
		
	 // port_out_02 (address E2)
	 always @ (posedge clock or negedge reset)
		begin
			if (!reset)
				port_out_02 <= 8’h00; 
			else if (address == 8’hE2) && (write)) 
				port_out_02 <= data_in;
		end	
		
	 // port_out_03 (address E3)
	 always @ (posedge clock or negedge reset)
		begin
			if (!reset)
				port_out_03 <= 8’h00; 
			else if (address == 8’hE3) && (write)) 
				port_out_03 <= data_in;
		end	
		
	 // port_out_04 (address E4)
	 always @ (posedge clock or negedge reset)
		begin
			if (!reset)
				port_out_04 <= 8’h00; 
			else if (address == 8’hE4) && (write)) 
				port_out_04 <= data_in;
		end	
	 	
	 // port_out_05 (address E5)		
	 always @ (posedge clock or negedge reset)
		begin
			if (!reset)
				port_out_05 <= 8’h00; 
			else if (address == 8’hE5) && (write)) 
				port_out_05 <= data_in;
		end
		
	 // port_out_06 (address E6)		
	 always @ (posedge clock or negedge reset)
		begin
			if (!reset)
				port_out_06 <= 8’h00; 
			else if (address == 8’hE6) && (write)) 
				port_out_06 <= data_in;
		end	
		
	 // port_out_07 (address E7)		
	 always @ (posedge clock or negedge reset)
		begin
			if (!reset)
				port_out_07 <= 8’h00; 
			else if (address == 8’hE7) && (write)) 
				port_out_07 <= data_in;
		end	
		
	 // port_out_08 (address E8)		
	 always @ (posedge clock or negedge reset)
		begin
			if (!reset)
				port_out_08 <= 8’h00; 
			else if (address == 8’hE8) && (write)) 
				port_out_08 <= data_in;
		end	
		
	 // port_out_09 (address E9)		
	 always @ (posedge clock or negedge reset)
		begin
			if (!reset)
				port_out_09 <= 8’h00; 
			else if (address == 8’hE9) && (write)) 
				port_out_09 <= data_in;
		end	
		
	 // port_out_10 (address EA)		
	 always @ (posedge clock or negedge reset)
		begin
			if (!reset)
				port_out_10 <= 8’h00; 
			else if (address == 8’hEA) && (write)) 
				port_out_10 <= data_in;
		end	
		
	 // port_out_11 (address EB)		
	 always @ (posedge clock or negedge reset)
		begin
			if (!reset)
				port_out_11 <= 8’h00; 
			else if (address == 8’hEB) && (write)) 
				port_out_11 <= data_in;
		end	
		
	 // port_out_12 (address EC)		
	 always @ (posedge clock or negedge reset)
		begin
			if (!reset)
				port_out_12 <= 8’h00; 
			else if (address == 8’hEC) && (write)) 
				port_out_12 <= data_in;
		end	
		
	 // port_out_13 (address ED)		
	 always @ (posedge clock or negedge reset)
		begin
			if (!reset)
				port_out_13 <= 8’h00; 
			else if (address == 8’hED) && (write)) 
				port_out_13 <= data_in;
		end
		
	 // port_out_14 (address EE)		
	 always @ (posedge clock or negedge reset)
		begin
			if (!reset)
				port_out_14 <= 8’h00; 
			else if (address == 8’hEE) && (write)) 
				port_out_14 <= data_in;
		end	
		
	 // port_out_15 (address EF)		
	 always @ (posedge clock or negedge reset)
		begin
			if (!reset)
				port_out_15 <= 8’h00; 
			else if (address == 8’hEF) && (write)) 
				port_out_15 <= data_in;
		end					
endmodule