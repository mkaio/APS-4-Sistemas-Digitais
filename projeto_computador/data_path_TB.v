`include "data_path.v"
`timescale 1ns/1ps

module tb_data_path;

    reg [7:0] from_memory;
    reg [2:0] ALU_Sel;
    reg [1:0] Bus1_Sel, Bus2_Sel;
    reg IR_Load, MAR_Load, PC_Load, A_Load, B_Load, CCR_Load, PC_Inc;
    reg Clk, Reset;
    
    wire [7:0] address, to_memory, IR_out;
    wire [3:0] CCR_Result;
    
    // Variáveis internas para tracking
    wire [7:0] PC, MAR, A, B, Bus1, Bus2, ALU_Result;
    wire [3:0] NZVC;
    
    // Instanciando o módulo
    data_path uut (
        .address(address),
        .to_memory(to_memory),
        .IR_out(IR_out),
        .CCR_Result(CCR_Result),
        .from_memory(from_memory),
        .ALU_Sel(ALU_Sel),
        .Bus1_Sel(Bus1_Sel),
        .Bus2_Sel(Bus2_Sel),
        .IR_Load(IR_Load),
        .MAR_Load(MAR_Load),
        .PC_Load(PC_Load),
        .A_Load(A_Load),
        .B_Load(B_Load),
        .CCR_Load(CCR_Load),
        .PC_Inc(PC_Inc),
        .Clk(Clk),
        .Reset(Reset)
    );
    
    // Acessando sinais internos
    assign PC = uut.PC;
    assign MAR = uut.MAR;
    assign A = uut.A;
    assign B = uut.B;
    assign Bus1 = uut.Bus1;
    assign Bus2 = uut.Bus2;
    assign ALU_Result = uut.ALU_Result;
    assign NZVC = uut.NZVC;
    
    // Clock generation
    always #5 Clk = ~Clk;
    
    initial begin
        // Monitorando todas as variáveis
        $monitor("Time=%0t | Reset=%b | Clk=%b | from_memory=%h | ALU_Sel=%b | Bus1_Sel=%b | Bus2_Sel=%b | IR_Load=%b | MAR_Load=%b | PC_Load=%b | A_Load=%b | B_Load=%b | CCR_Load=%b | PC_Inc=%b | address=%h | to_memory=%h | IR_out=%h | CCR_Result=%b | PC=%h | MAR=%h | A=%h | B=%h | Bus1=%h | Bus2=%h | ALU_Result=%h | NZVC=%b", 
                 $time, Reset, Clk, from_memory, ALU_Sel, Bus1_Sel, Bus2_Sel, IR_Load, MAR_Load, PC_Load, A_Load, B_Load, CCR_Load, PC_Inc, address, to_memory, IR_out, CCR_Result, PC, MAR, A, B, Bus1, Bus2, ALU_Result, NZVC);
        
        // Inicialização
        Clk = 0;
        Reset = 1;
        from_memory = 8'h0B;
        ALU_Sel = 3'b000;
        Bus1_Sel = 2'b00;
        Bus2_Sel = 2'b00;
        IR_Load = 0;
        MAR_Load = 0;
        PC_Load = 0;
        A_Load = 0;
        B_Load = 0;
        CCR_Load = 0;
        PC_Inc = 0;
        
        // Ativando reset assíncrono
        #2 Reset = 0;
        #5 Reset = 1;
        
        // Teste de carga do PC
        #10 Bus2_Sel = 2'b01; PC_Load = 1;
        #10 PC_Load = 0;
        
        // Teste de incremento do PC
        #10 PC_Inc = 1;
        #10 PC_Inc = 0;
        
        // Teste de carga no IR
        #10 Bus2_Sel = 2'b10; IR_Load = 1;
        #10 IR_Load = 0;
        
        // Teste de carga no MAR
        #10 Bus2_Sel = 2'b10; MAR_Load = 1;
        #10 MAR_Load = 0;
        
        // Teste de carga nos registradores A e B
        #10 Bus2_Sel = 2'b10; A_Load = 1;
        #10 A_Load = 0;
        
        #10 Bus2_Sel = 2'b10; B_Load = 1;
        #10 B_Load = 0;
        
        // Teste da ALU e CCR
        #10 ALU_Sel = 3'b001; CCR_Load = 1;
        #10 CCR_Load = 0;
        
        #50 $finish;
    end

endmodule
