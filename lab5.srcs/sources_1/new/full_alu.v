module full_alu (
    input a,
    input b,
    input carry_in,
    input [1:0] sel,
    output out,
    output carry_out
);

    // basic gates
    wire and_ab;
    wire or_ab;
    wire xor_ab;
    and(and_ab, a, b);
    or (or_ab, a, b);
    xor(xor_ab, a, b);
    
    // sum
    wire sum_abc;
    xor(sum_abc, xor_ab, carry_in);   // a + b + c (lsb)
    
    // mux
    wire sel_and;
    wire sel_or;
    wire sel_add;
    and(sel_and, and_ab,  ~sel[0], ~sel[1]);
    and(sel_or,  or_ab,    sel[0], ~sel[1]);
    and(sel_add, sum_abc, ~sel[0],  sel[1]);
    or(out, sel_and, sel_or, sel_add);
    
    // carry
    wire csum;
    and(csum, carry_in, xor_ab);
    or(carry_out, and_ab, csum);      // a + b + c (msb)

endmodule
