module countZeros (
    input [10:0] magnitude,
    output reg [2:0] exponent,
    output reg [3:0] significand,
    output reg roundBit
);

    always @(*) begin
        // Priority Encoder for Exponent
        // Extract Leading Zeros 
        if (magnitude[9]) exponent = 3'd7;      // 1 Leading Zero; exponent = 7
        else if (magnitude[8]) exponent = 3'd6; // 2 Leading Zeros; exponent = 6
        else if (magnitude[7]) exponent = 3'd5; // 3 Leading Zeros; exponent = 5
        else if (magnitude[6]) exponent = 3'd4; // 4 Leading Zeros; exponent = 4
        else if (magnitude[5]) exponent = 3'd3; // 5 Leading Zeros; exponent = 3
        else if (magnitude[4]) exponent = 3'd2; // 6 Leading Zeros; exponent = 2
        else if (magnitude[3]) exponent = 3'd1; // 7 Leading Zeros; exponent = 1
        else exponent = 3'd0;                   // >= 8 Leading Zeros; exponent = 0

        // Significant and Round Bit Extraction
        case (exponent)
            3'd7: begin
                significand = magnitude[9:6];
                roundBit = magnitude[5];
            end
            3'd6: begin 
                significand = magnitude[8:5];
                roundBit = magnitude[4];
            end
            3'd5: begin
                significand = magnitude[7:4];
                roundBit = magnitude[3];
            end
            3'd4: begin
                significand = magnitude[6:3];
                roundBit = magnitude[2];
            end
            3'd3: begin
                significand = magnitude[5:2];
                roundBit = magnitude[1];
            end
            3'd2: begin 
                significand = magnitude[4:1];
                roundBit = magnitude[0];
            end
            3'd1: begin
                significand = magnitude[3:0];
                roundBit = 1'b0;
            end
            3'd0: begin 
                significand = magnitude[3:0];
                roundBit = 1'b0;
            end
            
            default: significand = 4'b0000;
        endcase
    end
    
endmodule