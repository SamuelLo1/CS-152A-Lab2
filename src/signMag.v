/*
Input: takes in two's complement 12 bit number
Output: 
    1 sign bit 
    11 magnitude bits

Description: 
    If the sign bit is 0, the magnitude bits are the same as the input bits.
    If the sign bit is 1, the magnitude bits are the two's complement of the input bits.

    Edge case: In the event of the most negative number possible: -2048 should be reprsented as 1 2048
*/
module signMag(
    input [11:0] D,
    output S,
    output [10:0] magnitude
); 

    reg signBit;
    reg [10:0] magBits;

    /* 
    Whenver input changes perform the following
        - extract the sign bit from the rest of 
        - take two's complement 
        - need to ensure edgecase handled 

    */
    always @(D) begin
        signBit = D[11];
        magBits = D[10:0];

        if (signBit == 1'b1) begin
            /* undo two' comp */ 
            magBits = ~(D[10:0] - 11'd1);
        end

        /* edge case */
        if (D == 12'b100000000000) begin
            magBits = 11'b11111111111; 
        end

    end

    assign S = signBit;
    assign magnitude = magBits;

endmodule

