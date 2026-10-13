 //Implement an AND gate using assign and always block

module q51(
    input clk,
    input reset,
    input a,
    input b,
    output reg y
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        y <= 1'b0;
    end
    else begin
        y <= a & b;
    end
end
endmodule

