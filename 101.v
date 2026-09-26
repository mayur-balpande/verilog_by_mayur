// Write code for binary to BCD converter

module q101#(parameter WIDTH = 8,
            parameter DIGITS = 3)(


    input [WIDTH-1:0] binary_in,
    output reg [DIGITS*4-1:0] BCD_out
);

integer i;
integer j;
reg [DIGITS*4-1:0] BCD_temp;

always @(*) begin
    BCD_temp = {(DIGITS*4){1'b0}};
    for (i = WIDTH - 1; i>=0; i=i-1)begin
        for(j=0; j < DIGITS; j=j+1) begin
            if(BCD_temp[j*4+:4]>=4'd5)
            BCD_temp[j*4+:4]=BCD_temp[j*4+:4] +4'd3;
        end

        BCD_temp = {BCD_temp[DIGITS*4-2:0], binary_in[i]};
    end
    BCD_out = BCD_temp;
end
endmodule
