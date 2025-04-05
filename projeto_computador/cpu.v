`include "data_path.v"
`include "control_unit.v"

module cpu 
	(output wire [7:0] address,
	 output wire [7:0] to_memory,
	 output wire write,
	 input wire [7:0] from_memory, 
     input wire clk, reset);
             
        wire IR_Load;
    wire MAR_Load;
    wire PC_Load;
    wire PC_Inc;
    wire A_Load;
    wire B_Load;
    wire CCR_Load;
    wire[2:0] ALU_Sel;
    wire[1:0] Bus1_Sel, Bus2_Sel;
    wire[7:0] IR;
    wire[3:0] CCR_Result;


	control_unit ctrl_un0 (
        .IR_Load(IR_Load),
        .MAR_Load(MAR_Load),
        .PC_Load(PC_Load),
        .PC_Inc(PC_Inc),
        .A_Load(A_Load),
        .B_Load(B_Load),
        .CCR_Load(CCR_Load),
        .ALU_Sel(ALU_Sel),
        .Bus1_Sel(Bus1_Sel),
        .Bus2_Sel(Bus2_Sel),
        .write(write),
        .IR(IR),
        .CCR_Result(CCR_Result),
        .Clk(clk),
        .Reset(reset)
	);


	data_path dt_pht0 (
		.address(address),
        .to_memory(to_memory),
        .IR_out(IR),
        .CCR_Result(CCR_Result),
        .from_memory(from_memory),
        .ALU_Sel(ALU_Sel),
        .Bus1_Sel(Bus1_Sel),
        .Bus2_Sel(Bus2_Sel),
        .IR_Load(IR_Load),
        .MAR_Load(MAR_Load),
        .PC_Load(PC_Load),
        .PC_Inc(PC_Inc),
        .A_Load(A_Load),
        .B_Load(B_Load),
        .CCR_Load(CCR_Load),
        .Clk(clk),
        .Reset(reset)
	);



endmodule
