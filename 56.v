// shift register with serial input and parallel output

module q56# (parameter WIDTH = 4 )(
    input clk,
    input reset,
    input serial_in,
    output reg [WIDTH-1:0] parallel_out

);
 
 always @(posedge clk or posedge reset) begin
    if (reset) begin
            parallel_out <= {WIDTH {1'b0}};

    end
    else parallel_out <= {serial_in, parallel_out[WIDTH-1:1]};
end
endmodule