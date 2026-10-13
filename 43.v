//Implement a Verilog sequence detector that recognizes "1101" in a serial data stream

module q43 (
    input  wire clk,
    input  wire reset,
    input  wire serial_in,
    output wire detected
);

    localparam [2:0] S_IDLE = 3'd0,
                     S_1    = 3'd1,
                     S_11   = 3'd2,
                     S_110  = 3'd3,
                     S_1101 = 3'd4;

    reg [2:0] state;
    reg [2:0] next_state;

    assign detected = (state == S_1101);

    always @(posedge clk) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;

        case (state)
            S_IDLE: next_state = serial_in ? S_1 : S_IDLE;
            S_1:    next_state = serial_in ? S_11 : S_IDLE;
            S_11:   next_state = serial_in ? S_11 : S_110;
            S_110:  next_state = serial_in ? S_1101 : S_IDLE;
            S_1101: next_state = serial_in ? S_11 : S_IDLE;
            default: next_state = S_IDLE;
        endcase
    end

endmodule