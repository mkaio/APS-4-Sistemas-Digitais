`timescale 1ns/1ps

module ALUb
	(output reg [7:0] Result,
	output reg [3:0] NZVC, //Flags: Negative, Zero, Overflow, Carry
	input wire [7:0] A, B,
	input wire [2:0] ALU_Sel);

	// NZVC[0] -> indica carry out ||| NZVC[1] -> indica overflow ||| NZVC[2] -> indica 0 ||| NZVC[3] -> indica negativo

	always @ (A, B, ALU_Sel)
		begin
			case (ALU_Sel)
				
				// PARTE ARITMETICA
				3'b000: begin		// soma entre as duas palavras
							{NZVC[0], Result} = A + B; 		// indicador carry out
							NZVC[3] = Result[7];			// indicador negativo
							if (Result==0)
								NZVC[2] = 1;				// indicador 0
							else
								NZVC[2] = 0;
							if (A[7]==0 && B[7]==0 && Result[7]==1) 		// indicador overflow
								NZVC[1] = 1;
							else if (A[7]==1 && B[7]==1 && Result[7]==0)
								NZVC[1] = 1;
							else
								NZVC[1] = 0;
						end
				3'b001: begin		// icremento de A
							{NZVC[0], Result} = A + 1;
							NZVC[3] = Result[7];
							if (Result==0)
								NZVC[2] = 1;
							else
								NZVC[2] = 0;
							if (A[7]==0 && Result[7]==1) 
								NZVC[1] = 1;
							else
								NZVC[1] = 0;
						end	
				3'b010: begin		// subtração das duas palavras
							{NZVC[0], Result} = A - B;
							NZVC[3] = Result[7];
							if (Result==0)
								NZVC[2] = 1;
							else
								NZVC[2] = 0;
							if (A[7]==0 && B[7]==1 && Result[7]==1) 
								NZVC[1] = 1;
							else if (A[7]==1 && B[7]==0 && Result[7]==0)
								NZVC[1] = 1;
							else 
								NZVC[1] = 0;
						end
				3'b011: begin		// decremento de A
							{NZVC[0], Result} = A - 1;
							NZVC[3] = Result[7];
							if (Result==0)
								NZVC[2] = 1;
							else
								NZVC[2] = 0;
							if (A[7]==1 && Result[7]==0) 
								NZVC[1] = 1;
							else 
								NZVC[1] = 0;          
						end	
				
				// PARTE LOGICA
				3'b100: begin			// AND
							Result = A & B;
							NZVC[3] = Result[7];
							if (Result==0)
								NZVC[2] = 1;
							else
								NZVC[2] = 0;
							NZVC[1] = 0;
							NZVC[0] = 0;
						end
				3'b101: begin		// OR
							Result = A | B;
							NZVC[3] = Result[7];
							if (Result==0)
								NZVC[2] = 1;
							else
								NZVC[2] = 0;
							NZVC[1] = 0;
							NZVC[0] = 0;
						end
				3'b110: begin		// XOR
							Result = A ^ B;
							NZVC[3] = Result[7];
							if (Result==0)
								NZVC[2] = 1;
							else
								NZVC[2] = 0;
							NZVC[1] = 0;
							NZVC[0] = 0;
						end
				3'b111: begin		// INVERSOR A
							Result = ~A;
							NZVC[3] = Result[7];
							if (Result==0)
								NZVC[2] = 1;
							else
								NZVC[2] = 0;
							NZVC[1] = 0;
							NZVC[0] = 0;
						end	
				default: begin
							Result = 8'hXX;
							NZVC = 4'hX; 
						end
				endcase	
		end	
	
endmodule
