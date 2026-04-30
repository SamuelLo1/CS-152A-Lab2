module countZeros (
    input [10:0] magnitude,
    output reg [2:0] exponent,
    output reg [3:0] significand,
    output reg roundBit

);

    wire [11:0] padded_magnitude = {1'b0, magnitude};

    always @(*) begin
        // Pad a leading 0 to account for sign bit (make 12-bit)
        
        $display("[COUNTZEROS] INPUT: magnitude=%b (%d), padded=%b", magnitude, magnitude, padded_magnitude);
        
        // Priority Encoder for Exponent
        // Extract Leading Zeros (with padding accounting for 1 extra leading zero)
        if (padded_magnitude[10]) exponent = 3'd7;      // 1 Leading Zero; exponent = 7
        else if (padded_magnitude[9]) exponent = 3'd6;  // 2 Leading Zeros; exponent = 6
        else if (padded_magnitude[8]) exponent = 3'd5;  // 3 Leading Zeros; exponent = 5
        else if (padded_magnitude[7]) exponent = 3'd4;  // 4 Leading Zeros; exponent = 4
        else if (padded_magnitude[6]) exponent = 3'd3;  // 5 Leading Zeros; exponent = 3
        else if (padded_magnitude[5]) exponent = 3'd2;  // 6 Leading Zeros; exponent = 2
        else if (padded_magnitude[4]) exponent = 3'd1;  // 7 Leading Zeros; exponent = 1
        else exponent = 3'd0;                           // >= 8 Leading Zeros; exponent = 0

        // Significant and Round Bit Extraction
        case (exponent)
            3'd7: begin
                significand = padded_magnitude[10:7];
                roundBit = padded_magnitude[6];
            end
            3'd6: begin 
                significand = padded_magnitude[9:6];
                roundBit = padded_magnitude[5];
            end
            3'd5: begin
                significand = padded_magnitude[8:5];
                roundBit = padded_magnitude[4];
            end
            3'd4: begin
                significand = padded_magnitude[7:4];
                roundBit = padded_magnitude[3];
            end
            3'd3: begin
                significand = padded_magnitude[6:3];
                roundBit = padded_magnitude[2];
            end
            3'd2: begin 
                significand = padded_magnitude[5:2];
                roundBit = padded_magnitude[1];
            end
            3'd1: begin
                significand = padded_magnitude[4:1];
                roundBit = padded_magnitude[0];
            end
            3'd0: begin 
                significand = padded_magnitude[3:0];
                roundBit = 1'b0;
            end
            
            default: significand = 4'b0000;
        endcase
        
        $display("[COUNTZEROS] OUTPUT: exponent=%b (%d), significand=%b (%d), roundBit=%b\n", 
                 exponent, exponent, significand, significand, roundBit);
    end
    
endmodule