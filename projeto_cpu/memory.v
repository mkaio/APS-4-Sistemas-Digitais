module memory 
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
	 output reg [7:0] data_out,
	 input wire [7:0] address,
	 input wire [7:0] data_in,
	 input wire [7:0] port_in_00,
	 input wire [7:0] port_in_01,
	 input wire [7:0] port_in_02,
	 input wire [7:0] port_in_03,
	 input wire [7:0] port_in_04,
	 input wire [7:0] port_in_05,
	 input wire [7:0] port_in_06,
	 input wire [7:0] port_in_07,
	 input wire [7:0] port_in_08,
	 input wire [7:0] port_in_09,
	 input wire [7:0] port_in_10,
	 input wire [7:0] port_in_11,
	 input wire [7:0] port_in_12,
	 input wire [7:0] port_in_13,
	 input wire [7:0] port_in_14,
	 input wire [7:0] port_in_15,
	 input wire write, clk, reset);
	 
	wire [7:0] rom_data_out, rw_data_out;
	
	always @ (address, rom_data_out, rw_data_out, port_in_00, port_in_01, port_in_02, port_in_03, port_in_04, port_in_05, port_in_06, port_in_07, port_in_08, port_in_09, port_in_10, port_in_11, port_in_12, port_in_13, port_in_14, port_in_15)

	begin: Multiplexing_to_Memory_Data_Bus
		if ( (address >= 0) && (address <= 127) ) 
			data_out = rom_data_out;
		else if ( (address >= 128) && (address <= 223) ) 
			data_out = rw_data_out;
		else if (address == 8'hF0) 
			data_out = port_in_00; 
		else if (address == 8'hF1) 
			data_out = port_in_01; 
		else if (address == 8'hF2) 
			data_out = port_in_02; 
		else if (address == 8'hF3) 
			data_out = port_in_03; 
		else if (address == 8'hF4) 
			data_out == port_in_04; 
		else if (address == 8'hF5) 
			data_out == port_in_05; 
		else if (address == 8'hF6) 
			data_out = port_in_06; 
		else if (address == 8'hF7) 
			data_out = port_in_07; 
		else if (address == 8'hF8) 
			data_out = port_in_08; 
		else if (address == 8'hF9) 
			data_out = port_in_09; 
		else if (address == 8'hFA) 
			data_out = port_in_10; 
		else if (address == 8'hFB) 
			data_out = port_in_11; 
		else if (address == 8'hFC) 
			data_out = port_in_12; 
		else if (address == 8'hFD) 
			data_out = port_in_13; 
		else if (address == 8'hFE) 
			data_out = port_in_14; 
		else if (address == 8'hFF) 
			data_out = port_in_15;
	end
	
	// Complement the module
	 		
endmodule