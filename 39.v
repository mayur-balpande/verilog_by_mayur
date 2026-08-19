 // Write a Verilog module to generate the sequence "10011001" repeatedly.

module q39 (
    input   clk,
    input   reset,
    input   enable,

    output logic seq_out
);

    logic [2:0] bit_cnt_q;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_cnt_q <= 3'd0;
            seq_out   <= 1'b1;
        end else if (enable) begin
            case (bit_cnt_q)
                3'd0: seq_out <= 1'b1;
                3'd1: seq_out <= 1'b0;
                3'd2: seq_out <= 1'b0;
                3'd3: seq_out <= 1'b1;
                3'd4: seq_out <= 1'b1;
                3'd5: seq_out <= 1'b0;
                3'd6: seq_out <= 1'b0;
                3'd7: seq_out <= 1'b1;
                default: seq_out <= 1'b1;
            endcase

            bit_cnt_q <= bit_cnt_q + 3'd1;
        end
    end

endmodule