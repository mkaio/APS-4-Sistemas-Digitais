module data_path 
	(output reg [7:0] address,
	 output reg [7:0] to_memory,
	 output reg [7:0] IR_out,
	 output reg [3:0] CCR_Result, 
	 input wire [7:0] from_memory,
	 input wire [2:0] ALU_Sel,
	 input wire [1:0] Bus1_Sel, Bus2_Sel,
	 input wire IR_Load, MAR_Load, PC_Load, A_Load, B_Load, CCR_Load,  
     input wire Clk, Reset);
     
     wire [7:0] Bus1, Bus2;
     wire [7:0] PC, MAR, A, B, ALU_Result;
     
     always @ (Bus1_Sel, PC, A, B) 
     	begin: MUX_BUS1
			case (Bus1_Sel)
				2’b00 : Bus1 = PC;
				2’b01 : Bus1 = A;
				2’b10 : Bus1 = B; 
				default : Bus1 = 8’hXX;
			endcase 
		end
		
	 always @ (Bus2_Sel, ALU_Result, Bus1, from_memory) 
		begin: MUX_BUS2
			case (Bus2_Sel)
				2’b00 : Bus2 = ALU_Result;
				2’b01 : Bus2 = Bus1;
				2’b10 : Bus2 = from_memory; 
				default : Bus2 = 8’hXX;
			endcase 
		end	
		
	 always @ (Bus1, MAR) 
	 	begin
			to_memory = Bus1;
			address = MAR; 
		end
  
	// Complement the module
  
endmodule