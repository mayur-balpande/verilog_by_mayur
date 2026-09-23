//Write an FSM to detect three consecutive 1's in a stream.

module q71(
    input wire clk,
    input wire rst,
    input wire in,
    output reg detected
);

    reg [1:0] state;

    localparam S0 = 2'd0;
    localparam S1 = 2'd1;
    localparam S2 = 2'd2;
    localparam S3 = 2'd3;

    always @(posedge clk) begin
        if (rst) begin
            state <= S0;
            detected <= 1'b0;
        end else begin
            case (state)
                S0: state <= in ? S1 : S0;
                S1: state <= in ? S2 : S0;
                S2: state <= in ? S3 : S0;
                S3: state <= in ? S3 : S0;
            endcase

            detected <= (state == S2 && in == 1'b1) || (state == S3 && in == 1'b1);
        end
    end

endmodule

