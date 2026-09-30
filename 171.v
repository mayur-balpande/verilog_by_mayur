//Code a leading zero counter.


module q171 #(
    parameter integer N = 32,
    parameter integer COUNT_WIDTH = (N <= 1) ? 1 : $clog2(N + 1)
) (
    input [N-1:0] data_in,
    output reg [COUNT_WIDTH-1:0] count,
    output reg all_zero
);

    integer i;
    reg found;

    always @(*) begin
        count    = N;
        all_zero = 1'b1;
        found    = 1'b0;

        for (i = N - 1; i >= 0; i = i - 1) begin
            if (data_in[i] && !found) begin
                count    = N - 1 - i;
                all_zero = 1'b0;
                found    = 1'b1;
            end
        end
    end

endmodule
