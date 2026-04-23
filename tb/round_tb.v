module round_tb;

    reg        round_bit;
    reg  [3:0] significand;
    reg  [2:0] exponent;
    wire [3:0] F;
    wire [2:0] E;

    seq_add uut (
        .F(F),
        .E(E),
        .round_bit(round_bit),
        .significand(significand),
        .exponent(exponent)
    );

    initial begin
        $display("round_bit | significand | exponent | F    | E   | note");
        $display("----------+-------------+----------+------+-----+-----");

        // ---- truncate (round_bit = 0) ----
        round_bit = 0; significand = 'b0000; exponent = 'b000; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | truncate zero", round_bit, significand, exponent, F, E);

        round_bit = 0; significand = 'b0001; exponent = 'b000; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | truncate min nonzero sig", round_bit, significand, exponent, F, E);

        round_bit = 0; significand = 'b1111; exponent = 'b000; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | truncate max sig, min exp", round_bit, significand, exponent, F, E);

        round_bit = 0; significand = 'b1111; exponent = 'b111; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | truncate max sig, max exp", round_bit, significand, exponent, F, E);

        round_bit = 0; significand = 'b1010; exponent = 'b011; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | truncate mid values", round_bit, significand, exponent, F, E);

        round_bit = 0; significand = 'b0101; exponent = 'b101; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | truncate alternating bits", round_bit, significand, exponent, F, E);

        round_bit = 0; significand = 'b1000; exponent = 'b100; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | truncate normalized sig", round_bit, significand, exponent, F, E);

        // ---- round up, no overflow (round_bit = 1, sig != 1111) ----
        round_bit = 1; significand = 'b0000; exponent = 'b000; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | round up from zero", round_bit, significand, exponent, F, E);

        round_bit = 1; significand = 'b0001; exponent = 'b000; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | round up min nonzero", round_bit, significand, exponent, F, E);

        round_bit = 1; significand = 'b0111; exponent = 'b000; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | round up to 1000", round_bit, significand, exponent, F, E);

        round_bit = 1; significand = 'b1010; exponent = 'b011; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | round up mid sig", round_bit, significand, exponent, F, E);

        round_bit = 1; significand = 'b1110; exponent = 'b011; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | round up to max sig 1111", round_bit, significand, exponent, F, E);

        round_bit = 1; significand = 'b1000; exponent = 'b000; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | round up normalized min", round_bit, significand, exponent, F, E);

        round_bit = 1; significand = 'b0101; exponent = 'b101; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | round up alternating bits", round_bit, significand, exponent, F, E);

        // ---- overflow, exponent not maxed (round_bit = 1, sig == 1111, exp != 111) ----
        round_bit = 1; significand = 'b1111; exponent = 'b000; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | overflow exp 0->1", round_bit, significand, exponent, F, E);

        round_bit = 1; significand = 'b1111; exponent = 'b001; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | overflow exp 1->2", round_bit, significand, exponent, F, E);

        round_bit = 1; significand = 'b1111; exponent = 'b010; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | overflow exp 2->3", round_bit, significand, exponent, F, E);

        round_bit = 1; significand = 'b1111; exponent = 'b011; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | overflow exp 3->4", round_bit, significand, exponent, F, E);

        round_bit = 1; significand = 'b1111; exponent = 'b100; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | overflow exp 4->5", round_bit, significand, exponent, F, E);

        round_bit = 1; significand = 'b1111; exponent = 'b101; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | overflow exp 5->6", round_bit, significand, exponent, F, E);

        round_bit = 1; significand = 'b1111; exponent = 'b110; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | overflow exp 6->7", round_bit, significand, exponent, F, E);

        // ---- overflow, exponent maxed — clamp (round_bit = 1, sig == 1111, exp == 111) ----
        round_bit = 1; significand = 'b1111; exponent = 'b111; #10;
        $display("    %b     |     %b    |   %b    | %b | %b | overflow exp maxed, clamp", round_bit, significand, exponent, F, E);

        $finish;
    end

endmodule