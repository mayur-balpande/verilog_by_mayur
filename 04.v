//Implement a D Flip-Flop with synchronous reset. 

module q4(

    input wire clk,
    input wire rst,
    output reg q,
    output reg d
);
always @(posedge clk) begin
    if (rst)
        q <= 0;
        else
        q <=d;
end
endmodule
