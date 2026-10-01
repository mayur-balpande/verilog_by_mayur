//Implement a reconfigurable counter.


module q123 #(
    parameter integer N = 8
) (
    input  clk,
    input  reset,
    input  enable,
    input  load,
    input  count_up,
    input  [N-1:0] load_value,
    input  [N-1:0] terminal_count,
    output reg  [N-1:0] count,
    output reg terminal_pulse
);

    always @(posedge clk) begin
        if (reset) begin
            count          <= {N{1'b0}};
            terminal_pulse <= 1'b0;
        end else begin
            terminal_pulse <= 1'b0;

            if (load) begin
                count <= load_value;
            end else if (enable) begin
                if (count_up) begin
                    if (count >= terminal_count) begin
                        count          <= {N{1'b0}};
                        terminal_pulse <= 1'b1;
                    end else begin
                        count <= count + 1'b1;
                    end
                end else begin
                    if (count == {N{1'b0}}) begin
                        count          <= terminal_count;
                        terminal_pulse <= 1'b1;
                    end else begin
                        count <= count - 1'b1;
                    end
                end
            end
        end
    end

endmodule
