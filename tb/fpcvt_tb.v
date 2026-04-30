module fpcvt_tb;

    reg signed [11:0] test_input;
    wire [2:0] test_E;
    wire [3:0] test_F;
    wire test_sign;

    fpcvt uut (
        .D(test_input),
        .E(test_E),
        .F(test_F),
        .S(test_sign)
    );

    initial begin
        // Initialize inputs
        test_input = 0;

        // Monitor changes in the console
        $monitor("Time=%0t | Input=%d | Sign=%b | E=%d | F=%b", 
                 $time, test_input, test_sign, test_E, test_F);

        // Test Case 1: Positive number
        #10 test_input = 12'b000000101110; // 46 in decimal

        // Test Case 2: Negative number
        #10 test_input = -12'b000000101110; // -46 in decimal

        // Test Case 3: Edge case (most negative number)
        #10 test_input = -12'b10000000000; // -1024 in decimal

        #10 test_input = -12'b100000000000; // -2048 in decimal

        #10 test_input = 12'b011111111111; // 2047 in decimal

        // 1984 in decimal 
        #10 test_input = 12'b011111000000; 

        // Test Case 4: Zero
        #10 test_input = 12'b00000000000; // 0 in decimal

        #10 $finish;
    end



endmodule