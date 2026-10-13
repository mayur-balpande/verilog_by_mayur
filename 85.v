//Write a code for handshake protocol.


//simple synchronous request/acknowledge handshake

module q85 (
    input clk,
    input reset_n,
    input request,
    output reg ack
);

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
        ack <= 1'b0;
        else if (request)
        ack <= 1'b1;
        else 
        ack <= 1'b0;
    end
endmodule


//detailed handshake protocol with ready/valid signals

module ready_valid_handshake #(
    parameter integer DATA_WIDTH = 8
) (
    input  wire                  clk,
    input  wire                  reset,
    input  wire                  in_valid,
    output wire                  in_ready,
    input  wire [DATA_WIDTH-1:0] data_in,
    output reg                   out_valid,
    input  wire                  out_ready,
    output reg  [DATA_WIDTH-1:0] data_out
);

    assign in_ready = ~out_valid | out_ready;

    always @(posedge clk) begin
        if (reset) begin
            out_valid <= 1'b0;
            data_out  <= {DATA_WIDTH{1'b0}};
        end else if (in_ready) begin
            out_valid <= in_valid;

            if (in_valid)
                data_out <= data_in;
        end
    end

endmodule