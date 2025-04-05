`include "control_unit.v"
`timescale 1ns/1ns
module tb_control_unit_monitor;

  // Entradas para o DUT
  reg clk = 0;
  reg reset = 1;
  reg [7:0] IR;
  reg [3:0] CCR_Result;

  // Sinais de controle (saídas)
  wire IR_Load, MAR_Load, PC_Load, PC_Inc, A_Load, B_Load, CCR_Load, write;
  wire [2:0] ALU_Sel;
  wire [1:0] Bus1_Sel, Bus2_Sel;

  // Instanciação da unidade de controle
  control_unit dut (
    .IR(IR),
    .CCR_Result(CCR_Result),
    .Clk(clk),
    .Reset(reset),
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
    .write(write)
  );

  // Geração de clock: período de 10 ns
  always #5 clk = ~clk;

  initial begin
    $display("Iniciando Testbench com $monitor para control_unit...");
    // Mostra tempo, IR, CCR_Result, os estados da FSM e os sinais de controle
    $monitor("T=%0t | IR=%02h | CCR=%b | state=%02h->%02h | IR_Load=%b MAR_Load=%b PC_Load=%b PC_Inc=%b | A_Load=%b B_Load=%b | ALU_Sel=%b | Bus1_Sel=%b Bus2_Sel=%b | write=%b",
             $time, IR, CCR_Result, dut.current_state, dut.next_state,
             IR_Load, MAR_Load, PC_Load, PC_Inc, A_Load, B_Load,
             ALU_Sel, Bus1_Sel, Bus2_Sel, write);

    // Inicialização
    IR = 8'h00;
    CCR_Result = 4'b0000;
    reset = 1;
    #10 reset = 0;  // Aplica reset ativo baixo por 10 ns
    #10 reset = 1;  // Libera o reset

    // Sequência de teste: injetando diferentes IR para simular instruções.
    #20 IR = 8'h86;  // LDA_IMM
    #40 IR = 8'h87;  // LDA_DIR
    #40 IR = 8'h96;  // STA_DIR
    #40 IR = 8'h88;  // LDB_IMM
    #40 IR = 8'h97;  // STB_DIR
    #40 IR = 8'h42;  // ADD_AB
    #40 IR = 8'h4D;  // ADDAB_LDB
    #40 IR = 8'h4B;  // NOTA
    #40 IR = 8'h20;  // BRA
    #40 IR = 8'h23;  // BEQ
    #40 IR = 8'h24;  // BNE
    #40 IR = 8'h21;  // BMI
    #40 IR = 8'h22;  // BPL
    #40 IR = 8'h25;  // BVS
    #40 IR = 8'h26;  // BVC
    #40 IR = 8'h27;  // BCS
    #40 IR = 8'h28;  // BCC
    #40;

    $finish;
  end

endmodule
