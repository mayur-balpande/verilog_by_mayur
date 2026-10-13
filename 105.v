//Create a binary search FSM.

module q105 #(
    parameter integer DATA_WIDTH  = 16,
    parameter integer INDEX_WIDTH = 8
) (
    input  wire                     clk,
    input  wire                     reset,
    input  wire                     start,
    input  wire [DATA_WIDTH-1:0]    search_key,
    input  wire [INDEX_WIDTH:0]     num_items,

    output wire                     mem_req,
    input  wire                     mem_ready,
    output wire [INDEX_WIDTH-1:0]   mem_addr,
    input  wire                     mem_data_valid,
    input  wire [DATA_WIDTH-1:0]    mem_data,

    output wire                     busy,
    output reg                      done,
    output reg                      found,
    output reg  [INDEX_WIDTH-1:0]   found_index
);

    localparam [1:0] IDLE     = 2'd0,
                     READ_REQ = 2'd1,
                     WAIT_DATA = 2'd2;

    reg [1:0] state;
    reg [INDEX_WIDTH-1:0] low;
    reg [INDEX_WIDTH-1:0] high;
    reg [DATA_WIDTH-1:0] key_reg;

    wire [INDEX_WIDTH-1:0] mid;
    assign mid      = low + ((high - low) >> 1);
    assign mem_addr = mid;
    assign mem_req  = (state == READ_REQ);
    assign busy     = (state != IDLE);

    always @(posedge clk) begin
        if (reset) begin
            state      <= IDLE;
            low        <= {INDEX_WIDTH{1'b0}};
            high       <= {INDEX_WIDTH{1'b0}};
            key_reg    <= {DATA_WIDTH{1'b0}};
            found      <= 1'b0;
            found_index <= {INDEX_WIDTH{1'b0}};
            done       <= 1'b0;
        end else begin
            done <= 1'b0;

            case (state)
                IDLE: begin
                    if (start) begin
                        key_reg     <= search_key;
                        low         <= {INDEX_WIDTH{1'b0}};
                        found       <= 1'b0;
                        found_index <= {INDEX_WIDTH{1'b0}};

                        if (num_items == 0) begin
                            done  <= 1'b1;
                            state <= IDLE;
                        end else begin
                            high  <= num_items - 1'b1;
                            state <= READ_REQ;
                        end
                    end
                end

                READ_REQ: begin
                    if (mem_ready)
                        state <= WAIT_DATA;
                end

                WAIT_DATA: begin
                    if (mem_data_valid) begin
                        if (mem_data == key_reg) begin
                            found       <= 1'b1;
                            found_index <= mid;
                            done        <= 1'b1;
                            state       <= IDLE;
                        end else if (mem_data < key_reg) begin
                            if (mid == high) begin
                                done  <= 1'b1;
                                state <= IDLE;
                            end else begin
                                low   <= mid + 1'b1;
                                state <= READ_REQ;
                            end
                        end else begin
                            if (mid == low) begin
                                done  <= 1'b1;
                                state <= IDLE;
                            end else begin
                                high  <= mid - 1'b1;
                                state <= READ_REQ;
                            end
                        end
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule