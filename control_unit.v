module control_unit 
	(output reg IR_Load, 
	 output reg MAR_Load, 
	 output reg PC_Load, PC_Inc, 
	 output reg A_Load, B_Load,
	 output reg CCR_Load,
	 output reg [2:0] ALU_Sel,
	 output reg [1:0] Bus1_Sel, Bus2_Sel,
	 output reg write, 
	 input wire [7:0] IR, 
	 input wire [3:0] CCR_Result,
     input wire Clk, Reset);
             
  	reg [7:0] current_state, next_state;
  	parameter S0_FETCH = 0,  //-- Opcode fetch states
              S1_FETCH = 1,
              S2_FETCH = 2,
              
              S3_DECODE = 3, //-- Opcode decode state
              
              S4_LDA_IMM = 4, //-- LDA_IMM execute states
              S5_LDA_IMM = 5,
              S6_LDA_IMM = 6,
              
              S4_LDA_DIR = 7, //-- LDA_DIR execute states
              S5_LDA_DIR = 8,
              S6_LDA_DIR = 9;
              S7_LDA_DIR = 10;
              S8_LDA_DIR = 11;
              
    // Complement the list of possible states of the FSM
            
  	initial
  		begin
    		current_state = S0_FETCH;
    		next_state = S0_FETCH;
    		IR_Load = 0;
    		MAR_Load = 1;
    		PC_Load = 0;
    		PC_Inc = 0;
    		A_Load = 0;
    		B_Load = 0;
    		CCR_Load = 0;
    		ALU_Sel = 3'b000;
    		Bus1_Sel = 2'b00;
    		Bus2_Sel = 2'b01;
    		write = 0;
    	end          
  
  	always @ (posedge Clock or negedge Reset)
  		begin: STATE_MEMORY
  			if (!Reset)
  				current_state <= S0_FETCH;
  			else
  				current_state <= next_state;
  		end
  	
  	always @ (current_state)
  		begin: NEXT_STATE_LOGIC
  			case (current_state)
  				S0_FETCH : next_state = S1_FETCH;
  				S1_FETCH : next_state = S2_FETCH;
  				S2_FETCH : next_state = S3_FETCH;
  				
  				S_DECODE_3 : if (IR == LDA_IMM) next_state = S4_LDA_IMM;
  							 else if (IR == LDA_DIR) next_state = S4_LDA_DIR;
  							 // ... Complement with all possible S4 variants 
  			 
  				S4_LDA_IMM : next_state = S5_LDA_IMM; // Execute LDA_IMM  
  				S5_LDA_IMM : next_state = S6_LDA_IMM;
				S6_LDA_IMM : next_state = S0_FETCH;
  							 
  				// Complement the next state logic for the complete instruction set 

  				default  : next_state = S0_FETCH;
  			endcase
  		end
  	
  		always @ (current_state)
  			begin: OUTPUT_LOGIC
  				case (current_state)
  				
  					S0_FETCH : 
  						begin // Put PC onto MAR to provide address of Opcode 
  							IR_Load = 0;
							MAR_Load = 1;
							PC_Load = 0;
							PC_Inc = 0;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
 							write = 0;
						end
						
					S1_FETCH : 
  						begin // Increment PC 
  							IR_Load = 0;
							MAR_Load = 0;
							PC_Load = 0;
							PC_Inc = 1;
 							A_Load = 0;
							B_Load = 0;
 							ALU_Sel = 3'b000;
 							CCR_Load = 0;
 							Bus1_Sel = 2'b00; // PC, A, B
  							Bus2_Sel = 2'b01; // ALU, Bus1, from_memory
 							write = 0;
						end
						
				// Complement the output logic for the complete instruction set 
				
  				endcase
  			end
  			   				
  
endmodule