module seq_add (/*AUTOARG*/
   // Outputs
   F, D,
   // Inputs
   round_bit, significand, exponent
   );

    output reg [3:0] F;
    output reg [2:0] D;

    input            round_bit;
    input      [3:0] significand;
    input      [2:0] exponent;

    always @(*) begin
        // If the fifth bit following is 1
        if (round_bit) begin
            if (significand == 'b1111) begin // If the maximum Significand [1111] is rounded up
                if (exponent == 'b111) begin
                    F = 'b1111;
                    D = 'b111;
                end else begin
                    F = 'b1000; // shift right to obtain 1000
                    D = exponent + 'b001; // increase the Exponent by 1 to compensate
                end
            // round the first four bits up by adding 1
            end else begin
                F = significand + 'b0001; // the Significand is incremented by 1
                D = exponent;
            end
        // If the fifth bit following is 0, use the first four bits
        end else begin
            F = significand;
            D = exponent;
        end
    end

endmodule