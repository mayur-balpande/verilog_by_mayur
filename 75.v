//Write a dual port RAM


module q75(
    input clk,
    input we_a,
    input we_b,
    input [7:0] data_a,
    input [7:0] data_b,
    input [5:0] addr_a,
    input [5:0] addr_b,
    output reg [7:0] q_a,
    output reg [7:0] q_b
);

always @(posedge clk) begin
    if (we_a) begin
        q_a <= data_a;
    end
    else begin 
        q_a <= q_a;
    end
end

always @(posedge clk) begin
    if (we_b) begin
        q_b <= data_b;
    end
    else begin
        q_b <= q_b;
    end
end
endmodule
