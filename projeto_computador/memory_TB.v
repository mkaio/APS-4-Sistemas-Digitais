`timescale 100ns/1ps
`include "memory.v"

module memory_TB;
    reg clk = 0;
    reg reset = 0;
    reg write = 0;
    reg [7:0] address = 8'h00;
    reg [7:0] data_in = 8'h00;

    // Entradas das portas
    reg [7:0] port_in_00 = 8'hAA;
    reg [7:0] port_in_01 = 8'hBB;
    reg [7:0] port_in_15 = 8'hFF;

    // Saídas das portas
    wire [7:0] port_out_00;
    wire [7:0] port_out_01;
    wire [7:0] port_out_02;
    wire [7:0] port_out_03;
    wire [7:0] port_out_04;
    wire [7:0] port_out_05;
    wire [7:0] port_out_06;
    wire [7:0] port_out_07;
    wire [7:0] port_out_08;
    wire [7:0] port_out_09;
    wire [7:0] port_out_10;
    wire [7:0] port_out_11;
    wire [7:0] port_out_12;
    wire [7:0] port_out_13;
    wire [7:0] port_out_14;
    wire [7:0] port_out_15;

    wire [7:0] data_out;

    memory DUT (
        .port_out_00(port_out_00), .port_out_01(port_out_01),
        .port_out_02(port_out_02), .port_out_03(port_out_03),
        .port_out_04(port_out_04), .port_out_05(port_out_05),
        .port_out_06(port_out_06), .port_out_07(port_out_07),
        .port_out_08(port_out_08), .port_out_09(port_out_09),
        .port_out_10(port_out_10), .port_out_11(port_out_11),
        .port_out_12(port_out_12), .port_out_13(port_out_13),
        .port_out_14(port_out_14), .port_out_15(port_out_15),
        .data_out(data_out),
        .address(address),
        .data_in(data_in),
        .port_in_00(port_in_00), .port_in_01(port_in_01),
        .port_in_02(8'h00), .port_in_03(8'h00),
        .port_in_04(8'h00), .port_in_05(8'h00),
        .port_in_06(8'h00), .port_in_07(8'h00),
        .port_in_08(8'h00), .port_in_09(8'h00),
        .port_in_10(8'h00), .port_in_11(8'h00),
        .port_in_12(8'h00), .port_in_13(8'h00),
        .port_in_14(8'h00), .port_in_15(port_in_15),
        .write(write), .clk(clk), .reset(reset)
    );

    always #10 clk = ~clk;

    initial begin
        $dumpfile("memory_TB.vcd");
        $dumpvars(0, memory_TB);

        // Inicialização
        #5 reset = 1;

        // Teste (i): Escrevendo na RAM
        #20 address = 8'h82; data_in = 8'h55; write = 1;
        #20 write = 0;

        // Lendo da RAM
        #40 address = 8'h82;

        // Teste (ii): Lendo da ROM (ex: endereço 0x0A deve conter valor da rom simulada)
        #40 address = 8'h05;

        // Teste (ii): Lendo das portas de entrada (endereços F0, F1, FF)
        #40 address = 8'hF0;
        #40 address = 8'hF1;
        #40 address = 8'hFF;

        // Teste (iii): Escrevendo nas portas de saída (endereços E0, E1, EF)
        #40 address = 8'hE0; data_in = 8'h33; write = 1;
        #20 write = 0;

        #40 address = 8'hE1; data_in = 8'h44; write = 1;
        #20 write = 0;

        #40 address = 8'hEF; data_in = 8'h77; write = 1;
        #20 write = 0;

        #50 $finish;
    end
endmodule
