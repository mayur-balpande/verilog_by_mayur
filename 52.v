 //Create a 4-bit binary counter with synchronous reset. 

module q52(
    input clk,
    input reset,
    input enable,
    output reg [3:0] count
);

always @(posedge clk or posedge reser) begin
    if (reset) begin
        count <= 4'b0000;
    end
    else if (enable) begin
        count <= count + 1;
    end
end
endmodule
