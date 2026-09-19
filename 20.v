

module q20 #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
) (
    input  wire                  wr_clk,
    input  wire                  wr_reset,
    input  wire                  wr_en,
    input  wire [DATA_WIDTH-1:0] data_in,
    output reg                   full,

    input  wire                  rd_clk,
    input  wire                  rd_reset,
    input  wire                  rd_en,
    output reg  [DATA_WIDTH-1:0] data_out,
    output reg                   empty
);

    localparam DEPTH = (1 << ADDR_WIDTH);

    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // Binary and Gray-code pointers include one extra wrap bit.
    reg [ADDR_WIDTH:0] wr_bin;
    reg [ADDR_WIDTH:0] wr_gray;
    reg [ADDR_WIDTH:0] rd_bin;
    reg [ADDR_WIDTH:0] rd_gray;

    // Gray-coded pointers synchronized into the opposite clock domain.
    reg [ADDR_WIDTH:0] rd_gray_sync1;
    reg [ADDR_WIDTH:0] rd_gray_sync2;
    reg [ADDR_WIDTH:0] wr_gray_sync1;
    reg [ADDR_WIDTH:0] wr_gray_sync2;

    wire                  write_valid;
    wire                  read_valid;
    wire [ADDR_WIDTH:0]   wr_bin_next;
    wire [ADDR_WIDTH:0]   wr_gray_next;
    wire [ADDR_WIDTH:0]   rd_bin_next;
    wire [ADDR_WIDTH:0]   rd_gray_next;
    wire                  full_next;
    wire                  empty_next;

    assign write_valid = wr_en && !full;
    assign read_valid  = rd_en && !empty;

    // Write pointer next-state logic
    assign wr_bin_next  = wr_bin +
                          {{ADDR_WIDTH{1'b0}}, write_valid};
    assign wr_gray_next = (wr_bin_next >> 1) ^ wr_bin_next;

    // FIFO is full when the next write pointer catches the read pointer.
    assign full_next = (wr_gray_next ==
                       {~rd_gray_sync2[ADDR_WIDTH:ADDR_WIDTH-1],
                         rd_gray_sync2[ADDR_WIDTH-2:0]});

    // Read pointer next-state logic
    assign rd_bin_next  = rd_bin +
                          {{ADDR_WIDTH{1'b0}}, read_valid};
    assign rd_gray_next = (rd_bin_next >> 1) ^ rd_bin_next;

    // FIFO is empty when both pointers are equal.
    assign empty_next = (rd_gray_next == wr_gray_sync2);

    // Synchronize read pointer into write-clock domain.
    always @(posedge wr_clk or posedge wr_reset) begin
        if (wr_reset) begin
            rd_gray_sync1 <= {(ADDR_WIDTH+1){1'b0}};
            rd_gray_sync2 <= {(ADDR_WIDTH+1){1'b0}};
        end
        else begin
            rd_gray_sync1 <= rd_gray;
            rd_gray_sync2 <= rd_gray_sync1;
        end
    end

    // Synchronize write pointer into read-clock domain.
    always @(posedge rd_clk or posedge rd_reset) begin
        if (rd_reset) begin
            wr_gray_sync1 <= {(ADDR_WIDTH+1){1'b0}};
            wr_gray_sync2 <= {(ADDR_WIDTH+1){1'b0}};
        end
        else begin
            wr_gray_sync1 <= wr_gray;
            wr_gray_sync2 <= wr_gray_sync1;
        end
    end

    // Write-clock domain logic
    always @(posedge wr_clk or posedge wr_reset) begin
        if (wr_reset) begin
            wr_bin  <= {(ADDR_WIDTH+1){1'b0}};
            wr_gray <= {(ADDR_WIDTH+1){1'b0}};
            full    <= 1'b0;
        end
        else begin
            if (write_valid)
                mem[wr_bin[ADDR_WIDTH-1:0]] <= data_in;

            wr_bin  <= wr_bin_next;
            wr_gray <= wr_gray_next;
            full    <= full_next;
        end
    end

    // Read-clock domain logic
    always @(posedge rd_clk or posedge rd_reset) begin
        if (rd_reset) begin
            rd_bin   <= {(ADDR_WIDTH+1){1'b0}};
            rd_gray  <= {(ADDR_WIDTH+1){1'b0}};
            data_out <= {DATA_WIDTH{1'b0}};
            empty    <= 1'b1;
        end
        else begin
            if (read_valid)
                data_out <= mem[rd_bin[ADDR_WIDTH-1:0]];

            rd_bin  <= rd_bin_next;
            rd_gray <= rd_gray_next;
            empty   <= empty_next;
        end
    end

endmodule