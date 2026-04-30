module fpcvt_tb;

    reg signed [10:0] test_input;
    wire [2:0] test_E;
    wire [3:0] test_F;
    wire test_sign;

    fpcvt uut (
        .signedIn(test_input),
        .E(test_E),
        .F(test_F),
        .sign(test_sign)
    );

    initial begin
        // Initialize inputs
        test_input = 0;

        // Monitor changes in the console
        $monitor("Time=%0t | Input=%d | Sign=%b | E=%d | F=%b", 
                 $time, test_input, test_sign, test_E, test_F);

        // Test Case 1: Positive number
        #10 test_input = 11'b00000010101; // 21 in decimal

        // Test Case 2: Negative number
        #10 test_input = -11'b00000010101; // -21 in decimal

        // Test Case 3: Edge case (most negative number)
        #10 test_input = -11'b10000000000; // -1024 in decimal

        // Test Case 4: Zero
        #10 test_input = 11'b00000000000; // 0 in decimal

        #10 $finish;
    end



endmodule