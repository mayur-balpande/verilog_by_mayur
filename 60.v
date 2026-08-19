// Implement a Moore FSM for even-odd detector. 

module q60(
    input  wire clk,
    input  wire reset,
    input  wire data_in,
    output wire even,
    output wire odd
);

    localparam STATE_EVEN = 1'b0;
    localparam STATE_ODD  = 1'b1;

    reg current_state;
    reg next_state;

    // State register
    always @(posedge clk) begin
        if (reset)
            current_state <= STATE_EVEN;
        else
            current_state <= next_state;
    end

    // Next-state logic
    always @(*) begin
        next_state = current_state;

        case (current_state)
            STATE_EVEN: begin
                if (data_in)
                    next_state = STATE_ODD;
            end

            STATE_ODD: begin
                if (data_in)
                    next_state = STATE_EVEN;
            end

            default: begin
                next_state = STATE_EVEN;
            end
        endcase
    end

    // Moore outputs: depend only on the current state
    assign even = (current_state == STATE_EVEN);
    assign odd  = (current_state == STATE_ODD);

endmodule