//Implement a priority decoder using a loop.

module q165 #(parameter N = 8)(
    input [N-1:0] req,
    output reg [N-1:0] grant,
    output reg valid
);

integer i;
reg found;

always @(*) begin
    grant = {N{1'b0}};
    valid = 1'b0;
    found = 1'b0;


    for (i  = N-1; i >= 0; i = i-1) begin
        if(req[i] && !found) begin
            grant[i] = 1'b1;
            valid = 1'b1;
            found = 1'b1;
        end
    end
    
end
endmodule

