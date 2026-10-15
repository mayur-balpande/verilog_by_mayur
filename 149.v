//FSM to handle input handshake protocol with ACK/NACK

module q149 #(
    parameter integer DATA_WIDTH = 8
)(
    input clk,
    input reset,
    input request,
    input [DATA_WIDTH-1:0] data_in,
    input decision_valid,
    input accept,

    output reg ack,
    output reg nack,
    output reg [DATA_WIDTH-1:0] data_out,
    output reg busy
);

localparam [2:0] IDLE  = 3'd0,
                WAIT_DECISION = 3'd1,
                ACK_STATE = 3'd2,
                NACK_STATE = 3'd3,
                WAIT_RELEASE = 3'd4;

    reg [2:0] state,
            next_state;
    reg [DATA_WIDTH-1:0] captured_data;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            captured_data <= {DATA_WIDTH{1'b0}};
            data_out <= {DATA_WIDTH{1'b0}};
        end else begin
            state <= next_state;
            if ((state == IDLE) && request)
                captured_data <= data_in;
            if ((state == WAIT_DECISION) && decision_valid && accept)
                data_out <= captured_data;
            end
        end

        always @(*) begin
            next_state = state;
            ack = 1'b0;
            nack = 1'b0;
            busy = 1'b0;

            case (state)
                IDLE: begin
                    if (request) begin
                        next_state = WAIT_DECISION;
                        busy = 1'b1;
                    end
                end

                WAIT_DECISION: begin
                    busy = 1'b1;
                    if (decision_valid) begin
                        if (accept) begin
                            next_state = ACK_STATE;
                        end else begin
                            next_state = NACK_STATE;
                        end
                    end
                end

                ACK_STATE: begin
                    ack = 1'b1;
                    next_state = WAIT_RELEASE;
                end

                NACK_STATE: begin
                    nack = 1'b1;
                    next_state = WAIT_RELEASE;
                end

                WAIT_RELEASE: begin
                    if (!request) begin
                        next_state = IDLE;
                    end
                end

                default: begin
                    next_state = IDLE;
                end

            endcase
        end
endmodule
