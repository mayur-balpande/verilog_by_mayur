//Create priority-based arbiter

module q97#(parameter ports = 4 )(
    input clk,
    input reset,
    input [ports-1:0] request,
    output reg [ports-1:0] grant,
    output reg grant_valid

);

integer i;
reg found;

always @(*) begin
    if (reset) begin
        grant = {ports{1'b0}};
        grant_valid = 1'b0;
        found = 1'b0;

        for (i = ports - 1; i >= 0; i = i-1) begin
            if (request[i] && !found) begin
                grant[i] = 1'b1;
                grant_valid = 1'b1;
                found = 1'b1;
            end 
        end
    end
end
endmodule
