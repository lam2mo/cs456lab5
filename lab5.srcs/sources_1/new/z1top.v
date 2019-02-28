`timescale 1ns / 1ps

//----------------------------------------------------------------------------
// UC Berkeley, EECS 151/251A FPGA Lab
// Lab 2, Spring 2018, modified for JMU lab5, ALU
// changed SWITCHES to .sel
// Module: z1top.v 
//----------------------------------------------------------------------------
module z1top (
    input sysclk,
    input [3:0] BUTTONS,
    input [1:0] SWITCHES,
    output [5:0] LEDS
);
    structural_alu user_alu (
        .a({12'b0,BUTTONS[1:0]}),
        .b({12'b0,BUTTONS[3:2]}),
        .sel(SWITCHES[1:0]),
        .out(LEDS[3:0])       // Upper bits will be truncated
    );

    // Self test of the structural adder
    wire [13:0] alu_operand1, alu_operand2;
    wire [14:0] structural_out, behavioral_out;
    wire test_fail;
    assign LEDS[4] = ~test_fail;
    assign LEDS[5] = ~test_fail;

    structural_alu structural_test_alu (
        .a(alu_operand1),
        .b(alu_operand2),
        .sel(SWITCHES[1:0]),
        .out(structural_out)
    );

    behavioral_alu behavioral_test_alu (
        .a(alu_operand1),
        .b(alu_operand2),
        .sel(SWITCHES[1:0]),
        .out(behavioral_out)
    );

    alu_tester tester (
        .alu_operand1(alu_operand1),
        .alu_operand2(alu_operand2),
        .structural_alu_out(structural_out),
        .behavioral_alu_out(behavioral_out),
        .clk(sysclk),
        .test_fail(test_fail)
    );
endmodule
