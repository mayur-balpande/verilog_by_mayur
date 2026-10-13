//Create an FSM to handle serial data framing.

module q116 #(
    parameter integer DATA_WIDTH = 8
) (
    input  wire                  clk,
    input  wire                  reset,       // Synchronous, active-high
    input  wire                  bit_tick,
    input  wire                  serial_in,

    output reg  [DATA_WIDTH-1:0] data_out,
    output reg                   data_valid,  // One-cycle pulse for a valid frame
    output reg                   framing_error // One-cycle pulse for invalid stop bit
);

    localparam integer COUNT_WIDTH =
        (DATA_WIDTH <= 1) ? 1 : $clog2(DATA_WIDTH);

    localparam [1:0] IDLE = 2'd0,
                     DATA = 2'd1,
                     STOP = 2'd2;

    reg [1:0] state;
    reg [COUNT_WIDTH-1:0] bit_count;
    reg [DATA_WIDTH-1:0] shift_reg;

    always @(posedge clk) begin
        if (reset) begin
            state         <= IDLE;
            bit_count     <= {COUNT_WIDTH{1'b0}};
            shift_reg     <= {DATA_WIDTH{1'b0}};
            data_out      <= {DATA_WIDTH{1'b0}};
            data_valid    <= 1'b0;
            framing_error <= 1'b0;
        end else begin
            data_valid    <= 1'b0;
            framing_error <= 1'b0;

            if (bit_tick) begin
                case (state)
                    IDLE: begin
                        if (!serial_in) begin
                            bit_count <= {COUNT_WIDTH{1'b0}};
                            state     <= DATA;
                        end
                    end

                    DATA: begin
                        shift_reg <= {serial_in, shift_reg[DATA_WIDTH-1:1]};

                        if (bit_count == DATA_WIDTH - 1) begin
                            state <= STOP;
                        end else begin
                            bit_count <= bit_count + 1'b1;
                        end
                    end

                    STOP: begin
                        if (serial_in) begin
                            data_out   <= shift_reg;
                            data_valid <= 1'b1;
                        end else begin
                            framing_error <= 1'b1;
                        end

                        state <= IDLE;
                    end

                    default: begin
                        state <= IDLE;
                    end
                endcase
            end
        end
    end

endmodule
