// Design a universal shift register. 

module q62 #(parameter N = 4)(
    input clk,
    input reset,
    input mode,

    input serial_in_msb,
    input serial_in_lsb,
    input [N-1:0] paralle,
    output reg [N-1:0] q,
    output reg serial_out_msb,
    output reg serial_out_lsb
);

always @ (posedge clk or posedge reset) begin
    if (reset) begin
        q <= {N{1'b0}};
    end
    else begin
        case (mode)
        2'b00: q <= q;

        2'b01: q<= {serial_in_msb, q[N-1:1]};

        2'b10: q<= {serial_in_lsb, q[N-2:1]};

        2'b11: q<= {paralle};
        endcase
    end
end
endmodule
