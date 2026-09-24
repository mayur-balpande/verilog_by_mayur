 //Design a pulse width detector.

 module q80 #(
    parameter WIDTH_BITS = 16
)(
    input  wire                  clk,
    input  wire                  rst_n,
    input  wire                  pulse_in,
    output reg  [WIDTH_BITS-1:0] width_out,
    output reg                   valid_out
);

    
    reg pulse_sync1;
    reg pulse_sync2;
    reg pulse_dly;

    
    reg [WIDTH_BITS-1:0] counter;

    
    wire pulse_posedge = (pulse_sync2 && !pulse_dly);
    wire pulse_negedge = (!pulse_sync2 && pulse_dly);

    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pulse_sync1 <= 1'b0;
            pulse_sync2 <= 1'b0;
            pulse_dly   <= 1'b0;
        end else begin
            pulse_sync1 <= pulse_in;
            pulse_sync2 <= pulse_sync1;
            pulse_dly   <= pulse_sync2;
        end
    end

    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter   <= {WIDTH_BITS{1'b0}};
            width_out <= {WIDTH_BITS{1'b0}};
            valid_out <= 1'b0;
        end else begin
            valid_out <= 1'b0; 

            if (pulse_posedge) begin
             
                counter <= {{ (WIDTH_BITS-1){1'b0} }, 1'b1};
            end else if (pulse_negedge) begin
               
                width_out <= counter;
                valid_out <= 1'b1;
                counter   <= {WIDTH_BITS{1'b0}};
            end else if (pulse_sync2) begin
               
                if (counter != {WIDTH_BITS{1'b1}}) begin
                    counter <= counter + 1'b1;
                end
            end
        end
    end

endmodule
