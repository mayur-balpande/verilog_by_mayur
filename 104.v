//Design an FSM for password checker


module q104 #(parameter WIDTH = 4,
            parameter [WIDTH-1:0] PASSWORD = 4'b1010)(
                input clk,
                input reset,
                input submit,
                input [WIDTH-1:0] password_in,
                output reg access_granted,
                output reg busy,
                output reg done
            );

            localparam IDLE = 2'd0;
            localparam CHECK = 2'd1;
            localparam GRANTED = 2'd2;
            localparam DENIED = 2'd3;

            reg [1:0] state;
            reg [1:0] next_state;
            reg [WIDTH-1:0] password_reg;

            always @(posedge clk) begin
                if (reset) begin
                    state <= IDLE;
                    password_reg <= {WIDTH{1'b0}};
                end
                else begin
                    state <= next_state;
                    if ((state == IDLE) && submit)
                    password_reg <= password_in;
                end
            end

            always @(*) begin
                next_state = state;
                access_granted = 1'b0;
                busy = 1'b0;
                done = 1'b0;

                case(state)
                IDLE: begin
                    if (submit)
                    next_state = CHECK;
                end

                CHECK: begin
                    busy = 1'b1;
                    if (password_reg == PASSWORD)
                    next_state = GRANTED;

                end

                GRANTED: begin
                    access_granted = 1'b1;
                    done = 1'b1;
                    next_state = IDLE;
                end

                DENIED: begin
                    done = 1'b1;
                    next_state = IDLE;
                end

                default: begin
                    next_state = IDLE;
            
                end
                endcase
            end
endmodule
