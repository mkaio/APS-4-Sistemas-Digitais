`include "cpu.v"
`include "memory.v"

module computer 
	(output wire [7:0] port_out_00,
	 output wire [7:0] port_out_01,
	 output wire [7:0] port_out_02,
	 output wire [7:0] port_out_03,
	 output wire [7:0] port_out_04,
	 output wire [7:0] port_out_05,
	 output wire [7:0] port_out_06,
	 output wire [7:0] port_out_07,
	 output wire [7:0] port_out_08,
	 output wire [7:0] port_out_09,
	 output wire [7:0] port_out_10,
	 output wire [7:0] port_out_11,
	 output wire [7:0] port_out_12,
	 output wire [7:0] port_out_13,
	 output wire [7:0] port_out_14,
	 output wire [7:0] port_out_15,
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
	 input wire clk, reset);
	 
	wire [7:0] address; 
	wire [7:0] to_memory;
	wire [7:0] from_memory;
	wire write;

	cpu cpu0 (
		.address(address),
		.to_memory(to_memory),
		.from_memory(from_memory),
		.write(write),
		.clk(clk),
		.reset(reset)
	);

	memory memory0 (
		.port_out_00(port_out_00),
		.port_out_01(port_out_01),
		.port_out_02(port_out_02),
		.port_out_03(port_out_03),
		.port_out_04(port_out_04),
		.port_out_05(port_out_05),
		.port_out_06(port_out_06),
		.port_out_07(port_out_07),
		.port_out_08(port_out_08),
		.port_out_09(port_out_09),
		.port_out_10(port_out_10),
		.port_out_11(port_out_11),
		.port_out_12(port_out_12),
		.port_out_13(port_out_13),
		.port_out_14(port_out_14),
		.port_out_15(port_out_15),
		.data_out(from_memory),
		.port_in_00(port_in_00),
		.port_in_01(port_in_01),
		.port_in_02(port_in_02),
		.port_in_03(port_in_03),
		.port_in_04(port_in_04),
		.port_in_05(port_in_05),
		.port_in_06(port_in_06),
		.port_in_07(port_in_07),
		.port_in_08(port_in_08),
		.port_in_09(port_in_09),
		.port_in_10(port_in_10),
		.port_in_11(port_in_11),
		.port_in_12(port_in_12),
		.port_in_13(port_in_13),
		.port_in_14(port_in_14),
		.port_in_15(port_in_15),
		.data_in(to_memory),
		.write(write),
		.clk(clk),
		.reset(reset),
		.address(address)
	);
	 		
endmodule