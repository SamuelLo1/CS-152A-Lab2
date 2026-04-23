`timescale 1ns / 1ps

`include "src/countZeros.v"
`include "src/round.v"
`include "src/signMag.v"

module tb_fpcvt;
    reg signed [10:0] signedIn;
    wire [2:0] E;
    wire [3:0] F;
    wire sign;

    // Instantiate the fpcvt module
    fpcvt uut (
        .signedIn(signedIn),
        .E(E),
        .F(F),
        .sign(sign)
    );

    initial begin
        $display("signedIn (dec) | signedIn (bin)                  | Sign | E | F  | note");
        $display("---------------+----------------------------------+------+---+-----+-----");

        // Test 1: Zero
        signedIn = 0;
        #10;
        $display("      %0d       | %b |  %b  | %b | %b | zero", signedIn, signedIn, sign, E, F);

        // Test 2: Small positive
        signedIn = 1;
        #10;
        $display("      %0d       | %b |  %b  | %b | %b | small positive", signedIn, signedIn, sign, E, F);

        // Test 3: Small positive
        signedIn = 5;
        #10;
        $display("      %0d       | %b |  %b  | %b | %b | small positive", signedIn, signedIn, sign, E, F);

        // Test 4: Medium positive
        signedIn = 100;
        #10;
        $display("      %0d      | %b |  %b  | %b | %b | medium positive", signedIn, signedIn, sign, E, F);

        // Test 5: Large positive
        signedIn = 1023;
        #10;
        $display("     %0d      | %b |  %b  | %b | %b | large positive (max)", signedIn, signedIn, sign, E, F);

        // Test 6: Small negative
        signedIn = -1;
        #10;
        $display("      %0d       | %b |  %b  | %b | %b | small negative", signedIn, signedIn, sign, E, F);

        // Test 7: Small negative
        signedIn = -5;
        #10;
        $display("      %0d       | %b |  %b  | %b | %b | small negative", signedIn, signedIn, sign, E, F);

        // Test 8: Medium negative
        signedIn = -100;
        #10;
        $display("     %0d      | %b |  %b  | %b | %b | medium negative", signedIn, signedIn, sign, E, F);

        // Test 9: Large negative
        signedIn = -1023;
        #10;
        $display("    %0d      | %b |  %b  | %b | %b | large negative (min)", signedIn, signedIn, sign, E, F);

        // Test 10: Powers of 2
        signedIn = 512;
        #10;
        $display("     %0d      | %b |  %b  | %b | %b | power of 2", signedIn, signedIn, sign, E, F);

        signedIn = -512;
        #10;
        $display("    %0d      | %b |  %b  | %b | %b | negative power of 2", signedIn, signedIn, sign, E, F);

        // Test 11: Random values
        signedIn = 42;
        #10;
        $display("      %0d       | %b |  %b  | %b | %b | random", signedIn, signedIn, sign, E, F);

        signedIn = -42;
        #10;
        $display("     %0d       | %b |  %b  | %b | %b | negative random", signedIn, signedIn, sign, E, F);

        #10 $finish;
    end

endmodule