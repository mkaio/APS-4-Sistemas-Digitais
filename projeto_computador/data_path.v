`include "ALUb.v"

module data_path 
	(output reg [7:0] address,
	output reg [7:0] to_memory,
	output reg [7:0] IR_out,
	output reg [3:0] CCR_Result, 
	input wire [7:0] from_memory,
	input wire [2:0] ALU_Sel,
	input wire [1:0] Bus1_Sel, Bus2_Sel,
	input wire IR_Load, MAR_Load, PC_Load, A_Load, B_Load, CCR_Load, PC_Inc,
	input wire Clk, Reset);
	
	wire [3:0] NZVC;
	reg [7:0] IR;
	reg [7:0] Bus1, Bus2;
	reg [7:0] PC, MAR, A, B;
	wire [7:0] ALU_Result;

	always @ (Bus1_Sel, PC, A, B) 
	begin: MUX_BUS1
		case (Bus1_Sel)
			2'b00 : Bus1 = PC;
			2'b01 : Bus1 = A;
			2'b10 : Bus1 = B; 
			default : Bus1 = 8'hXX;
		endcase 
	end
	
	always @ (Bus2_Sel, ALU_Result, Bus1, from_memory) 
	begin: MUX_BUS2
		case (Bus2_Sel)
			2'b00 : Bus2 = ALU_Result;
			2'b01 : Bus2 = Bus1;
			2'b10 : Bus2 = from_memory; 
			default : Bus2 = 8'hXX;
		endcase 
	end	
	
	always @ (Bus1, MAR) 
	begin
		to_memory = Bus1;
		address = MAR; 
	end
  
	always @ (posedge Clk or negedge Reset)
	begin: INSTRUCTION_REGISTER
		if (!Reset)
			IR <= 8'h00;
		else
			if (IR_Load)
				IR <= Bus2;
	end

	always @ (posedge Clk or negedge Reset)
	begin: MEMORY_ADDRESS_REGISTER
		if (!Reset)
			MAR <= 8'h00;
		else
			if (MAR_Load)
				MAR <= Bus2;
	end

	always @ (posedge Clk or negedge Reset)
	begin: PROGRAM_COUNTER
		if (!Reset)
			PC <= 8'h00;
		else
			if (PC_Load)
				PC <= Bus2;
			else if (PC_Inc)
				PC <= MAR + 1;
	end

	always @ (posedge Clk or negedge Reset) // talvez esta sem função de store
	begin: A_REGISTER
		if (!Reset)
			A <= 8'h00;
		else
			if (A_Load)
				A <= Bus2;
	end

	always @ (posedge Clk or negedge Reset) // talvez esta sem função de store
	begin: B_REGISTER
		if (!Reset)
			B <= 8'h00;
		else
			if (B_Load)
				B <= Bus2;
	end

	ALUb alu(.A(A), .B(B), .ALU_Sel(ALU_Sel), .NZVC(NZVC), .Result(ALU_Result));  

	always @ (posedge Clk or negedge Reset) // talvez esteja sem receber informação das flags nzvc do ALU
	begin: CONDITION_CODE_REGISTER
		if (!Reset)
			CCR_Result <= 4'h0;
		else
			if (CCR_Load)
				CCR_Result <= NZVC;
	end

	// necessario criar um testbench baseado em $monitor


endmodule