//Write a Gray code counter.


module q88 #(
    parameter WIDTH = 4
)(
    input  wire             clk,
    input  wire             rst,
    output reg  [WIDTH-1:0] gray
);

    reg [WIDTH-1:0] binary;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            binary <= 1'b0;
            gray   <= 1'b0;
        end
        else begin
            binary <= binary + 1'b1;
            gray   <= (binary + 1'b1) ^ ((binary + 1'b1) >> 1);
        end
    end

endmodule
