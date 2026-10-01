//Design a parity generator and checker.


module q172 # (parameter N = 8,
                parameter ODD_PARITY = 1'b0)(
                    input [N-1:0] data_in,
                    output parity_in,
                    output paraity_out,
                    output paraity_error
);

assign paraity_out = (^data_in) ^ ODD_PARITY;  // ^data_in --> reduction XOR (XORs all bits of data_in)
assign parity_error = (^data_in) ^ parity_in ^ ODD_PARITY;
endmodule
