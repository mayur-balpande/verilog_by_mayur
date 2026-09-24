//Create a digital clock in Verilog.

module q83 #(
    parameter CLK_FREQ_HZ = 50_000_000 // Input clock frequency (e.g., 50 MHz for FPGA)
)(
    input  wire       clk,
    input  wire       rst_n,
    output reg  [5:0] sec,   // 0 to 59
    output reg  [5:0] min,   // 0 to 59
    output reg  [4:0] hour   // 0 to 23 (24-hour format)
);

    // 1-second tick generator counter
    reg [31:0] clk_count;
    wire       one_sec_tick = (clk_count == (CLK_FREQ_HZ - 1));

    // 1-second pulse generation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            clk_count <= 32'd0;
        end else if (one_sec_tick) begin
            clk_count <= 32'd0;
        end else begin
            clk_count <= clk_count + 1'b1;
        end
    end

    // Clock registers: seconds, minutes, hours
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sec  <= 6'd0;
            min  <= 6'd0;
            hour <= 5'd0;
        end else if (one_sec_tick) begin
            // Second logic
            if (sec == 6'd59) begin
                sec <= 6'd0;
                
                // Minute logic
                if (min == 6'd59) begin
                    min <= 6'd0;
                    
                    // Hour logic
                    if (hour == 5'd23) begin
                        hour <= 5'd0;
                    end else begin
                        hour <= hour + 1'b1;
                    end
                end else begin
                    min <= min + 1'b1;
                end
            end else begin
                sec <= sec + 1'b1;
            end
        end
    end

endmodule
