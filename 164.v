//Design a dynamic priority encoder using a loop.

module q164#(parameter N = 8,
            parameter INDEX_WIDTH = (N <= 1) ? 1 : $clog2(N))(
    input [N-1:0] request,
    input [INDEX_WIDTH-1:0] priority_start,
    output reg valid,
    output reg [INDEX_WIDTH-1:0] index
);

integer i;
integer candidate;
reg found;

always @(*) begin
    valid = 1'b0;
    index = {INDEX_WIDTH{1'b0}};
    found = 1'b0;
    candidate = 0;

    if (priority_start < N) begin
        for (i = 0; i < N; i=i + 1) begin
            candidate = priority_start + i;

            if(candidate >= N)
            candidate = candidate - N;

            if (request[candidate] && !found) begin
                index = candidate;
                valid = 1'b1;
                found = 1'b1;
            end
        end
    end
    
end

endmodule
