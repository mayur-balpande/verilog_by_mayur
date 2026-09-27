//Design an N-bit carry-lookahead adder.
//N=8-bit
module q110 #(parameter WIDTH = 8)(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0]b,
    input carry_in,
    output reg [WIDTH-1:0] sum,
    output reg carry_out
);

localparam integer LEVELS = (WIDTH <=1) ? 0 : $clog2(WIDTH) ;

reg [WIDTH-1:0] propagate [0:LEVELS];
reg [WIDTH-1:0] generate_carry [0:LEVELS] ;
reg [WIDTH:0] carry;

assign propagate[0]     = a ^ b;
    assign generate_carry[0] = a & b;

    genvar level;
    genvar bit_index;

    generate
        for (level = 0; level < LEVELS; level = level + 1) begin : prefix_level
            localparam integer DISTANCE = 1 << level;

            for (bit_index = 0; bit_index < WIDTH;
                 bit_index = bit_index + 1) begin : prefix_bit
                if (bit_index >= DISTANCE) begin : combine
                    assign propagate[level+1][bit_index] =
                        propagate[level][bit_index] &
                        propagate[level][bit_index-DISTANCE];

                    assign generate_carry[level+1][bit_index] =
                        generate_carry[level][bit_index] |
                        (propagate[level][bit_index] &
                         generate_carry[level][bit_index-DISTANCE]);
                end else begin : pass_through
                    assign propagate[level+1][bit_index] =
                        propagate[level][bit_index];

                    assign generate_carry[level+1][bit_index] =
                        generate_carry[level][bit_index];
                end
            end
        end
    endgenerate

    assign carry[0] = carry_in;

    generate
        for (bit_index = 0; bit_index < WIDTH;
             bit_index = bit_index + 1) begin : carry_output
            assign carry[bit_index+1] =
                generate_carry[LEVELS][bit_index] |
                (propagate[LEVELS][bit_index] & carry_in);
        end
    endgenerate

    assign sum       = propagate[0] ^ carry[WIDTH-1:0];
    assign carry_out = carry[WIDTH];

endmodule
