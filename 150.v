//FSM to parse a serial data stream with headers and footers


module q150 #(
    parameter [7:0] HEADER = 8'hA5,
    parameter [7:0] FOOTER = 8'h5A
) (
    input clk,
    input reset,
    input [7:0] byte_in,
    input byte_valid,

    output reg [7:0] payload_data,
    output reg payload_valid,
    output reg frame_start,
    output reg frame_done
);

    localparam [1:0] SEARCH_HEADER = 2'd0,
                     IN_FRAME      = 2'd1;

    reg [1:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state         <= SEARCH_HEADER;
            payload_data  <= 8'd0;
            payload_valid <= 1'b0;
            frame_start   <= 1'b0;
            frame_done    <= 1'b0;
        end else begin
            payload_valid <= 1'b0;
            frame_start   <= 1'b0;
            frame_done    <= 1'b0;

            if (byte_valid) begin
                case (state)
                    SEARCH_HEADER: begin
                        if (byte_in == HEADER) begin
                            state       <= IN_FRAME;
                            frame_start <= 1'b1;
                        end
                    end

                    IN_FRAME: begin
                        if (byte_in == FOOTER) begin
                            state      <= SEARCH_HEADER;
                            frame_done <= 1'b1;
                        end else begin
                            payload_data  <= byte_in;
                            payload_valid <= 1'b1;
                        end
                    end

                    default: begin
                        state <= SEARCH_HEADER;
                    end
                endcase
            end
        end
    end

endmodule
