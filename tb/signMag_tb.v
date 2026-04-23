module signMag_tb();
    // 1. Declare signals
    reg [11:0] test_in;
    wire test_S;
    wire [10:0] test_mag;

    // 2. Instantiate the module under test (UUT)
    signMag uut (
        .in(test_in),
        .S(test_S),
        .magnitude(test_mag)
    );

    // 3. Stimulus process
    initial begin
        // Setup waveform dumping for VS Code (using GTKWave)
        $dumpfile("simulation.vcd");
        $dumpvars(0, signMag_tb);

        // Test Positive Number
        test_in = 12'd5; #10;
        $display("In: %d | S: %b | Mag: %d", test_in, test_S, test_mag);

        // Test Negative Number (-5)
        test_in = -12'd5; #10;
        $display("In: %d | S: %b | Mag: %d", test_in, test_S, test_mag);

        // Test Edge Case (-2048)
        test_in = 12'b1000_0000_0000; #10;
        $display("In: %d | S: %b | Mag: %d", test_in, test_S, test_mag);

        $finish;
    end
endmodule