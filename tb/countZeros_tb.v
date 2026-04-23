`timescale 1ns / 1ps

module tb_countZeros;
    reg [10:0] magnitude;
    wire [2:0] exponent;
    wire [3:0] significand;
    wire roundBit;

    countZeros uut (
        .magnitude(magnitude),
        .exponent(exponent),
        .significand(significand),
        .roundBit(roundBit)
    );

    initial begin
        // Initialize inputs
        magnitude = 0;
        
        // Monitor changes in the console
        $monitor("Time=%0t | Mag=%b | Exp=%d | Sig=%b | R=%b", 
                 $time, magnitude, exponent, significand, roundBit);

        // Test Case 1: magnitude[9] is 1 (Exponent should be 7)
        #10 magnitude = 11'b01011011000; 
        
        // Test Case 2: magnitude[7] is 1 (Exponent should be 5)
        #10 magnitude = 11'b00010110100;
        
        // Test Case 3: magnitude[4] is 1 (Exponent should be 2)
        #10 magnitude = 11'b00000010111;

        // Test Case 4: Bottom range (Exponent should be 0)
        #10 magnitude = 11'b00000000011;

        // Test Case 5: All zeros
        #10 magnitude = 11'b00000000000;

        #10 $finish;
    end

endmodule
