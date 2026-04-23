module fpcvt (
    input signed [10:0] signedIn,
    output [2:0] exponent,
    output [3:0] significand,
    output sign
);

    // Internal wires
    wire [10:0] magnitude;
    wire [2:0] exp_uncorrected;
    wire [3:0] sig_uncorrected;
    wire roundBit;
    wire [2:0] exp_rounded;
    wire [3:0] sig_rounded;

    // Stage 1: Convert signed input to sign-magnitude
    signMag u_signMag (
        .signedIn(signedIn),
        .sign(sign),
        .magnitude(magnitude)
    );

    // Stage 2: Count leading zeros to get exponent and significand
    countZeros u_countZeros (
        .magnitude(magnitude),
        .exponent(exp_uncorrected),
        .significand(sig_uncorrected),
        .roundBit(roundBit)
    );

    // Stage 3: Apply rounding to get final significand and exponent
    round u_round (
        .round_bit(roundBit),
        .significand(sig_uncorrected),
        .exponent(exp_uncorrected),
        .F(sig_rounded),
        .E(exp_rounded)
    );

    // Output assignment
    assign exponent = exp_rounded;
    assign significand = sig_rounded;

endmodule