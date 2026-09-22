// Write a Mealy machine for sequence detector (e.g., 101). 
module mealy_sequence_detector_101 (
    input  wire clk,
    input  wire reset,
    input  wire serial_in,
    output reg  detected
);

    parameter IDLE = 2'b00;
    parameter S1   = 2'b01;  // detected 1
    parameter S10  = 2'b10;  // detected 10

    reg [1:0] current_state;
    reg [1:0] next_state;

    always @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    always @(*) begin
        next_state = current_state;
        detected   = 1'b0;

        case (current_state)
            IDLE: begin
                if (serial_in)
                    next_state = S1;
                else
                    next_state = IDLE;
            end

            S1: begin
                if (serial_in)
                    next_state = S1;
                else
                    next_state = S10;
            end

            S10: begin
                if (serial_in) begin
                    next_state = S1;
                    detected   = 1'b1;
                end
                else begin
                    next_state = IDLE;
                end
            end

            default: begin
                next_state = IDLE;
                detected   = 1'b0;
            end
        endcase
    end

endmodule
