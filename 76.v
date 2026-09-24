// Design an asynchronous FIFO


// W--> Write
// R--> Read

    module q76 #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
)(
    input  wire                  wclk,
    input  wire                  wrst_n,
    input  wire                  winc,
    input  wire [DATA_WIDTH-1:0] wdata,
    output reg                   wfull,

    input  wire                  rclk,
    input  wire                  rrst_n,
    input  wire                  rinc,
    output wire [DATA_WIDTH-1:0] rdata,
    output reg                   rempty
);

    localparam DEPTH = 1 << ADDR_WIDTH;

    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    reg [ADDR_WIDTH:0] wbin, wptr_gray;
    reg [ADDR_WIDTH:0] rbin, rptr_gray;

    reg [ADDR_WIDTH:0] rptr_sync_w1, rptr_sync_w2;
    reg [ADDR_WIDTH:0] wptr_sync_r1, wptr_sync_r2;

    wire [ADDR_WIDTH:0] wbin_next  = wbin + (winc & ~wfull);
    wire [ADDR_WIDTH:0] wgray_next = (wbin_next >> 1) ^ wbin_next;
    wire                wfull_val  = (wgray_next == {~rptr_sync_w2[ADDR_WIDTH:ADDR_WIDTH-1], 
                                                     rptr_sync_w2[ADDR_WIDTH-2:0]});

    wire [ADDR_WIDTH:0] rbin_next  = rbin + (rinc & ~rempty);
    wire [ADDR_WIDTH:0] rgray_next = (rbin_next >> 1) ^ rbin_next;
    wire                rempty_val = (rgray_next == wptr_sync_r2);

    always @(posedge wclk) begin
        if (winc & ~wfull) begin
            mem[wbin[ADDR_WIDTH-1:0]] <= wdata;
        end
    end

    assign rdata = mem[rbin[ADDR_WIDTH-1:0]];

    always @(posedge wclk or negedge wrst_n) begin
        if (!wrst_n) begin
            wbin           <= {(ADDR_WIDTH+1){1'b0}};
            wptr_gray      <= {(ADDR_WIDTH+1){1'b0}};
            wfull          <= 1'b0;
            rptr_sync_w1   <= {(ADDR_WIDTH+1){1'b0}};
            rptr_sync_w2   <= {(ADDR_WIDTH+1){1'b0}};
        end else begin
            wbin           <= wbin_next;
            wptr_gray      <= wgray_next;
            wfull          <= wfull_val;
            rptr_sync_w1   <= rptr_gray;
            rptr_sync_w2   <= rptr_sync_w1;
        end
    end

    always @(posedge rclk or negedge rrst_n) begin
        if (!rrst_n) begin
            rbin           <= {(ADDR_WIDTH+1){1'b0}};
            rptr_gray      <= {(ADDR_WIDTH+1){1'b0}};
            rempty         <= 1'b1;
            wptr_sync_r1   <= {(ADDR_WIDTH+1){1'b0}};
            wptr_sync_r2   <= {(ADDR_WIDTH+1){1'b0}};
        end else begin
            rbin           <= rbin_next;
            rptr_gray      <= rgray_next;
            rempty         <= rempty_val;
            wptr_sync_r1   <= wptr_gray;
            wptr_sync_r2   <= wptr_sync_r1;
        end
    end

endmodule
