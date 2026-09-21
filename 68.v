//Write a synchronous FIFO.

module q68 #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
) (
    input  wire                  clk,
    input  wire                  reset,
    input  wire                  wr_en,
    input  wire                  rd_en,
    input  wire [DATA_WIDTH-1:0] data_in,
    output reg  [DATA_WIDTH-1:0] data_out,
    output wire                  full,
    output wire                  empty
);

    localparam [ADDR_WIDTH:0] FIFO_DEPTH = (1 << ADDR_WIDTH);

    reg [DATA_WIDTH-1:0] mem [0:FIFO_DEPTH-1];
    reg [ADDR_WIDTH-1:0] wr_ptr;
    reg [ADDR_WIDTH-1:0] rd_ptr;
    reg [ADDR_WIDTH:0]   count;

    wire write_valid;
    wire read_valid;

    assign empty = (count == 0);
    assign full  = (count == FIFO_DEPTH);

    assign write_valid = wr_en && !full;
    assign read_valid  = rd_en && !empty;

    always @(posedge clk) begin
        if (reset) begin
            wr_ptr   <= {ADDR_WIDTH{1'b0}};
            rd_ptr   <= {ADDR_WIDTH{1'b0}};
            count    <= {(ADDR_WIDTH+1){1'b0}};
            data_out <= {DATA_WIDTH{1'b0}};
        end
        else begin
            if (write_valid) begin
                mem[wr_ptr] <= data_in;
                wr_ptr      <= wr_ptr + 1'b1;
            end

            if (read_valid) begin
                data_out <= mem[rd_ptr];
                rd_ptr   <= rd_ptr + 1'b1;
            end

            if (write_valid && !read_valid)
                count <= count + 1'b1;
            else if (!write_valid && read_valid)
                count <= count - 1'b1;
        end
    end

endmodule
