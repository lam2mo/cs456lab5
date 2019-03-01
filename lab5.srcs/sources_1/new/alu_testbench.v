`timescale 1ns/1ns

module alu_testbench();
    reg clock;

    initial clock = 0;
    always #(2) clock <= ~clock;
    // Self test of the structural alu
    wire [13:0] alu_operand1, alu_operand2;
    wire [1:0] alu_sel;
    wire [14:0] structural_alu_out, behavioral_alu_out;
    wire test_fail;

    structural_alu structural_test_alu (
        .a(alu_operand1),
        .b(alu_operand2),
        .sel(alu_sel),
        .out(structural_alu_out)
    );

    behavioral_alu behavioral_test_alu (
        .a(alu_operand1),
        .b(alu_operand2),
        .sel(alu_sel),
        .out(behavioral_alu_out)
    );

    alu_tester tester (
        .alu_operand1(alu_operand1),
        .alu_operand2(alu_operand2),
        .sel(alu_sel),
        .structural_out(structural_alu_out),
        .behavioral_out(behavioral_alu_out),
        .clk(clock),
        .test_fail(test_fail)
    );

    initial begin
        #700_000_000;
        #700_000_000;
        $finish();
    end
endmodule
