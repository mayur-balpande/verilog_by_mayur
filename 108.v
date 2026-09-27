//Write a code to implement debounce logic


module q108#(parameter WIDTH = 8)(
    input clk,
    input reset,
    input button_in,
    output reg button_out
);


(* ASYNC_REG = "TRUE"*) /* acts like don't touch in synthesis*/ reg sync_ff1;
(* ASYNC_REG = "TRUE"*) reg sync_ff2;
reg [WIDTH-1:0] samples;

reg [WIDTH-1:0] next_samples = (samples << 1)| sync_ff2;
always @(posedge clk) begin
    if (reset) begin
        sync_ff1 <= 1'b0;
        sync_ff2 <= 1'b0;
        samples <= {WIDTH{1'b0}};
        button_out <= 1'b0;
    end
    else begin
        sync_ff1 <= button_in;
        sync_ff2 <= sync_ff1;
        samples <= next_samples;
    
    if (&next_samples)
        button_out <= 1'b1;
        else if (~|next_samples) begin
            button_out <= 1'b0;           
        end
    end
end
endmodule
