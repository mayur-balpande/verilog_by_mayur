//Write code for pulse synchronizer between clock domains

module q98(
    input clk_1,
    input reset_1,
    input pulse_in,
    input clk_2,
    input reset_2,
    output reg pulse_out
);

reg src_toggle;
reg dst_toggle_d;


always @(posedge clk_1 or negedge reset_1) begin
    if (!reset_1) begin
        src_toggle <= 1'b0;
    end
    else if (pulse_in) begin
        src_toggle <= ~src_toggle;
    end
end

reg dst_sync_ff1;
reg dst_sync_ff2;
always @(posedge clk_2 or negedge reset_2) begin
    if (!reset_2) begin
        dst_sync_ff1 <= 1'b0;
        dst_sync_ff2 <= 1'b0;
        dst_toggle_d <= 1'b0;
    end
    else begin
        dst_sync_ff1 <= src_toggle;
        dst_sync_ff2 <= dst_sync_ff1;
        dst_toggle_d <= dst_sync_ff2;
    end
end
    assign pulse_out = dst_sync_ff2 ^ dst_toggle_d;

endmodule




