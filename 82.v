//Create a watchdog timer.

module q82 #(parameter TIMEOUT_CYCLES = 1_000_000,
              parameter COUNT_WIDTH = (TIMEOUT_CYCLES <= 1) ? 1:$clog2(TIMEOUT_CYCLES))
              (
                input clk,
                input reset,
                input kick,
                output reg timeout
              );

              reg [COUNT_WIDTH-1:0] count;

              always @(posedge clk or posedge reset) begin
                if (reset) begin
                    count <= 0;
                    timeout <= 0;
                end else if (kick) begin
                    count <= 0;
                    timeout <= 0;
                end else if (count == TIMEOUT_CYCLES - 1) begin
                    timeout <= 1;
                end else begin
                    count <= count + 1;
                end
              end
endmodule