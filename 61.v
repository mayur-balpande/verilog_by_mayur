//Write Verilog code for an 8-bit barrel shifter. 

module q61(
    input [7:0]data_in,
    input [2:0] shift_amt,
    input direction,
    output reg [7:0] data_out
);

always @(*) begin
    if (direction) 
        data_out = data_in << shift_amt;
        else
        data_out = data_in >> shift_amt; 
end
endmodule
