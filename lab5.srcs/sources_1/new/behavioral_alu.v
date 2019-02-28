module behavioral_alu (
    input [13:0] a,
    input [13:0] b,
    input [1:0] sel,
    output reg [14:0] out
);
    always @(out, a, b, sel)
        case (sel)
            0:          out <= a & b;
            1:          out <= a | b;
            2:          out <= a + b;
            default:    out <= 0;
        endcase
endmodule
