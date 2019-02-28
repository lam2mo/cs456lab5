module structural_alu (
    input [13:0] a,
    input [13:0] b,
    input [1:0] sel,
    output [14:0] out
);
    wire [14:0] carry_in;
    assign carry_in[0] = 0;
    genvar i;
    generate
    for (i = 0; i<14; i=i+1)
        begin:alus
            full_alu alu0 (
                .a(a[i]),
                .b(b[i]),
                .carry_in(carry_in[i]),
                .sel(sel),
                .out(out[i]),
                .carry_out(carry_in[i+1])
            );
        end
    endgenerate
    assign out[14] = carry_in[14] & ~sel[0] & sel[1];
endmodule
