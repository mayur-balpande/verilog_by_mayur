//Create an FSM-based traffic arbiter for buses.

module q148(
    input clk,
    input reset,
    input [1:0] request,
    input transfer_done,
    output reg [1:0] grant
);

    localparam [1:0] IDLE  = 2'd0,
                     OWN_0 = 2'd1,
                     OWN_1 = 2'd2;

    reg [1:0] state;
    reg [1:0] next_state;
    reg prefer_master1;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            prefer_master1 <= 1'b0;
        end else begin
            state <= next_state;

            if ((state == OWN_0) && transfer_done)
                prefer_master1 <= 1'b1;
            else if ((state == OWN_1) && transfer_done)
                prefer_master1 <= 1'b0;
        end
    end

    always @(*) begin
        next_state = state;
        grant = 2'b00;

        case (state)
            IDLE: begin
                if (request == 2'b11) begin
                    if (prefer_master1)
                        next_state = OWN_1;
                    else
                        next_state = OWN_0;
                end else if (request[0]) begin
                    next_state = OWN_0;
                end else if (request[1]) begin
                    next_state = OWN_1;
                end
            end

            OWN_0: begin
                grant = 2'b01;
                if (transfer_done)
                    next_state = IDLE;
            end

            OWN_1: begin
                grant = 2'b10;
                if (transfer_done)
                    next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
