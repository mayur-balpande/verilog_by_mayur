//Implement a Verilog module that generates an alternating sequence of 1s and 0s. 

module q40(
    input   clk,
    input   reset,
    input   enable,

    output reg seq_out
);

    poalways_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            seq_out <= 1'b0;
        end else if (enable) begin
            seq_out <= ~seq_out;
        end
    end

endmodule