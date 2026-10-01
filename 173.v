//Create a priority encoder with mask input
module q173 #(
    parameter integer WIDTH = 8,
    parameter integer INDEX_WIDTH =
        (WIDTH <= 1) ? 1 : $clog2(WIDTH)
) (
    input  wire [WIDTH-1:0]       request,
    input  wire [WIDTH-1:0]       mask,
    output reg                    valid,
    output reg  [INDEX_WIDTH-1:0] index
);

    wire [WIDTH-1:0] eligible = request & ~mask;
    integer i;
    reg found;

    always @(*) begin
        valid = 1'b0;
        index = {INDEX_WIDTH{1'b0}};
        found = 1'b0;

        for (i = WIDTH - 1; i >= 0; i = i - 1) begin
            if (eligible[i] && !found) begin
                index = i;
                valid = 1'b1;
                found = 1'b1;
            end
        end
    end

endmodule
